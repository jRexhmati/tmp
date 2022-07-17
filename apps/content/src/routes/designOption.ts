import { Context } from 'koa';
import Router from '@koa/router';
import { Container } from 'inversify';
import { Middlewares } from 'booston-common';

import ModuleService from '../services/module';
import { SingleOptionValidation } from '../validations/generalOption';

const DesignOptions = new Router({
  prefix: '/design-options',
});

DesignOptions.use(async (ctx, next) => {
  // Public api atm
  return next();
  // return Middlewares.moduleAuthorization(
  //   ctx as unknown as Context,
  //   next,
  //   'design', // Slug of the module which this service belongs to
  //   ctx.state.authUser.level,
  //   (ctx.container as Container).resolve(ModuleService),
  //   ctx.request.path,
  //   [/content\/public\/design-options/],
  // );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/content/public/design-options Get all general settings
 * @apiGroup DesignOption
 * @apiUse AuthHeaders
 *
 * @apiSuccess string
 */
DesignOptions.get('/', async (ctx: Context) => {
  ctx.body = await ctx.prismaClient.designOption.findMany();
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/content/public/design-options/:optionName Get a single design setting
 * @apiParam {string} optionName
 * @apiGroup DesignOption
 * @apiUse AuthHeaders
 *
 * @apiSuccess string
 */
DesignOptions.get(
  '/:optionName',
  Middlewares.validate(SingleOptionValidation, 'params'),
  async (ctx: Context) => {
    ctx.body = await ctx.prismaClient.designOption.findFirst({
      where: { option_name: ctx.params.optionName },
    });
  },
);

export default DesignOptions;
