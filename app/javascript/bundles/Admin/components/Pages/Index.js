import React from 'react'
import { Link } from 'react-router-dom'
import { inject, observer } from 'mobx-react'

@inject('pagesStore')
@observer
export default class Index extends React.Component {
  
  componentDidMount() {
    this.props.pagesStore.fetchIndex()
  }
  
  // Render list of Pages
  renderPages(pages) {
    let sortedPages = pages.sort((first, second) => {
      let firstSlug = first.slug.toLowerCase()
      let secondSlug = second.slug.toLowerCase()
      return (firstSlug < secondSlug) ? -1 : (firstSlug > secondSlug) ? 1 : 0
    })
    
    return sortedPages.map((page) => {
      let capitalizedSlug = page.slug.charAt(0).toUpperCase() + page.slug.slice(1)
      
      return (
        <tr key={ page.id }>
          <td>{ capitalizedSlug }</td>
          <td className='actions left'>
            <Link className='button blue' to={ `/admin/pages/${page.slug}` }>Show</Link>
            <Link className='button green' to={ `/admin/pages/${page.slug}/edit` }>Edit</Link>
          </td>
        </tr>
      )
    })
  }
  
  render() {
    return (
      <div className='pages'>
        <h2 className='center'>Pages</h2>
        <table className='admin'>
          <thead>
            <tr>
              <td>Title</td>
              <td>Actions</td>
            </tr>
          </thead>
          <tbody>
            { this.renderPages(this.props.pagesStore.pages) }
          </tbody>
        </table>
      </div>
    )
  }
}
