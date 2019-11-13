import axios from 'axios'
import { observable, action } from 'mobx'

import { API_URL } from '../constants'

export default class Articles {
  sessionsStore
  
  @observable estimate_requests
  
  constructor(sessionsStore) {
    this.sessionsStore = sessionsStore
    this.estimate_requests = []
  }
  
  @action fetchIndex() {
    let headers = this.sessionsStore.getAuthHeaders()
    axios({
      method: 'GET',
      url: `${API_URL}/estimate_requests`,
      data: null,
      headers: headers
    }).then((response) => {
      if (response.status == 200) {
        this.estimate_requests = response.data
      }
    })
  }
}
