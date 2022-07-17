import { PrismaClient } from '@prisma/client';

export default class AtsService {
  private db: PrismaClient;

  public constructor(dc: PrismaClient) {
    this.db = dc;
  }

  async isAtsActive(): Promise<boolean> {
    const atsData = await this.db.generalOption.findFirst({
      where: {
        option_name: 'ats',
      },
    });

    if (atsData.option_value === '1') {
      return true;
    } else {
      return false;
    }
  }
}
