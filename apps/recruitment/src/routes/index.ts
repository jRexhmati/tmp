import Router from '@koa/router';

import Application from './application';
import Job from './job';
import Log from './log';
import Recruiter from './recruiter';

const RecruitmentRouter = new Router({
  prefix: '/v1/recruitment',
});

const AdminRouter = new Router({
  prefix: '/admin',
});
const PublicRouter = new Router({
  prefix: '/public',
});

AdminRouter.use(Job.routes());
AdminRouter.use(Application.routes());
AdminRouter.use(Log.routes());
AdminRouter.use(Recruiter.routes());

RecruitmentRouter.use(AdminRouter.routes());
RecruitmentRouter.use(PublicRouter.routes());

export default RecruitmentRouter;
