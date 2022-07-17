import { PrismaClient } from '@prisma/client';
import { Logger } from 'booston-common';
import { SandboxedJob } from 'bullmq';

// export default class AtsProcessor {
//   private db: PrismaClient;

//   constructor(connection: any) {
//     console.log(connection);
//     this.db = new PrismaClient({
//       datasources: {
//         db: {
//           url: connection.clientConnection,
//         },
//       },
//     });
//   }

//   async addJob(jobData: any) {
//     await this.db.job.create({
//       data: {
//         created_by: 17,
//         level: 0,
//         recruiter_id: 12,
//         active: 1,
//         boost: 0,
//         main_page_color: '[[main_page_color]]',
//         secondary_page_color: '[[secondary_page_color]]',
//       },
//     });
//     console.log('done aadding JOB ----- TO DB');
//     // console.time('test-1');
//     // const delayPromise = (ms: number) => new Promise(res => setTimeout(res, ms));
//     // await delayPromise(10000);
//     // console.log('Add Job', jobData);
//     // console.timeEnd('test-1');
//   }

//   async updateJob(jobId: number, jobData: any) {
//     console.log('update job');
//   }
// }
module.exports = async (job: SandboxedJob) => {
  const { clientName, clientSlug, clientConnection } = job?.data || {};
  let isAts = false;
  Logger.log(`Started job for client: ${clientName}`, 'info');

  const prismaDb = new PrismaClient({
    datasources: {
      db: {
        url: clientConnection,
      },
    },
  });

  const atsData = await prismaDb.generalOption.findFirst({
    where: {
      option_name: 'ats',
    },
  });

  if (atsData.option_value === '1') {
    isAts = true;
  }

  if (isAts) {
    Logger.log(`Client: ${clientName} has ats support- do stuff here`, 'info');
  } else {
    Logger.log(`Client: ${clientName} does NOT have ATS support`, 'info');
  }
  const delayPromise = (ms: number) => new Promise(res => setTimeout(res, ms));
  await delayPromise(1000);
  await prismaDb.$disconnect();
};
