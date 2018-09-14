import React from 'react'
import { withRouter } from 'react-router'
import { Link } from 'react-router-dom'
import { inject, observer } from 'mobx-react'

@inject('pagesStore')
@observer
export default class Show extends React.Component {
  
  constructor(props) {
    super(props)
    this.state = {
      htmlContent: ''
    }
  }
  
  componentDidMount() {
    // Make sure Page is among allowed ones
    let slug = this.props.match.params.slug
    if (!this.props.pagesStore.allowedPages.includes(slug)) {
      this.props.history.push({ pathname: '/admin/pages' })
    }
    // Fetch Page to show
    this.props.pagesStore.fetchShow(slug).then((response) => {
      if (response.status == 200) {
        this.setState({
          htmlContent: response.data.html_content
        })
      }
    })
  }
  
  render() {
    let slug = this.props.match.params.slug
    
    return (
      <div className='full-width'>
        <div className='page-container' dangerouslySetInnerHTML={{ __html: this.state.htmlContent }} />
        <div className='actions center'>
          <Link to={ `/admin/pages/${slug}/edit` } className='button orange'>Edit</Link>
          <Link to='/admin/pages/' className='button blue'>Back to Pages</Link>
        </div>
      </div>
    )
  }
}
