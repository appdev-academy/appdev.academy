import PropTypes from 'prop-types'
import React from 'react'
import { Link } from 'react-router-dom'

import TableRow from './TableRow'

export default class TableBody extends React.Component {
  render() {
    let estimateRequests = this.props.estimateRequests
    
    return (
      <tbody>
        { estimateRequests.map((estimateRequest, index) => {
          return (
            <TableRow
              key={ estimateRequest.id }
              estimateRequest={ estimateRequest }
            />
          )
        })}
      </tbody>
    )
  }
}
