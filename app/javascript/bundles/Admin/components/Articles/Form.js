import React from 'react'
import { Link } from 'react-router-dom'
import { WithContext as ReactTags } from 'react-tag-input'
import ErrorsList from '../ErrorsList'
import GreenButton from '../Buttons/Green'

// Import ReactSummernote editor
import 'bootstrap/js/modal'
import 'bootstrap/js/dropdown'
import 'bootstrap/js/tooltip'
import 'bootstrap/dist/css/bootstrap.css'

import ReactSummernote from 'react-summernote'
import 'react-summernote/dist/react-summernote.css'

export default class Form extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: '',
      htmlPreview: '',
      content: '',
      htmlContent: '',
      tags: []
    }
  }
  
  componentDidMount() {
    this.props.tagsStore.fetchIndex()
  }
  
  setArticle(article) {
    if (article) {
      this.refs.title.value = article.title
      this.refs.shortDescription.value = article.short_description
      this.refs.imageURL.value = article.image_url
      this.setState({
        preview: article.html_preview,
        htmlPreview: article.html_preview,
        content: article.html_content,
        htmlContent: article.html_content,
        tags: article.tags
      })
    }
  }
  
  previewChanged(preview) {
    this.setState({
      preview: preview,
      htmlPreview: preview,
    })
  }
  
  contentChanged(content) {
    this.setState({
      content: content,
      htmlContent: content,
    })
  }
  
  // Tags management
  addTag(tag) {
    let tags = this.state.tags
    let tagID = Math.floor(100000 * Math.random())
    tags.push({
      id: tagID,
      title: tag.title
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
  
  // Form submition
  handleSubmit(event) {
    event.preventDefault()
    let articleParams = {
      title: this.refs.title.value,
      short_description: this.refs.shortDescription.value,
      image_url: this.refs.imageURL.value,
      preview: this.state.htmlPreview,
      html_preview: this.state.htmlPreview,
      content: this.state.htmlContent,
      html_content: this.state.htmlContent,
      tags_titles: this.state.tags.map(tag => tag.title).join(',')
    }
    this.props.handleSubmit(articleParams)
  }
  
  renderInsertVideo(context) {
    let ui = $.summernote.ui;
    let button = ui.button({
      contents: '<i class="note-icon-video"/>',
      tooltip: 'Video',
      click: function() {
        let div = document.createElement('div');
        let iframe = document.createElement('iframe');
        let videoID = prompt('Enter YouTube video ID:');
        
        // Do nothing if anything doesn't enter
        if (videoID === null || videoID.length === 0) return;
        
        div.classList.add('video-wrapper');
        iframe.src = `//www.youtube.com/embed/${videoID}`;
        iframe.setAttribute('frameborder', 0);
        iframe.setAttribute('width', '100%');
        iframe.setAttribute('allowfullscreen', true);
        iframe.setAttribute('mozallowfullscreen', true);
        iframe.setAttribute('webkitallowfullscreen', true);
        div.appendChild(iframe);
        context.invoke('editor.insertNode', div);
      }
    });
    
    return button.render();
  }
  
  render () {
    // Normalize tags and suggestions
    let tags = this.state.tags.map(tag => {
      return { id: `${tag.id}`, title: tag.title }
    })
    
    let suggestions = this.props.allTags.map(tag => {
      return { id: `${tag.id}`, title: tag.title }
    })
    
    return (
      <div className='column blog-article'>
        <ErrorsList errors={this.props.errors} />
        <div className='form-group'>
          <input type='text' ref='title' className='title' autoFocus={true} />
        </div>
        <div className='form-group'>
          <label htmlFor='shortDescription'>Short description (for SEO and sharing to social networks)</label>
          <input type='text' id='shortDescription' ref='shortDescription' />
        </div>
        <div className='form-group'>
          <label htmlFor='imageURL'>Image URL</label>
          <input type='text' id='imageURL' ref='imageURL' />
        </div>
        <div className='form-group'>
          <label htmlFor='tags'>Tags</label>
          <ReactTags
            labelField='title'
            autofocus={false}
            tags={tags}
            suggestions={suggestions}
            handleDelete={this.deleteTag.bind(this)}
            handleAddition={this.addTag.bind(this)}
            handleDrag={this.dragTag.bind(this)}
          />
        </div>
        <div className='actions left'>
          <GreenButton
            title='Save'
            onClick={this.handleSubmit.bind(this)}
          />
          <Link className='button blue' to='/admin/articles'>Back to Articles</Link>
        </div>
        <div className='mb-3'>
          <h2 className='center'>Preview</h2>
          <ReactSummernote
            value={ this.state.htmlPreview }
            options={{
              linkTargetBlank: true,
              dialogsInBody: true,
              toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'insertVideo']],
                ['view', ['fullscreen', 'codeview']]
              ],
              buttons: {
                insertVideo: this.renderInsertVideo.bind(this)
              }
            }}
            onChange={ this.previewChanged.bind(this) }
          />
        </div>
        <div className='mb-3'>
          <h2 className='center'>Content</h2>
          <ReactSummernote
            value={ this.state.htmlContent }
            options={{
              linkTargetBlank: true,
              dialogsInBody: true,
              toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'insertVideo']],
                ['view', ['fullscreen', 'codeview']]
              ],
              buttons: {
                insertVideo: this.renderInsertVideo.bind(this)
              }
            }}
            onChange={ this.contentChanged.bind(this) }
          />
        </div>
        <div className='actions left'>
          <GreenButton
            title='Save'
            onClick={ this.handleSubmit.bind(this) }
          />
          <Link className='button blue' to='/admin/articles'>Back to Articles</Link>
        </div>
      </div>
    )
  }
}
