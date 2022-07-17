import { z } from 'zod';

export const LoginValidation = z.object({
  username: z.string().max(1000).nonempty(),
  password: z.string().max(1000).nonempty(),
});
