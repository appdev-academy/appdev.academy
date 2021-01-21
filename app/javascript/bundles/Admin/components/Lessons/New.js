import React from 'react'
import { withRouter } from 'react-router'
import { inject } from 'mobx-react'

import Form from './Form'

@inject('lessonsStore')
export default class New extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      errors: []
    }
  }
  
  handleSubmit(screencastParams) {
    let topicID = this.props.match.params.topicID
    let screencastID = this.props.match.params.screencastID
    
    this.props.lessonsStore.create(screencastID, screencastParams).then((response) => {
      if (response.status == 200) {
        this.props.history.push({ pathname: `/admin/topics/${topicID}/screencasts/${screencastID}/lessons` })
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
        params={ this.props.params }
        match= { this.props.match }
        handleSubmit={ this.handleSubmit.bind(this) }
      />
    )
  }
}
