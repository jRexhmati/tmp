import { Queue } from 'bullmq';

console.log('Setter started');
const queue = new Queue('sync-ats', {
  connection: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT),
    password: process.env.REDIS_PASSWORD,
    username: process.env.REDIS_USERNAME,
  },
});

const queue2 = new Queue('booston-create-client', {
  connection: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT),
    password: process.env.REDIS_PASSWORD,
    username: process.env.REDIS_USERNAME,
  },
});

export const queueSetter = async (data: any) => {
  // await queue.drain();
  await queue.addBulk(data);
};

export const queueSetter2 = async (data: any) => {
  // await queue.drain();
  await queue2.addBulk(data);
};

// queue.add('cars', { color: 'blue' });
