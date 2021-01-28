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
import EstimateRequestsStore from '../stores/EstimateRequests'
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
const estimateRequestsStore = new EstimateRequestsStore(sessionsStore)
const galleryImagesStore = new GalleryImagesStore(sessionsStore)
const imagesStore = new ImagesStore(sessionsStore)
const lessonsStore = new LessonsStore(sessionsStore)
const pagesStore = new PagesStore(sessionsStore)
const projectsStore = new ProjectsStore(sessionsStore)
const screencastsStore = new ScreencastsStore(sessionsStore)
const tagsStore = new TagsStore(sessionsStore)
const testimonialsStore = new TestimonialsStore(sessionsStore)
const topicsStore = new TopicsStore(sessionsStore)

import Root from './Root'
import NotFound from './NotFound'

export default class App extends React.Component {
  render() {
    return (
      <Provider articlesStore={ articlesStore }
                dashboardsStore={ dashboardsStore }
                employeesStore={ employeesStore }
                estimateRequestsStore={ estimateRequestsStore }
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
          <Root />
        </Router>
      </Provider>
    )
  }
}
