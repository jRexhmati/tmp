import { z } from 'zod';

export const TopRecruitersValidation = z.object({
  limit: z
    .string()
    .transform(val => parseInt(val))
    .refine(val => val >= 1)
    .refine(val => val <= 100),
});
