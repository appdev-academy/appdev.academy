import React from 'react'
import { inject, observer } from 'mobx-react'

import ObjectPresence from './ObjectPresence'

@inject('estimateRequestsStore')
@observer
export default class Show extends React.Component {
  
  componentDidMount() {
    let estimateRequestID = this.props.match.params.estimateRequestID
    this.props.estimateRequestsStore.fetchShow(estimateRequestID).then( response => {
      if (response.status == 200) {
        this.props.estimateRequestsStore.estimate_request = response.data
      }
    })
  }
  
  render() {
    let estimateRequest = this.props.estimateRequestsStore.estimate_request
    let download_link = (estimateRequest.document) ? <td><a href={ estimateRequest.document } download>Click to download</a></td> : <td>-</td>
    
    return(
      <div className='full-width'>
        <table className='estimate-request-details'>
          <tbody>
            <tr>
              <td>ID:</td>
              <td>{ estimateRequest.id }</td>
            </tr>
            <tr>
              <td>Created at:</td>
              <td>{ estimateRequest.created_at }</td>
            </tr>
            <tr>
              <td>Email</td>
              <td>{ estimateRequest.email }</td>
            </tr>
            <tr>
              <td>Name</td>
              <td>{ estimateRequest.name }</td>
            </tr>
            <tr>
              <td>Company</td>
              <td>{ estimateRequest.company }</td>
            </tr>
            <tr>
              <td>Subject</td>
              <td>{ estimateRequest.subject }</td>
            </tr>
            <tr>
              <td>Budget</td>
              <td>{ estimateRequest.budget }</td>
            </tr>
            <tr>
              <td>Deadline</td>
              <td>{ estimateRequest.deadline }</td>
            </tr>
            <tr>
              <td>IOS</td>
              <td><ObjectPresence mark={ estimateRequest.is_ios } /></td>
            </tr>
            <tr>
              <td>Android</td>
              <td><ObjectPresence mark={ estimateRequest.is_android } /></td>
            </tr>
            <tr>
              <td>Backend API</td>
              <td><ObjectPresence mark={ estimateRequest.is_backend_api } /></td>
            </tr>
            <tr>
              <td>Admin panel</td>
              <td><ObjectPresence mark={ estimateRequest.is_admin_panel } /></td>
            </tr>
            <tr>
              <td>Other</td>
              <td><ObjectPresence mark={ estimateRequest.is_other } /></td>
            </tr>
            <tr>
              <td>Details</td>
              <td>{ estimateRequest.details }</td>
            </tr>
            <tr>
              <td>Document</td>
              { download_link }
            </tr>
          </tbody>
        </table>
      </div>
    )
  }
}
