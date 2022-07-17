import { PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Services } from 'booston-common';

export type USER_LEVEL = 1 | 2 | 3;
export const RECRUITER_LEVEL = 3;
export const MANAGER_LEVEL = 2;
export const ADMIN_LEVEL = 1;

@injectable()
export default class UserService {
  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  public static isAdmin(level: USER_LEVEL): boolean {
    return ADMIN_LEVEL === level;
  }
  public static isManager(level: USER_LEVEL): boolean {
    return level < RECRUITER_LEVEL;
  }

  public async getUserRecruiters(userId: number) {
    return (
      await this.db.user.findMany({
        select: {
          userRecruiters: {
            select: {
              recruiter: true,
            },
          },
        },
        where: {
          id: userId,
        },
      })
    )
      .map(item => item.userRecruiters.map(itm => itm.recruiter))
      .flat();
  }

  public async getUserRecruitersIds(userId: number) {
    return (await this.getUserRecruiters(userId)).map(recruiter => recruiter.id);
  }
}
