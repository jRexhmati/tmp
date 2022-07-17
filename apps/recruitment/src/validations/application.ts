import { Validations } from 'booston-common';
import { z } from 'zod';

import { APPLICATION_PROGRESS } from '../services/application';

export const SearchValidation = z.object({
  date: Validations.maxDate(new Date()),
  initialStatus: z
    .string()
    .refine(
      val => Object.keys(APPLICATION_PROGRESS).includes(val),
      `Status must be on of ${Object.keys(APPLICATION_PROGRESS)}`,
    )
    .optional(),
  progress: z
    .string()
    .refine(
      val => Object.values(APPLICATION_PROGRESS).includes(parseInt(val)),
      `Status must be on of ${Object.values(APPLICATION_PROGRESS)}`,
    )
    .optional(),
  match: Validations.bool(),
  count: Validations.bool(),
});

export const MonthlySearchValidation = z.object({
  date: Validations.maxDate(new Date()),
  initialStatus: z
    .string()
    .refine(
      val => Object.keys(APPLICATION_PROGRESS).includes(val),
      `Value must be on of ${Object.keys(APPLICATION_PROGRESS)}`,
    )
    .optional(),
  progress: z
    .string()
    .refine(
      val => Object.values(APPLICATION_PROGRESS).includes(parseInt(val)),
      `Value must be on of ${Object.values(APPLICATION_PROGRESS)}`,
    )
    .optional(),
  match: Validations.bool(),
});

export const LatestLeadsValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const LatestApplicationsValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const LatestHiredValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const ApplyCountValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const LeadCountValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const HiredCountValidation = z.object({
  date: Validations.maxDate(new Date()),
});

export const IdValidation = z.object({
  id: z
    .string()
    .transform(val => parseInt(val))
    .refine(val => val >= 0),
});
