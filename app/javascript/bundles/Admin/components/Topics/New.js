import React from 'react'
import { withRouter } from 'react-router'
import { inject } from 'mobx-react'

import Form from './Form'

@inject('topicsStore')
export default class New extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      errors: []
    }
  }
  
  handleSubmit(topicParams) {
    this.props.topicsStore.create(topicParams).then((response) => {
      if (response.status == 200) {
        this.props.history.push({ pathname: '/admin/topics' })
      }
    }).catch((error) => {
      if (error.response && error.response.data && error.response.data.errors) {
        this.setState({
          errors: error.response.data.errors
        })
      }
    })
  }
  
  render() {
    return (
      <Form
        errors={ this.state.errors }
        handleSubmit={ this.handleSubmit.bind(this) }
      />
    )
  }
}
