import { Context } from 'koa';
import Router from '@koa/router';
import { Container } from 'inversify';
import { Exceptions, Middlewares } from 'booston-common';
import { z } from 'zod';

import ApplicationSearch from '../models/ApplicationSearch';
import ApplicationService from '../services/application';
import ModuleService from '../services/module';
import UserService from '../services/user';
import {
  IdValidation,
  MonthlySearchValidation,
  SearchValidation,
} from '../validations/application';

const Applications = new Router({
  prefix: '/applications',
});

Applications.use(async (ctx, next) => {
  return Middlewares.moduleAuthorization(
    ctx as unknown as Context,
    next,
    'application',
    ctx.state.authUser.level,
    (ctx.container as Container).resolve(ModuleService),
    ctx.request.path,
    [/recruitment\/admin\/applications/],
  );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/applications List of all applications
 * @apiGroup Application
 * @apiUse AuthHeaders
 *
 * @apiSuccess Application[]
 */
Applications.get('/', async (ctx: Context) => {
  let recruiterFilter = {};
  const userService = ctx.container.resolve(UserService) as UserService;

  if (!UserService.isManager(ctx.state.authUser.level)) {
    let openApplicationFilter = {};
    if (ctx.state.authUser.showOpenApplications) {
      openApplicationFilter = {
        job_id: ctx.state.authUser.showOpenApplications ? null : { not: null },
      };
    }

    recruiterFilter = {
      where: {
        OR: [
          {
            job: {
              recruiter_id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
            },
          },
          openApplicationFilter,
        ],
      },
    };
  }

  ctx.body = await ctx.prismaClient.application.findMany(recruiterFilter);
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/applications/search List of all applications
 * @apiGroup Application
 * @apiUse AuthHeaders
 *
 * @apiSuccess Application[]
 */
Applications.get(
  '/search',
  Middlewares.validate(SearchValidation, 'query'),
  async (ctx: Context) => {
    const body: z.infer<typeof SearchValidation> = ctx.request.query;

    const search = new ApplicationSearch(new Date(body.date));
    search.progress = parseInt(body.progress);
    search.initialStatus = body.initialStatus;
    search.match = !!parseInt(body.match);
    search.count = !!parseInt(body.count);
    const userService: UserService = ctx.container.get(UserService);

    if (!UserService.isManager(ctx.state.authUser.level)) {
      search.recruiterIds = await userService.getUserRecruitersIds(ctx.state.authUser.id);
      search.showOpenApplications = ctx.state.authUser.showOpenApplications;
    }

    const applicationService: ApplicationService = ctx.container.get(ApplicationService);
    ctx.body = await applicationService.search(search);
  },
);

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/applications/monthly-count List of all applications
 * @apiGroup Application
 * @apiUse AuthHeaders
 *
 * @apiSuccess {Object} result Months short and their total
 * @apiSuccess {number} result.Jan
 * @apiSuccess {number} result.Feb
 * @apiSuccess {number} result.March
 * @apiSuccess {number} result.May
 * @apiSuccess {etc} result.rest
 */
Applications.get(
  '/monthly-count',
  Middlewares.validate(MonthlySearchValidation, 'query'),
  async (ctx: Context) => {
    ctx.state.skipCamelize = true;
    const body: z.infer<typeof MonthlySearchValidation> = ctx.request.query;
    const applicationService: ApplicationService = ctx.container.get(ApplicationService);
    const userService: UserService = ctx.container.get(UserService);
    const search = new ApplicationSearch(new Date(body.date));

    if (!UserService.isManager(ctx.state.authUser.level)) {
      search.recruiterIds = await userService.getUserRecruitersIds(ctx.state.authUser.id);
      search.showOpenApplications = ctx.state.authUser.showOpenApplications;
    }

    search.progress = parseInt(body.progress);
    search.initialStatus = body.initialStatus;
    search.match = !!parseInt(body.match);

    ctx.body = await applicationService.applicationsPerMonth(search);
  },
);

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/applications/:id Show single application
 * @apiGroup Application
 * @apiParam id Id of application
 * @apiUse AuthHeaders
 *
 * @apiSuccess Application
 *
 */
Applications.get('/:id', Middlewares.validate(IdValidation, 'params'), async (ctx: Context) => {
  let recruiterFilter = {};
  const userService = ctx.container.resolve(UserService) as UserService;

  if (!UserService.isManager(ctx.state.authUser.level)) {
    let openApplicationFilter = {};
    if (ctx.state.authUser.showOpenApplications) {
      openApplicationFilter = {
        job_id: ctx.state.authUser.showOpenApplications ? null : { not: null },
      };
    }

    recruiterFilter = {
      OR: [
        {
          job: {
            recruiter_id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
          },
        },
        openApplicationFilter,
      ],
    };
  }

  const application = await ctx.prismaClient.application.findFirst({
    where: {
      ...recruiterFilter,
      id: parseInt(ctx.params.id, 10),
    },
  });
  if (!application) {
    throw new Exceptions.Http.NotFound('Application not found');
  }
  ctx.body = application;
});

export default Applications;
