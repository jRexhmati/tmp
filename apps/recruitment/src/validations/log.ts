import { z } from 'zod';

export const LogListValidation = z.object({
  limit: z
    .string()
    .transform(val => parseInt(val))
    .refine(val => val >= 1)
    .refine(val => val <= 100),
  page: z
    .string()
    .transform(val => parseInt(val))
    .refine(val => val >= 1),
});

export default {
  LogListValidation,
};
