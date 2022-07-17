import Router from '@koa/router';

import Settings from './settings';

const SettingsRouter = new Router({
  prefix: '/v1/settings',
});

const AdminRouter = new Router({
  prefix: '/admin',
});
const PublicRouter = new Router({
  prefix: '/public',
});

AdminRouter.use(Settings.routes());

SettingsRouter.use(AdminRouter.routes());
SettingsRouter.use(PublicRouter.routes());

export default SettingsRouter;
