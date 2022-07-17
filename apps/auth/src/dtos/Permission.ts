export interface Permission {
  module: string | null;
  slug: string;
  parent: boolean | null;
  active: boolean | null;
  visible: boolean | null;
  read: boolean | null;
  create: boolean | null;
  edit: boolean | null;
  delete: boolean | null;
}
