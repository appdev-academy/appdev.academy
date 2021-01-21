import React from 'react'
import { withRouter } from 'react-router'
import { inject, observer } from 'mobx-react'

import Form from './Form'

@inject('articlesStore')
@inject('tagsStore')
@observer
export default class New extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      errors: []
    }
  }
  
  handleSubmit(articleParams) {
    this.props.articlesStore.create(articleParams).then((response) => {
      if (response.status == 200) {
        this.props.history.push({ pathname: '/admin/articles' })
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
        tagsStore={ this.props.tagsStore }
        allTags={ this.props.tagsStore.tags }
        errors={ this.state.errors }
        handleSubmit={ this.handleSubmit.bind(this) }
        ref='articleForm'
      />
    )
  }
}
