import Koa from 'koa';
import bodyParser from 'koa-bodyparser';
import helmet from 'koa-helmet';
import cors from '@koa/cors';
import { Helpers, Middlewares } from 'booston-common';

import PrismaClient from './middleware/prisma';
import serviceContainer from './di';
import Router from './routes';

import 'reflect-metadata';

// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();

const app: Koa = new Koa();

Helpers.general.registerPrivateKeys(app);
app.use(Middlewares.errorHandler);
app.use(serviceContainer);
app.use(cors({ allowHeaders: '*', origin: '*' }));
app.use(bodyParser());
app.use(helmet());
app.use(Middlewares.clientSelection);
app.use(PrismaClient);
app.use(Middlewares.camelCase);

// Define the routes
app.use(Router.routes()).use(Router.allowedMethods());

Helpers.https.listen(app, process.env.APP_PORT);

export default app;
