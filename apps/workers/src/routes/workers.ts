import { Context } from 'koa';
import { PrismaClient as PrismaForClients } from '@internal/prisma/client';
import Router from '@koa/router';
import { PrismaClient } from '@prisma/client';

import { queueSetter, queueSetter2 } from '../queues/setter';
import AtsService from '../services/ats';

const prismaForClients = new PrismaForClients();

// const prisma = new PrismaClient({
//   datasources: {
//     db: {
//       url: "new db url goes here",
//     },
//   },
// });

const Workers = new Router({
  prefix: '/ats',
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/workers/admin/ Get all general settings
 * @apiParam {boolean} includeSensitive
 * @apiGroup GeneralOption
 * @apiUse AuthHeaders
 *
 * @todo make the api public
 * @apiSuccess string
 */
Workers.get('/:clientSlug?', async (ctx: Context) => {
  const clientSlug = ctx?.params?.clientSlug;
  let allClients;

  if (clientSlug) {
    allClients = await prismaForClients.clients.findMany({
      where: {
        NOT: {
          status: 4,
        },
        AND: {
          slug: clientSlug as string,
        },
      },
    });
  } else {
    allClients = await prismaForClients.clients.findMany({
      where: {
        NOT: {
          status: 4,
        },
      },
    });
  }

  const clientsWithAtsSupport = allClients.map(clientInfo => {
    const { db_name, db_pass, db_username, name, slug } = clientInfo;
    const { DB_PORT } = process.env;

    return {
      name: 'ats',
      data: {
        clientName: name,
        clientSlug: slug,
        clientConnection: `mysql://${db_username}:${db_pass}@localhost:${DB_PORT}/${db_name}?schema=public`,
      },
      removeOnComplete: true,
      removeOnFail: 1000,
      priority: 1,
    };
  });

  const a = clientsWithAtsSupport?.filter(i => i);

  console.log('queue setter --->', a);

  await queueSetter(a);
  // await queueSetter2(a);

  ctx.body = allClients;
});

export default Workers;
