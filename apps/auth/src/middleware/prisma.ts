import { Context, Next } from 'koa';
import { PrismaClient } from '@prisma/client';
import { Services } from 'booston-common';

declare module 'koa' {
  interface Context {
    prismaClient: PrismaClient;
  }
}

export default async function prismaClient(ctx: Context, next: Next) {
  const client: Services.DbClient = ctx.container.resolve(Services.DbClient);
  ctx.prismaClient = client.getInstance(PrismaClient, ctx.state.currentConnection.db_name);

  return next();
}
