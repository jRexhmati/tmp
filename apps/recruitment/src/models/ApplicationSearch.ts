export default class ApplicationSearch {
  constructor(
    public created: Date,
    public progress?: number,
    public initialStatus?: string,
    public match?: boolean,
    public count?: boolean,
    public recruiterIds: number[] | null = null,
    public showOpenApplications: boolean | null = null,
  ) {}
}
