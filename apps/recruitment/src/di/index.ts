import { Context, Next } from 'koa';
import { Container } from 'inversify';

import bindings, { BindingType } from './bindings';

export default function serviceContainer(ctx: Context, next: Next) {
  const container: Container = new Container();

  bindings.forEach((value: BindingType) => {
    const binding = container.bind(value.service).toSelf();
    if (value.singleton) {
      binding.inSingletonScope();
    }
  });
  ctx.container = container;

  return next();
}
