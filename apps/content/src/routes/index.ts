import Router from '@koa/router';

import DesignOption from './designOption';

const ContentRouter = new Router({
  prefix: '/v1/content',
});

const AdminRouter = new Router({
  prefix: '/admin',
});
const PublicRouter = new Router({
  prefix: '/public',
});

PublicRouter.use(DesignOption.routes());

ContentRouter.use(AdminRouter.routes());
ContentRouter.use(PublicRouter.routes());

export default ContentRouter;
