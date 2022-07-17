/**
 * @apiDefine AuthHeaders
 * @apiHeaderExample {json} Header-Example:
 *  {
 *    "authorization": "token-from-login",
 *    "client-domain": "preview.dev.booston.io"
 *  }
 * @apiHeader {String} authorization Authorization token returned by `/login`.
 * @apiHeader {String} client-domain Client Domain value.
 *
 * @apiErrorExample {json} AuthorizationHeader Error:
 *  HTTP/1.1 401 Not Authenticated
 *  {
 *    "error": "User Unauthenticated, no token provided / expired token"
 *  }
 * @apiError (Error 4xx) AuthorizationHeader The token provided is not valid.
 *
 * @apiErrorExample {json} ClientNotFoundError Error:
 *  {
 *    "error": "Data for client: xxx"
 *  }
 * @apiError (Error 4xx) ClientNotFound The `client-domain` is not found.
 *
 * @apiErrorExample {json} ClientDomainRequired Error:
 *  {
 *    "error": "Data for client: xxx"
 *  }
 * @apiError (Error 5xx) ClientDomainRequired The `client-domain` is required.
 */
