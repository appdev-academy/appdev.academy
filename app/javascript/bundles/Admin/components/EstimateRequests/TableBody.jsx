import React from 'react'

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
