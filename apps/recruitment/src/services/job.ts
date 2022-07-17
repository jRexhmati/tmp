import { Prisma, PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Helpers, Services } from 'booston-common';
import { format } from 'date-fns';

@injectable()
export default class JobService {
  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  /**
   * Returns number of jobs last 12 months
   * {month_nam: number}
   */
  async jobsPerMonth(date: Date, recruiterIds: number[] | null) {
    const formattedDate = format(date, 'y-M-d');
    type QueryType = { period: string; nr: number }[];

    const res = (await this.db
      .$queryRaw`select DATE_FORMAT(created, '%b') as period, count(*) as nr from jobs where created > ${formattedDate}
        ${
          recruiterIds !== null
            ? Prisma.sql` AND recruiter_id in (${Prisma.join([-1, ...recruiterIds])}) `
            : Prisma.empty
        }
        group by DATE_FORMAT(created, '%y-%b')`) as QueryType;

    const data = Helpers.date.getPeriod(date, new Date(), 'MMM');

    return res.reduce((acc, item) => {
      acc[item.period] = item.nr;
      return acc;
    }, data);
  }
}
