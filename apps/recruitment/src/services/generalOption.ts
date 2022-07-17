import { PrismaClient } from '@prisma/client';
import { inject, injectable } from 'inversify';
import { Services } from 'booston-common';

type SettingsType = Record<string, string | number>;

// @todo move the sensitivity level to database
export const RECRUITER_ROLE_FIELDS = ['ats', 'main_language', 'booston_version'];
export const MANAGER_ROLE_FIELDS: string[] = [];
export const ADMIN_ROLE_FIELDS: string[] = [];

@injectable()
export default class GeneralOptionService {
  public settings: SettingsType;

  private db: PrismaClient;

  public constructor(@inject(Services.DbClient) dc: Services.DbClient) {
    this.db = dc.getInstance(PrismaClient);
  }

  /**
   * Get a single option or all options from general_option
   * @param settingName
   */
  async getSetting(settingName: string): Promise<null | string | number> {
    const setting = await this.db.generalOption.findFirst({
      where: {
        option_name: settingName,
      },
    });

    return setting?.option_value || null;
  }

  /**
   * Get all options
   */
  async getSettings(fields: string[] = []): Promise<string | SettingsType> {
    return this.getFormattedSettings(fields);
  }

  /**
   * Get structured general setinngs
   * @private
   */
  private async getFormattedSettings(fields: string[] = []): Promise<SettingsType> {
    const settings = await this.db.generalOption.findMany({});

    return settings.reduce((acc, item) => {
      if (!fields.includes(item.option_name)) {
        return acc;
      }
      acc[item.option_name] = item.option_value;

      return acc;
    }, {} as SettingsType);
  }
}
