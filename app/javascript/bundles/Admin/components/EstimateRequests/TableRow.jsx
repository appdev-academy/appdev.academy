import PropTypes from 'prop-types'
import React from 'react'
import { findDOMNode } from 'react-dom'
import { Link } from 'react-router-dom'

import ObjectPresence from './ObjectPresence'

export default class TableRow extends React.Component {
  render() {
    let estimateRequest = this.props.estimateRequest
    
    return (
      <tr key={ estimateRequest.id }>
        <td><Link to={'/admin/estimate-requests/' + estimateRequest.id}>{estimateRequest.id}</Link></td>
        <td>{ estimateRequest.created_at }</td>
        <td>{ estimateRequest.email }</td>
        <td>{ estimateRequest.name }</td>
        <td>{ estimateRequest.company }</td>
        <td>{ estimateRequest.subject }</td>
        <td>{ estimateRequest.budget }</td>
        <td>{ estimateRequest.deadline }</td>
        <td><ObjectPresence mark={estimateRequest.is_ios} /></td>
        <td><ObjectPresence mark={estimateRequest.is_android} /></td>
        <td><ObjectPresence mark={estimateRequest.is_backend_api} /></td>
        <td><ObjectPresence mark={estimateRequest.is_admin_panel} /></td>
        <td><ObjectPresence mark={estimateRequest.is_other} /></td>
        <td>{ estimateRequest.details }</td>
        <td><ObjectPresence mark={estimateRequest.document} /></td>
      </tr>
    )
  }
}
