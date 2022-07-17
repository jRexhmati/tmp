import { interfaces } from 'inversify';
import { Services } from 'booston-common';
import ServiceIdentifier = interfaces.ServiceIdentifier;
import GeneralOptionService from '../services/generalOption';

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
    service: GeneralOptionService,
    singleton: true,
  },
];

export default bindings;
