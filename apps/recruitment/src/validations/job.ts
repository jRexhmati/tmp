import { Validations } from 'booston-common';
import { z } from 'zod';

export const LatestValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const TopJobsValidation = z.object({
  limit: Validations.minNr(1) && Validations.maxNr(100),
});

export const MonthlyCountValidation = z.object({
  date: Validations.maxDate(new Date()),
});
