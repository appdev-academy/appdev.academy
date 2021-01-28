import React from 'react'
import { withRouter } from 'react-router'
import { inject, observer } from 'mobx-react'

import Form from './Form'

@inject('testimonialsStore')
@observer
export default class Edit extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      errors: []
    }
  }
  
  componentDidMount() {
    let testimonialID = this.props.match.params.testimonialID
    let testimonialForm = this.refs.testimonialForm
    this.props.testimonialsStore.fetchShow(testimonialID).then((response) => {
      if (response.status == 200) {
        testimonialForm.setTestimonial(response.data.testimonial)
      }
    })
  }
  
  handleSubmit(params) {
    let testimonialID = this.props.match.params.testimonialID
    this.props.testimonialsStore.update(testimonialID, params).then((response) => {
      if (response.status == 200) {
        this.props.history.push({ pathname: '/admin/testimonials' })
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
        ref='testimonialForm'
      />
    )
  }
}
