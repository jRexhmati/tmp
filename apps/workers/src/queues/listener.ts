// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();

import { QueueEvents } from 'bullmq';

console.log({
  host: process.env.REDIS_HOST,
  port: parseInt(process.env.REDIS_PORT),
  password: process.env.REDIS_PASSWORD,
  username: process.env.REDIS_USERNAME,
});

const queueEvents = new QueueEvents('sync-ats', {
  connection: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT),
    password: process.env.REDIS_PASSWORD,
    username: process.env.REDIS_USERNAME,
  },
});

queueEvents.on('progress', ({ jobId, data }: any) => {
  // jobId received a progress event
  console.log('LISTENER progress --->', jobId, data);
});

queueEvents.on('completed', (job: any) => {
  console.log('LISTENER completed ---->', job);
});

queueEvents.on('failed', ({ jobId, failedReason }) => {
  console.error('LISTENER failed ---->', jobId, failedReason);
});
