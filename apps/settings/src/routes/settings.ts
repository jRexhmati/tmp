import { Context } from 'koa';
import Router from '@koa/router';
import { Container } from 'inversify';
import { Exceptions, Middlewares } from 'booston-common';

import GeneralOptionService, {
  ADMIN_ROLE_FIELDS,
  MANAGER_ROLE_FIELDS,
  RECRUITER_ROLE_FIELDS,
} from '../services/generalOption';
import ModuleService from '../services/module';
import { SingleOptionValidation } from '../validations/generalOption';

const Settings = new Router({
  prefix: '/general-options',
});

Settings.use(async (ctx, next) => {
  return Middlewares.moduleAuthorization(
    ctx as unknown as Context,
    next,
    'recruiter',
    ctx.state.authUser.level,
    (ctx.container as Container).resolve(ModuleService),
    ctx.request.path,
    [/settings\/admin\/general-options/],
  );
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/settings/admin/general-options/app-settings Get all general settings
 * @apiParam {boolean} includeSensitive
 * @apiGroup GeneralOption
 * @apiUse AuthHeaders
 *
 * @todo make the api public
 * @apiSuccess string
 */
Settings.get('/app-settings', async (ctx: Context) => {
  const gs = ctx.container.resolve(GeneralOptionService);
  const settingFields = RECRUITER_ROLE_FIELDS;
  if (ctx.state.authUser.level < 3) {
    settingFields.push(...MANAGER_ROLE_FIELDS);
  }
  if (ctx.state.authUser.level < 2) {
    settingFields.push(...MANAGER_ROLE_FIELDS);
  }

  ctx.body = await gs.getSettings(settingFields);
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/settings/admin/general-options/:param Get a single general setting
 * @apiParam {number} param
 * @apiGroup GeneralOption
 * @apiUse AuthHeaders
 *
 * @apiSuccess string
 */
Settings.get(
  '/:optionName?',
  Middlewares.validate(SingleOptionValidation, 'params'),
  async (ctx: Context) => {
    const gs = ctx.container.resolve(GeneralOptionService);

    if (MANAGER_ROLE_FIELDS.includes(ctx.params.optionName) && ctx.state.authUser.level > 2) {
      // Todo create a forbidden exception
      throw new Exceptions.Http.NotFound('Option not found');
    }
    if (
      // Todo create a forbidden exception
      ADMIN_ROLE_FIELDS.includes(ctx.params.optionName) &&
      ctx.state.authUser.level > 1
    ) {
      throw new Exceptions.Http.NotFound('Option not found');
    }

    ctx.body = await gs.getSetting(ctx.params.optionName);
  },
);

export default Settings;
