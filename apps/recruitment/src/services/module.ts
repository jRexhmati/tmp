import { PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Services } from 'booston-common';

import { USER_LEVEL } from './user';

@injectable()
export default class ModuleService {
  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  /**
   * Check if module is visible for the given level
   * @param module
   * @param level
   */
  async isVisible(module: string, level: USER_LEVEL): Promise<boolean> {
    const permissions = await this.db.adminModule.findFirst({
      where: {
        slug: module,
      },
      include: {
        userPermissions: {
          select: {
            visible: true,
          },
          where: {
            user_role_id: level,
          },
        },
      },
    });

    return permissions?.userPermissions[0]?.visible === 1;
  }

  /**
   * Check if module is visible for the given level
   * @param module
   * @param level
   */
  async isActive(module: string, level: USER_LEVEL): Promise<boolean> {
    const permissions = await this.db.adminModule.findFirst({
      where: {
        slug: module,
      },
      include: {
        userPermissions: {
          select: {
            active: true,
          },
          where: {
            user_role_id: level,
          },
        },
      },
    });

    return permissions?.userPermissions[0]?.active === 1;
  }
}
