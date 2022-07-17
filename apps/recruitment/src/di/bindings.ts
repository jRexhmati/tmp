import { interfaces } from 'inversify';
import { Services } from 'booston-common';

import JobService from '../services/job';
import ModuleService from '../services/module';
import ServiceIdentifier = interfaces.ServiceIdentifier;
import ApplicationService from '../services/application';
import UserService from '../services/user';

export interface BindingType {
  service: ServiceIdentifier;
  singleton: boolean;
}

const bindings: BindingType[] = [
  {
    service: Services.DbClient,
    singleton: true,
  },
  {
    service: ModuleService,
    singleton: true,
  },
  {
    service: JobService,
    singleton: true,
  },
  {
    service: ApplicationService,
    singleton: true,
  },
  {
    service: UserService,
    singleton: true,
  },
];

export default bindings;
