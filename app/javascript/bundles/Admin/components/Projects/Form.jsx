import React from 'react'
import { Link } from 'react-router-dom'

import ClassNames from 'classnames'
import MarkdownIt from 'markdown-it'
import Textarea from 'react-textarea-autosize'
import { WithContext as ReactTags } from 'react-tag-input'

import videoPlugin from '../../plugins/video'
import ErrorsList from '../ErrorsList'
import BlueButton from '../Buttons/Blue'
import GreenButton from '../Buttons/Green'

// Setup MarkdownIt parser with videos plugin
let markdown = new MarkdownIt()
markdown.use(videoPlugin)

export default class Form extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      appIcon: '',
      appIconFile: '',
      preview: '',
      htmlPreview: '',
      content: '',
      htmlContent: '',
      showType: 'editor',
      tags: []
    }
  }
  
  componentDidMount() {
    this.props.tagsStore.fetchIndex()
  }
  
  setProject(project) {
    if (project) {
      this.refs.title.value = project.title
      this.refs.appStoreURL.value = project.app_store_url
      this.refs.googlePlayURL.value = project.google_play_url
      this.setState({
        appIcon: project.app_icon,
        preview: project.preview,
        htmlPreview: markdown.render(project.preview),
        content: project.content,
        htmlContent: markdown.render(project.content),
        tags: project.tags
      })
    }
  }
  
  previewChanged(event) {
    // Get new Markdown text
    let newText = event.target.value
    // Update page
    this.setState({
      preview: newText,
      htmlPreview: markdown.render(newText)
    })
  }
  
  contentChanged(event) {
    let newText = event.target.value
    this.setState({
      content: newText,
      htmlContent: markdown.render(newText)
    })
  }
  
  // Tags management
  addTag(tag) {
    let tags = this.state.tags
    let tagID = Math.floor(100000 * Math.random())
    tags.push({
      id: tagID,
      title: tag
    })
    this.setState({ tags: tags })
  }
  
  deleteTag(index) {
    let tags = this.state.tags
    tags.splice(index, 1)
    this.setState({ tags: tags })
  }
  
  dragTag(tag, currentPosition, newPosition) {
    let tags = this.state.tags
    tags.splice(currentPosition, 1)
    tags.splice(newPosition, 0, tag)
    this.setState({ tags: tags })
  }
  
  selectFile() {
    this.refs.appIcon.click()
  }
  
  didSelectFile() {
    let file = this.refs.appIcon.files[0]
    let reader = new FileReader()
    
    reader.onload = (event) => {
      this.setState({
        appIcon: reader.result,
        appIconFile: file
      })
    }
    reader.readAsDataURL(file)
  }
  
  handleSubmit(event) {
    event.preventDefault()
    let formData = new FormData()
    
    formData.append('project[title]', this.refs.title.value)
    formData.append('project[app_store_url]', this.refs.appStoreURL.value)
    formData.append('project[google_play_url]', this.refs.googlePlayURL.value)
    formData.append('project[preview]', this.state.preview)
    formData.append('project[html_preview]', this.state.htmlPreview)
    formData.append('project[content]', this.state.content)
    formData.append('project[html_content]', this.state.htmlContent)
    
    // App Icon if it was selected
    if (this.state.appIconFile) {
      formData.append('project[app_icon]', this.state.appIconFile)
    }
    
    // Tags are separate from Project fields
    formData.append('tags_titles', this.state.tags.map(tag => tag.title).join(','))
    
    this.props.handleSubmit(formData)
  }
  
  clickEditor() {
    this.setState({
      showType: 'editor'
    })
  }
  
  clickPreview() {
    this.setState({
      showType: 'preview'
    })
  }
  
  render () {
    let editorClasses = ClassNames({
      'hidden': this.state.showType == 'preview',
      'half-width': this.state.showType == 'editor'
    })
    
    let previewClasses = ClassNames({
      'project-container': true,
      'full-width': this.state.showType == 'preview',
      'half-width': this.state.showType == 'editor'
    })
    
    let suggestions = this.props.allTags.map(tag => tag.title)
    
    return (
      <div className='column'>
        <ErrorsList errors={ this.props.errors } />
        <div className='form-group'>
          <input type='text' ref='title' className='title' autoFocus={ true } />
        </div>
        <div className='form-group employee-picture'>
          <label htmlFor='appIcon'>App Icon</label>
          <img src={ this.state.appIcon } onClick={ this.selectFile.bind(this) } />
          <input
            name='appIcon'
            id='appIcon'
            type='file'
            accept='image/png, image/jpeg, image/jpg'
            onChange={ this.didSelectFile.bind(this) }
            ref='appIcon'
          />
        </div>
        <div className='form-group'>
          <label htmlFor='appStoreURL'>App Store URL</label>
          <input type='text' ref='appStoreURL' className='appStoreURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='googlePlayURL'>Google Play URL</label>
          <input type='text' ref='googlePlayURL' className='googlePlayURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='tags'>Tags</label>
          <ReactTags
            labelField='title'
            autofocus={ false }
            tags={ this.state.tags }
            suggestions={ suggestions }
            handleDelete={ this.deleteTag.bind(this) }
            handleAddition={ this.addTag.bind(this) }
            handleDrag={ this.dragTag.bind(this) }
          />
        </div>
        <div className='buttons center'>
          <BlueButton
            title='Editor'
            selected={ this.state.showType == 'editor' }
            onClick={ this.clickEditor.bind(this) }
          />
          <BlueButton
            title='Preview'
            selected={ this.state.showType == 'preview' }
            onClick={ this.clickPreview.bind(this) }
          />
        </div>
        <div>
          <h2 className='center'>Preview</h2>
          <Textarea className={ editorClasses } value={ this.state.preview } onChange={ this.previewChanged.bind(this) } rows={ 5 }></Textarea>
          <div className={ previewClasses } dangerouslySetInnerHTML={{ __html: this.state.htmlPreview }} />
        </div>
        <div>
          <h2 className='center'>Content</h2>
          <Textarea className={ editorClasses } value={ this.state.content } onChange={ this.contentChanged.bind(this) } rows={ 10 }></Textarea>
          <div className={ previewClasses } dangerouslySetInnerHTML={{ __html: this.state.htmlContent }} />
        </div>
        <div className='actions center'>
          <h3>Actions</h3>
          <GreenButton
            title='Save'
            onClick={ this.handleSubmit.bind(this) }
          />
          <Link className='button blue' to='/admin/projects'>Back to Projects</Link>
        </div>
      </div>
    )
  }
}
