import React from 'react'
import { Link } from 'react-router-dom'

import ErrorsList from '../ErrorsList'
import BlueButton from '../Buttons/Blue'
import GreenButton from '../Buttons/Green'

export default class Form extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      file: '',
      profilePicture: ''
    }
  }
  
  setEmployee(employee) {
    if (employee) {
      this.refs.firstName.value = employee.first_name
      this.refs.lastName.value = employee.last_name
      this.refs.title.value = employee.title
      this.refs.motivation.value = employee.motivation
      this.refs.facebookURL.value = employee.facebook_url
      this.refs.twitterURL.value = employee.twitter_url
      this.refs.linkedinURL.value = employee.linkedin_url
      this.refs.githubURL.value = employee.github_url
      this.setState({
        profilePicture: employee.profile_picture
      })
    }
  }
  
  selectFile() {
    this.refs.profilePicture.click()
  }
  
  didSelectFile() {
    let file = this.refs.profilePicture.files[0]
    let reader = new FileReader()
    
    reader.onload = (event) => {
      this.setState({
        file: file,
        profilePicture: reader.result
      })
    }
    reader.readAsDataURL(file)
  }
  
  // Form submition
  handleSubmit(event) {
    event.preventDefault()
    let formData = new FormData()
    
    formData.append('employee[first_name]', this.refs.firstName.value)
    formData.append('employee[last_name]', this.refs.lastName.value)
    formData.append('employee[title]', this.refs.title.value)
    formData.append('employee[motivation]', this.refs.motivation.value)
    formData.append('employee[facebook_url]', this.refs.facebookURL.value)
    formData.append('employee[twitter_url]', this.refs.twitterURL.value)
    formData.append('employee[linkedin_url]', this.refs.linkedinURL.value)
    formData.append('employee[github_url]', this.refs.githubURL.value)
    
    if (this.state.file) {
      formData.append('employee[profile_picture]', this.state.file)
    }
    
    this.props.handleSubmit(formData)
  }
  
  render () {
    return (
      <div className='column'>
        <ErrorsList errors={ this.props.errors } />
        <div className='form-group'>
          <label htmlFor='firstName'>First name</label>
          <input type='text' ref='firstName' id='firstName' autoFocus={ true } />
        </div>
        <div className='form-group'>
          <label htmlFor='lastName'>Last name</label>
          <input type='text' ref='lastName' id='lastName' />
        </div>
        <div className='form-group'>
          <label htmlFor='title'>Title</label>
          <input type='text' ref='title' id='title' />
        </div>
        <div className='form-group'>
          <label htmlFor='motivation'>Motivation</label>
          <textarea className='inline' rows='3' ref='motivation' id='motivation' />
        </div>
        <div className='form-group'>
          <label htmlFor='facebookURL'>Facebook profile URL</label>
          <input type='text' ref='facebookURL' id='facebookURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='twitterURL'>Twitter profile URL</label>
          <input type='text' ref='twitterURL' id='twitterURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='linkedinURL'>LinkedIn profile URL</label>
          <input type='text' ref='linkedinURL' id='linkedinURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='githubURL'>GitHub profile URL</label>
          <input type='text' ref='githubURL' id='githubURL' />
        </div>
        <div className='form-group employee-picture'>
          <label htmlFor='profilePicture'>Profile picture</label>
          <img src={ this.state.profilePicture } onClick={ this.selectFile.bind(this) } />
          <input
            name='profilePicture'
            id='profilePicture'
            type='file'
            accept='image/png, image/jpeg, image/jpg'
            onChange={ this.didSelectFile.bind(this) }
            ref='profilePicture'
          />
        </div>
        <div className='actions left'>
          <GreenButton
            title='Save'
            onClick={ this.handleSubmit.bind(this) }
          />
          <Link className='button blue' to='/admin/employees'>Back to Employees</Link>
        </div>
      </div>
    )
  }
}
