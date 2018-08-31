import React from 'react'
import classNames from 'classnames'
import { withRouter } from 'react-router'
import {
  NavLink,
  Route,
  Switch
} from 'react-router-dom'
import { inject, observer } from 'mobx-react'

// Authentication
import SignIn from './Authentication/SignIn'

// Not Found
import NotFound from './NotFound'

// Dashboard
import Dashboard from './Dashboards/Main'

// Resources
import Articles from './Articles/Index'
import Employees from './Employees/Index'
import Images from './Images/Index'
import Pages from './Pages/Index'
import Projects from './Projects/Index'
import Tags from './Tags/Index'
import Testimonials from './Testimonials/Index'
import Topics from './Topics/Index'

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
        this.props.history.push({ pathname: '/admin/sign-in' })
      }
    } else {
      // accessToken is present
      if (location == '/admin/sign-in') {
        this.props.history.push({ pathname: '/admin' })
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
    
    console.log(location);
    
    if (location != '/admin/sign-in') {
      adminMenu = (
        <div className={ adminMenuClassNames }>
          <NavLink to={ '/admin' } exact activeClassName='active'>Dashboard</NavLink>
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
        <Switch>
          <Route exact path="/admin" component={Dashboard} />
          <Route path="/admin/articles" component={Articles} />
          <Route path="/admin/employees" component={Employees} />
          <Route path="/admin/images" component={Images} />
          <Route path="/admin/pages" component={Pages} />
          <Route path="/admin/projects" component={Projects} />
          <Route path="/admin/tags" component={Tags} />
          <Route path="/admin/testimonials" component={Testimonials} />
          <Route path="/admin/topics" component={Topics} />
          <Route path="/admin/sign-in" component={SignIn} />
        </Switch>
      </div>
    )
  }
}

export default withRouter(Root)
