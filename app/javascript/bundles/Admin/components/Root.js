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
import NewArticle from './Articles/New'
import EditArticle from './Articles/Edit'
import ShowArticle from './Articles/Show'

import Employees from './Employees/Index'
import NewEmployee from './Employees/New'
import EditEmployee from './Employees/Edit'
import ShowEmployee from './Employees/Show'

import Images from './Images/Index'

import Pages from './Pages/Index'
import EditPage from './Pages/Edit'
import ShowPage from './Pages/Show'

import Projects from './Projects/Index'
import NewProject from './Projects/New'
import EditProject from './Projects/Edit'
import ShowProject from './Projects/Show'

import Tags from './Tags/Index'
import NewTag from './Tags/New'
import EditTag from './Tags/Edit'

import Testimonials from './Testimonials/Index'
import NewTestimonial from './Testimonials/New'
import EditTestimonial from './Testimonials/Edit'
import ShowTestimonial from './Testimonials/Show'

// Topics -> Screencasts -> Lessons
import Topics from './Topics/Index'
import NewTopic from './Topics/New'
import EditTopic from './Topics/Edit'

import Screencasts from './Screencasts/Index'
import NewScreencast from './Screencasts/New'
import EditScreencast from './Screencasts/Edit'

import Lessons from './Lessons/Index'
import NewLesson from './Lessons/New'
import EditLesson from './Lessons/Edit'

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
    
    if (location != '/admin/sign-in') {
      adminMenu = (
        <div className={ adminMenuClassNames }>
          <NavLink to='/admin' exact activeClassName='active'>Dashboard</NavLink>
          <NavLink to='/admin/images' activeClassName='active'>Images</NavLink>
          <NavLink to='/admin/articles' activeClassName='active'>Articles</NavLink>
          <NavLink to='/admin/pages' activeClassName='active'>Pages</NavLink>
          <NavLink to='/admin/projects' activeClassName='active'>Projects</NavLink>
          <NavLink to='/admin/tags' activeClassName='active'>Tags</NavLink>
          <NavLink to='/admin/topics' activeClassName='active'>Topics</NavLink>
          <NavLink to='/admin/employees' activeClassName='active'>Employees</NavLink>
          <NavLink to='/admin/testimonials' activeClassName='active'>Testimonials</NavLink>
          <a href='#logout' onClick={ () => { this.signOut() } }>Sign Out</a>
        </div>
      )
    }
    
    return (
      <div className='root-container'>
        { adminMenu }
        <Switch>
          <Route exact path='/admin' component={Dashboard} />
          
          <Route exact path='/admin/articles' component={Articles} />
          <Route exact path='/admin/articles/new' component={NewArticle} />
          <Route exact path='/admin/articles/:articleID' component={ShowArticle} />
          <Route exact path='/admin/articles/:articleID/edit' component={EditArticle} />
          
          <Route exact path='/admin/employees' component={Employees} />
          <Route exact path='/admin/employees/new' component={NewEmployee} />
          <Route exact path='/admin/employees/:employeeID' component={ShowEmployee} />
          <Route exact path='/admin/employees/:employeeID/edit' component={EditEmployee} />
          
          <Route exact path='/admin/images' component={Images} />
          
          <Route exact path='/admin/pages' component={Pages} />
          <Route exact path='/admin/pages/:slug' component={ShowPage} />
          <Route exact path='/admin/pages/:slug/edit' component={EditPage} />
          
          <Route exact path='/admin/projects' component={Projects} />
          <Route exact path='/admin/projects/new' component={NewProject} />
          <Route exact path='/admin/projects/:projectID' component={ShowProject} />
          <Route exact path='/admin/projects/:projectID/edit' component={EditProject} />
          
          <Route exact path='/admin/tags' component={Tags} />
          <Route exact path='/admin/tags/new' component={NewTag} />
          <Route exact path='/admin/tags/:tagID/edit' component={EditTag} />
          
          <Route exact path='/admin/testimonials' component={Testimonials} />
          <Route exact path='/admin/testimonials/new' component={NewTestimonial} />
          <Route exact path='/admin/testimonials/:testimonialID' component={ShowTestimonial} />
          <Route exact path='/admin/testimonials/:testimonialID/edit' component={EditTestimonial} />
          
          <Route exact path='/admin/topics' component={Topics} />
          <Route exact path='/admin/topics/new' component={NewTopic} />
          <Route exact path='/admin/topics/:topicID/edit' component={EditTopic} />
          
          <Route exact path='/admin/topics/:topicID/screencasts' component={Screencasts} />
          <Route exact path='/admin/topics/:topicID/screencasts/new' component={NewScreencast} />
          <Route exact path='/admin/topics/:topicID/screencasts/:screencastID/edit' component={EditScreencast} />
          
          <Route exact path='/admin/topics/:topicID/screencasts/:screencastID/lessons' component={Lessons} />
          <Route exact path='/admin/topics/:topicID/screencasts/:screencastID/lessons/new' component={NewLesson} />
          <Route exact path='/admin/topics/:topicID/screencasts/:screencastID/lessons/:lessonID/edit' component={EditLesson} />
          
          <Route path='/admin/sign-in' component={SignIn} />
          
          <Route component={NotFound} />
        </Switch>
      </div>
    )
  }
}

export default withRouter(Root)
