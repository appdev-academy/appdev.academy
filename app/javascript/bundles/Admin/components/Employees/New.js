import React from 'react'
import { withRouter } from 'react-router'
import { inject, observer } from 'mobx-react'

import Form from './Form'

@inject('employeesStore')
@observer
export default class New extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      errors: []
    }
  }
  
  handleSubmit(employeeParams) {
    this.props.employeesStore.create(employeeParams).then((response) => {
      if (response.status == 201) {
        this.props.history.push({ pathname: '/admin/employees' })
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
        ref='employeeForm'
      />
    )
  }
}
