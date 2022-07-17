import Koa from 'koa';
import bodyParser from 'koa-bodyparser';
import helmet from 'koa-helmet';
import cors from '@koa/cors';
import { Helpers, Middlewares } from 'booston-common';

import Router from './routes';

import 'reflect-metadata';

// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();

const app: Koa = new Koa();

Helpers.general.registerPrivateKeys(app);
// app.use(Middlewares.errorHandler);

/**
 * This sould not be public
 * There is going to  be a pingback for webhook support- the  only public - needs a rate limiter
 * The other actions should be invoked from crontab or other scripts
 * For email sending it will take into account the NODE_ENV - dev: send just to one address, prod: send to actual emails
 *
 * route: /type_of_action/action  {body: payload}
 * type of action: ATS, Webhook, Client, Facebook, GA (Google)
 * ATS/cron
 * ATS/status-update
 *
 * https://github.com/taskforcesh/bullmq
 *
 * https://github.com/hunterloftis/throng
 *
 */

app.use(cors({ origin: '*', allowHeaders: '*' }));
app.use(bodyParser());
app.use(helmet());
// app.use(Middlewares.authorizedUser);

// Define the routes
app.use(Router.routes()).use(Router.allowedMethods());

Helpers.https.listen(app, process.env.APP_PORT);

export default app;
