import Router from '@koa/router';

import Auth from './auth';

const AuthRouter = new Router({
  prefix: '/v1/authentication',
});

AuthRouter.use(Auth.routes());

export default AuthRouter;
