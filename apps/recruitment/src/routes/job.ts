import { Context } from 'koa';
import Router from '@koa/router';
import { Prisma } from '@prisma/client';
import { Container } from 'inversify';
import { Middlewares } from 'booston-common';
import { z } from 'zod';

import GeneralOptionService from '../services/generalOption';
import JobService from '../services/job';
import ModuleService from '../services/module';
import UserService from '../services/user';
import { LatestValidation, MonthlyCountValidation, TopJobsValidation } from '../validations/job';

const Jobs = new Router({
  prefix: '/jobs',
});

Jobs.use(async (ctx, next) => {
  return Middlewares.moduleAuthorization(
    ctx as unknown as Context,
    next,
    'job', // Slug of the module which this service belongs to
    ctx.state.authUser.level,
    (ctx.container as Container).resolve(ModuleService),
    ctx.request.path,
    [/recruitment\/admin\/jobs/],
  );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/jobs List of all jobs
 * @apiGroup Job
 * @apiUse AuthHeaders
 *
 * @apiSuccess {Job[]} result
 */
Jobs.get('/', async (ctx: Context) => {
  let recruiterFilter = {};
  const userService = ctx.container.resolve(UserService) as UserService;

  if (!UserService.isManager(ctx.state.authUser.level)) {
    recruiterFilter = {
      where: {
        recruiter_id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
      },
    };
  }

  ctx.body = await ctx.prismaClient.job.findMany(recruiterFilter);
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/jobs/latest/count Nr of latest jobs
 * @apiParam (Get params) {DateTime} date Date to start counting jobs from
 * @apiGroup Job
 * @apiUse AuthHeaders
 *
 * @apiSuccess {number} total
 */
Jobs.get('/latest/count', Middlewares.validate(LatestValidation, 'query'), async (ctx: Context) => {
  ctx.state.skipCamelize = true;
  const body: z.infer<typeof LatestValidation> = ctx.request.query;
  let recruiterFilter = {};
  const userService = ctx.container.resolve(UserService) as UserService;

  if (!UserService.isManager(ctx.state.authUser.level)) {
    recruiterFilter = {
      recruiter_id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
    };
  }

  const total = await ctx.prismaClient.job.count({
    where: {
      created: {
        gt: new Date(body.date),
      },
      ...recruiterFilter,
    },
  });
  ctx.body = {
    total,
  };
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/jobs/monthly-count Nr of jobs monthly for the last 12 months
 * @apiGroup Job
 * @apiUse AuthHeaders
 *
 * @apiSuccess {Object} result Months short and their total
 * @apiSuccess {number} result.Jan
 * @apiSuccess {number} result.Feb
 * @apiSuccess {number} result.March
 * @apiSuccess {number} result.May
 * @apiSuccess {etc} result.rest
 */
Jobs.get(
  '/monthly-count',
  Middlewares.validate(MonthlyCountValidation, 'query'),
  async (ctx: Context) => {
    ctx.state.skipCamelize = true;
    const body: z.infer<typeof MonthlyCountValidation> = ctx.request.query;
    const jobService = ctx.container.get(JobService);
    const userService = ctx.container.resolve(UserService) as UserService;
    let userRecruiters: number[] | null = null;

    if (!UserService.isManager(ctx.state.authUser.level)) {
      userRecruiters = await userService.getUserRecruitersIds(ctx.state.authUser.id);
    }

    ctx.body = await jobService.jobsPerMonth(new Date(body.date), userRecruiters);
  },
);

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/jobs/top top job records
 * @apiGroup Job
 * @apiParam (Get params) {number} limit Nr of top jobs
 * @apiUse AuthHeaders
 *
 * @apiSuccess {Object[]} months list of jobs and the total of applications
 * @apiSuccess {string} TopJob.name
 * @apiSuccess {number} TopJob.applications
 */
Jobs.get('/top', Middlewares.validate(TopJobsValidation, 'query'), async (ctx: Context) => {
  const body: z.infer<typeof TopJobsValidation> = ctx.request.query;
  const gs: GeneralOptionService = ctx.container.resolve(GeneralOptionService);
  const mainLanguage: string = (await gs.getSetting('main_language')) as string;
  let recruiterFilter = {};
  const userService = ctx.container.resolve(UserService) as UserService;

  if (!UserService.isManager(ctx.state.authUser.level)) {
    recruiterFilter = {
      recruiter_id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
    };
  }

  ctx.body = await ctx.prismaClient.job.findMany({
    include: {
      jobContents: {
        where: {
          language: { equals: mainLanguage },
        },
      },
      applications: true,
    },
    where: {
      ...recruiterFilter,
      jobContents: {
        some: { language: { equals: 'nl' } },
      },
    },
    take: parseInt(String(body.limit), 10),
  });
});

export default Jobs;
