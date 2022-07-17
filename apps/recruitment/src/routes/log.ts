import { Context } from 'koa';
import Router from '@koa/router';
import { Container } from 'inversify';
import { Middlewares } from 'booston-common';

import ModuleService from '../services/module';
import { LogListValidation } from '../validations/log';

const Log = new Router({
  // Related to 'admin_modules' table
  prefix: '/log',
});

Log.use(async (ctx, next) => {
  return Middlewares.moduleAuthorization(
    ctx as unknown as Context,
    next,
    'ats_log',
    ctx.state.authUser.level,
    (ctx.container as Container).resolve(ModuleService),
    ctx.request.path,
    [/recruitment\/admin\/log/],
  );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/recruitment/admin/log List of all logs
 * @apiParam (Get params) {int} limit Limit number
 * @apiParam (Get params) {int} page Page number
 * @apiGroup Log
 * @apiUse AuthHeaders
 *
 * @apiSuccess Log[]
 */
Log.get('/', Middlewares.validate(LogListValidation, 'query'), async (ctx: Context) => {
  ctx.state.skipCamelize = true;

  const data = await ctx.prismaClient.atsLog.findMany({
    take: parseInt(ctx.query.limit as string, 10),
    skip: (parseInt(ctx.query.page as string, 10) - 1) * parseInt(ctx.query.limit as string, 10),
    orderBy: {
      created: 'desc',
    },
  });
  const total = await ctx.prismaClient.atsLog.count({});

  ctx.body = {
    total,
    data,
  };
});

export default Log;
