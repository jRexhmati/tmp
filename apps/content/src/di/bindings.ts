import { interfaces } from 'inversify';
import { Services } from 'booston-common';
import ServiceIdentifier = interfaces.ServiceIdentifier;

export interface BindingType {
  service: ServiceIdentifier;
  singleton: boolean;
}

const bindings: BindingType[] = [
  {
    service: Services.DbClient,
    singleton: true,
  },
];

export default bindings;
