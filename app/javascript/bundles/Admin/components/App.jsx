import PropTypes from 'prop-types';
import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Link
} from 'react-router-dom'

import About from './About';
import Dashboard from './Dashboard';
import Other from './Other';
import NotFound from './NotFound';

export default class App extends React.Component {
  render() {
    return (
      <Router>
        <div>
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
        </div>
      </Router>
    );
  }
}
