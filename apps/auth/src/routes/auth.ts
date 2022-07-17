import { Context } from 'koa';
import Router from '@koa/router';
import { Exceptions, Middlewares, Services } from 'booston-common';
import crypto from 'crypto';
import jwt from 'jsonwebtoken';
import { z } from 'zod';

import { User } from '../services';
import { LoginValidation } from '../validations/auth';

const Auth = new Router({
  prefix: '/auth',
});

/**
 * @apiVersion 0.1.0
 * @api {post} /v1/authentication/auth/login Login api
 * @apiBody {string} username Email
 * @apiBody {string} password Password
 * @apiHeader {string} client-domain Client Domain
 * @apiGroup Auth
 *
 * @apiSuccess {error} boolean
 * @apiSuccess {token} string
 *
 * @apiErrorExample {json} AuthorizationHeader Error:
 *  HTTP/1.1 400 Bad Credentials
 *  {
 *    "error": "Email or password is not valid"
 *  }
 * @apiError (Error 4xx) AuthorizationHeader The token provided is not valid.
 *
 * @apiErrorExample {json} ClientDomain Error:
 *  HTTP/1.1 500 Header: `client-domain` is missing
 *  {
 *    "error": "Please define the domain in the header with the header value 'client-domain'"
 *  }
 * @apiError (Error 5xx) Client Domain missing
 */
Auth.post('/login', Middlewares.validate(LoginValidation, 'request.body'), async (ctx: Context) => {
  const body: z.infer<typeof LoginValidation> = ctx.request.body;

  const email = body.username;
  const password = body.password;
  const secret = process.env.APP_PRIVATE_KEY as string;

  const encodedPassword = crypto
    .createHash('sha512')
    .update(password + secret, 'utf-8')
    .digest('hex');

  const user = await ctx.prismaClient.user.findFirst({
    where: {
      email: { equals: email },
      password: { equals: encodedPassword },
    },
  });

  if (!user) {
    throw new Exceptions.Http.BadRequest('Email or password is not valid');
  }

  const adminModules = await ctx.prismaClient.userPermission.findFirst({
    where: {
      user_role_id: user.level,
      visible: 1,
      active: 1,
    },
    include: {
      adminModule: true,
    },
  });

  const token = jwt.sign(Services.Jwt.encodeUser(user, ctx.state.clientUrl), ctx.private_key, {
    expiresIn: 7200,
    algorithm: 'RS256',
  });

  ctx.body = {
    error: false,
    token,
    redirectUrl: adminModules?.adminModule?.url,
  };
});

/**
 * @apiVersion 0.1.0
 * @api {get} /v1/authentication/auth/me Get User Information
 * @apiGroup Auth
 * @apiUse AuthHeaders
 *
 */
Auth.get('/me', Middlewares.authorizedUser, async (ctx: Context) => {
  const userService: User = ctx.container.resolve(User);
  ctx.body = {
    ...ctx.state.authUser,
    permissions: await userService.getLevelPermissions(ctx.state.authUser.level),
  };
});

export default Auth;
