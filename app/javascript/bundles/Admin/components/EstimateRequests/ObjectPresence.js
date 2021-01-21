import React from 'react'

export default class ObjectPresence extends React.Component {
  render() {
    return(
      this.props.mark ? '+' : '-'
    )
  }
}
