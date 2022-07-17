export default class CarerixConnector {
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  constructor(authData: any) {}

  /**
   * Compare previous result with current data to determin what needs updating
   */
  async checkForUpdates() {
    //we will convert to json and store it on the server, get a json / json comparison to get out the items that needs updating
    console.log('get full data');
  }

  /**
   * Check the job if it's found in the DB in order to perform an update or insert
   * @param job any
   */
  async checkJob(job: any) {
    console.log('check jobs');
  }

  /**
   * Check if the recruiter exists in the db in order to perform an update or insert
   * @param recruiter any
   */
  async checkRecruiter(recruiter: any) {
    console.log('check recruiter');
  }

  /**
   * Check the attributes in order to perform an update or insert
   * @param attr any
   * @param locale string
   */
  async checkAttr(attr: any, locale: string) {
    console.log('attr check');
  }

  /**
   * Will determin if the job is in the db and insert or updaate
   */
  async processJobs() {
    console.log('process job');
  }

  async processRecruiter() {
    console.log('insert or update recruiter');
  }

  async processAttrs() {
    console.log('insert or update an attribute');
  }

  async pushCandidate() {
    console.log('push candidate to carerix');
  }

  async getCandidate() {
    console.log('get candidatte');
  }
}
