import axios from 'axios'
import { observable, action } from 'mobx'

import { API_URL } from '../constants'

export default class EstimateRequests {
  sessionsStore
  
  @observable estimate_requests
  @observable estimate_request
  
  constructor(sessionsStore) {
    this.sessionsStore = sessionsStore
    this.estimate_requests = []
    this.estimate_request = {}
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
  
  @action fetchShow(id) {
    let headers = this.sessionsStore.getAuthHeaders()
    let request = axios({
      method: 'GET',
      url: `${API_URL}/estimate_requests/${id}`,
      data: null,
      headers: headers
    })
    return request
  }
}
