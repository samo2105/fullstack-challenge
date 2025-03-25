import Route from '@ember/routing/route'
import { inject as service } from '@ember/service'
import { groupEventsByDay } from '../helpers/eventsHelper'

export default class IndexRoute extends Route {
  @service
  apolloService

  beforeModel () {}

  async model (params) {
    const model = await this.apolloService.fetchAllEvents()
    return groupEventsByDay(model)
  }
}
