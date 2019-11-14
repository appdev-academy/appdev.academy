import React from 'react'
import { Link } from 'react-router-dom'
import { inject, observer } from 'mobx-react'

import TableBody from './TableBody'
import ConfirmationDialog from '../ConfirmationDialog'

@inject('estimateRequestsStore')
@observer
export default class Index extends React.Component {
  
  componentDidMount() {
    this.props.estimateRequestsStore.fetchIndex()
  }
  
  render() {
    return (
      <div className='estimate-requests'>
        <h2 className='center'>Estimate Requests</h2>
        <br />
        <br />
        <table className='admin'>
          <thead>
            <tr>
              <td>ID</td>
              <td>Created at</td>
              <td>Email</td>
              <td>Name</td>
              <td>Company</td>
              <td>Subject</td>
              <td>Budget</td>
              <td>Deadline</td>
              <td>IOS</td>
              <td>Android</td>
              <td>Backend API</td>
              <td>Admin panel</td>
              <td>Other</td>
              <td>Details</td>
              <td>Document</td>
            </tr>
          </thead>
          <TableBody
            estimateRequests={ this.props.estimateRequestsStore.estimate_requests }
          />
        </table>
      </div>
    )
  }
}
