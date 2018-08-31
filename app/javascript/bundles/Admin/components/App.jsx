import PropTypes from 'prop-types'
import React from 'react'
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Link
} from 'react-router-dom'
import { Provider } from 'mobx-react'

// Import stores
import ArticlesStore from '../stores/Articles'
import DashboardsStore from '../stores/Dashboards'
import EmployeesStore from '../stores/Employees'
import GalleryImagesStore from '../stores/GalleryImages'
import ImagesStore from '../stores/Images'
import LessonsStore from '../stores/Lessons'
import PagesStore from '../stores/Pages'
import ProjectsStore from '../stores/Projects'
import ScreencastsStore from '../stores/Screencasts'
import SessionsStore from '../stores/Sessions'
import TagsStore from '../stores/Tags'
import TestimonialsStore from '../stores/Testimonials'
import TopicsStore from '../stores/Topics'

const sessionsStore = new SessionsStore()
const articlesStore = new ArticlesStore(sessionsStore)
const dashboardsStore = new DashboardsStore(sessionsStore)
const employeesStore = new EmployeesStore(sessionsStore)
const galleryImagesStore = new GalleryImagesStore(sessionsStore)
const imagesStore = new ImagesStore(sessionsStore)
const lessonsStore = new LessonsStore(sessionsStore)
const pagesStore = new PagesStore(sessionsStore)
const projectsStore = new ProjectsStore(sessionsStore)
const screencastsStore = new ScreencastsStore(sessionsStore)
const tagsStore = new TagsStore(sessionsStore)
const testimonialsStore = new TestimonialsStore(sessionsStore)
const topicsStore = new TopicsStore(sessionsStore)

import Root from './Root';

import About from './About';
import Dashboard from './Dashboard';
import Other from './Other';
import NotFound from './NotFound';

export default class App extends React.Component {
  render() {
    return (
      <Provider articlesStore={ articlesStore }
                dashboardsStore={ dashboardsStore }
                employeesStore={ employeesStore }
                imagesStore={ imagesStore }
                galleryImagesStore={ galleryImagesStore }
                lessonsStore={ lessonsStore }
                pagesStore={ pagesStore }
                projectsStore={ projectsStore }
                screencastsStore={ screencastsStore }
                sessionsStore={ sessionsStore }
                tagsStore={ tagsStore }
                testimonialsStore={ testimonialsStore }
                topicsStore={ topicsStore }
      >
        <Router>
          <Root>
            <ul>
              <li><Link to="/admin">Dashboard</Link></li>
              <li><Link to="/admin/about">About</Link></li>
              <li><Link to="/admin/other">Other</Link></li>
            </ul>
            
            <Switch>
              <Route path="/admin" exact component={Dashboard} />
              <Route path="/admin/about" exact component={About} />
              <Route path="/admin/other" exact component={Other} />
              <Route component={NotFound} />
            </Switch>
          </Root>
        </Router>
      </Provider>
    );
  }
}
