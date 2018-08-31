import React from 'react'
import classNames from 'classnames'
import { withRouter } from 'react-router'
import { NavLink } from 'react-router-dom'
import { inject, observer } from 'mobx-react'

@inject('sessionsStore')
@observer
class Root extends React.Component {
  
  componentDidMount() {
    this.checkAccessToken()
  }
  
  componentWillUpdate(nextProps, nextState) {
    this.checkAccessToken()
  }
  
  checkAccessToken() {
    let accessToken = this.props.sessionsStore.getAccessToken()
    let location = this.props.location.pathname
    if (accessToken == null) {
      // accessToken is null
      if (location != '/admin/sign-in') {
        this.context.history.push('/admin/sign-in')
      }
    } else {
      // accessToken is present
      if (location == '/admin/sign-in') {
        this.context.history.push('/admin')
      }
    }
  }
  
  signOut() {
    this.props.sessionsStore.delete()
  }
  
  render() {
    let adminMenuClassNames = classNames({
      admin: true,
      menu: true,
      hidden: this.props.sessionsStore.accessToken == null
    })
    
    let adminMenu = <div></div>
    let location = this.props.location.pathname
    
    console.log(this.props.location);
    
    if (location != '/admin/sign-in') {
      adminMenu = (
        <div className={ adminMenuClassNames }>
          <NavLink to={ '/admin' } activeClassName='active'>Dashboard</NavLink>
          <NavLink to={ '/admin/images' } activeClassName='active'>Images</NavLink>
          <NavLink to={ '/admin/articles' } activeClassName='active'>Articles</NavLink>
          <NavLink to={ '/admin/pages' } activeClassName='active'>Pages</NavLink>
          <NavLink to={ '/admin/projects' } activeClassName='active'>Projects</NavLink>
          <NavLink to={ '/admin/tags' } activeClassName='active'>Tags</NavLink>
          <NavLink to={ '/admin/topics' } activeClassName='active'>Topics</NavLink>
          <NavLink to={ '/admin/employees' } activeClassName='active'>Employees</NavLink>
          <NavLink to={ '/admin/testimonials' } activeClassName='active'>Testimonials</NavLink>
          <a href='#logout' onClick={ () => { this.signOut() } }>Sign Out</a>
        </div>
      )
    }
    
    return (
      <div className='root-container'>
        { adminMenu }
        { this.props.children }
      </div>
    )
  }
}

export default withRouter(Root)
