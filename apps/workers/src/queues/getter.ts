import { Worker } from 'bullmq';
import path from 'path';

const processorExtension = process.env.NODE_ENV === 'development' ? 'ts' : 'js';

const processorFile = path.join(__dirname, `../processors/Ats.${processorExtension}`);

console.log('processor file path', processorFile);
const worker = new Worker('sync-ats', processorFile, {
  concurrency: 3,
  connection: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT),
    password: process.env.REDIS_PASSWORD,
    username: process.env.REDIS_USERNAME,
  },
});

const worker2 = new Worker(
  'booston-create-client',
  async job => {
    console.log('booston-create-client');
  },
  {
    concurrency: 1,
    connection: {
      host: process.env.REDIS_HOST,
      port: parseInt(process.env.REDIS_PORT),
      password: process.env.REDIS_PASSWORD,
      username: process.env.REDIS_USERNAME,
    },
  },
);

worker.on('error', (failedReason: Error) => {
  console.log('Getter Error', failedReason);
});

console.log('Getter started');
