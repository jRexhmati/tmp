import { Prisma, PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Helpers, Services } from 'booston-common';
import { format } from 'date-fns';

import ApplicationSearch from '../models/ApplicationSearch';

export const APPLICATION_PROGRESS = {
  Lead: 1,
  Application: 2,
  'No Contact': 3,
  Contact: 4,
  'No potential for us': 6,
  'No reaction back': 7,
  Appointment: 8,
  'Presented to team': 9,
  'Presented to client': 10,
  'Rejected by team': 11,
  'Rejected by client': 12,
  'Candidate withdraw': 13,
  Hired: 15,
};

interface ApplicationSearchQuery {
  where: Prisma.ApplicationWhereInput;
}

@injectable()
export default class ApplicationService {
  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  async applicationsPerMonth(search: ApplicationSearch) {
    const equalOperator = search.match;
    const formattedDate = format(search.created, 'y-M-d');
    const operator = equalOperator ? Prisma.sql`=` : Prisma.sql`!=`;
    // Optional progress query
    const progressQuery = search.progress
      ? Prisma.sql`and progress ${operator} ${search.progress}`
      : Prisma.empty;
    // Optional initial status query
    const initialStatusQuery = search.initialStatus
      ? Prisma.sql`and initial_status ${operator} ${search.initialStatus}`
      : Prisma.empty;
    // Optional recruiter query
    const recruiterIdsQuery =
      search.recruiterIds !== null
        ? Prisma.sql`and (recruiters.id in (${Prisma.join([-1, ...search.recruiterIds])}) ${
            search.showOpenApplications ? Prisma.sql`OR job_id is null` : Prisma.empty
          })`
        : Prisma.empty;

    type QueryType = { period: string; nr: number }[];
    // Native query to use mysql grouping by date, prisma does not support it
    const res = await this.db
      .$queryRaw<QueryType>`select DATE_FORMAT(applications.created, '%b') as period, count(*) as nr from applications
          ${
            search.recruiterIds !== null
              ? Prisma.sql`INNER JOIN jobs on jobs.id = applications.job_id INNER JOIN recruiters on recruiters.id = jobs.recruiter_id`
              : Prisma.empty
          }
          where applications.created > ${formattedDate} ${progressQuery} ${initialStatusQuery} ${recruiterIdsQuery} 
          group by DATE_FORMAT(applications.created, '%b')`;

    const data = Helpers.date.getPeriod(search.created, new Date(), 'MMM');

    return res.reduce((acc, item) => {
      acc[item.period] = item.nr;
      return acc;
    }, data);
  }

  async search(searchObj: ApplicationSearch) {
    const query: ApplicationSearchQuery = { where: {} };

    if (searchObj.created) {
      query.where.created = { gt: searchObj.created };
    }

    if (searchObj.progress) {
      query.where.progress = searchObj.match ? searchObj.progress : { not: searchObj.progress };
    }

    if (searchObj.initialStatus) {
      query.where.initial_status = searchObj.match
        ? searchObj.initialStatus
        : { not: searchObj.initialStatus };
    }

    if (searchObj.recruiterIds !== null) {
      let openApplicationFilter = {};
      if (searchObj.showOpenApplications !== null) {
        openApplicationFilter = { job_id: searchObj.showOpenApplications ? null : { not: null } };
      }

      query.where.OR = [
        {
          job: {
            recruiter: {
              id: {
                in: searchObj.recruiterIds,
              },
            },
          },
        },
        openApplicationFilter,
      ];
    }

    return searchObj.count
      ? { total: await this.db.application.count(query) }
      : await this.db.application.findMany(query);
  }
}
