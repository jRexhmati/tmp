import { PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Services } from 'booston-common';
import { USER_LEVEL } from 'booston-common/lib/types/user';

import { Permission } from '../dtos/Permission';

@injectable()
export class User {
  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  /**
   * Returns module permissions based on the level
   * @param level
   */
  async getLevelPermissions(level: USER_LEVEL): Promise<Permission[]> {
    const adminModules = await this.db.adminModule.findMany({
      include: {
        userPermissions: true,
      },
    });
    return adminModules.map(item => {
      const userRole = item.userPermissions.find(item => item.user_role_id === level);

      return {
        module: item.url || item.slug,
        slug: item.slug,
        parent: !item.parent_id,
        active: !!userRole?.active,
        visible: !!userRole?.visible,
        read: !!userRole?.read_rights,
        create: !!userRole?.create_rights,
        edit: !!userRole?.edit_rights,
        delete: !!userRole?.delete_rights,
      };
    }, []);
  }
}
