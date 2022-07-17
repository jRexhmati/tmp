import { Context } from 'koa';
import Router from '@koa/router';
import { Container } from 'inversify';
import { Middlewares } from 'booston-common';
import { z } from 'zod';

import ModuleService from '../services/module';
import UserService from '../services/user';
import { TopRecruitersValidation } from '../validations/recruiter';

const Recruiter = new Router({
  prefix: '/recruiters',
});

Recruiter.use(async (ctx, next) => {
  return Middlewares.moduleAuthorization(
    ctx as unknown as Context,
    next,
    'recruiter',
    ctx.state.authUser.level,
    (ctx.container as Container).resolve(ModuleService),
    ctx.request.path,
    [/recruitment\/admin\/recruiters/],
  );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/recruiters/top top recruiter records
 * @apiParam (Get params) {number} limit Nr of top jobs
 * @apiGroup Recruiter
 * @apiUse AuthHeaders
 *
 */
Recruiter.get(
  '/top',
  Middlewares.validate(TopRecruitersValidation, 'query'),
  async (ctx: Context) => {
    const body: z.infer<typeof TopRecruitersValidation> = ctx.request.query;
    let recruiterFilter = {};
    const userService = ctx.container.resolve(UserService) as UserService;

    if (!UserService.isManager(ctx.state.authUser.level)) {
      recruiterFilter = {
        id: { in: await userService.getUserRecruitersIds(ctx.state.authUser.id) },
      };
    }

    ctx.body = await ctx.prismaClient.recruiter.findMany({
      where: {
        ...recruiterFilter,
        recruiterContents: {
          every: {
            slug: {
              not: 'unassigned',
            },
          },
        },
      },
      include: {
        jobs: {
          select: {
            id: true,
            applications: {
              select: {
                id: true,
              },
            },
          },
        },
        recruiterContents: {
          select: {
            page_title: true,
            language: true,
          },
        },
      },
      take: parseInt(String(body.limit), 10),
    });
  },
);

export default Recruiter;
