import Router from '@koa/router';

import Workers from './workers';

const WorkersRouter = new Router({
  prefix: '/v1/workers',
});

const AdminRouter = new Router({
  prefix: '/admin',
});

AdminRouter.use(Workers.routes());

WorkersRouter.use(AdminRouter.routes());

export default WorkersRouter;
