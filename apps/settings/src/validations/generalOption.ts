import { z } from 'zod';

export const SingleOptionValidation = z.object({
  optionName: z.string(),
});

export default {
  SingleOptionValidation,
};
