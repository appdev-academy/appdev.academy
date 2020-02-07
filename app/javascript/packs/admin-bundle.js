import ReactOnRails from 'react-on-rails'

// Import entry stylesheets for pack - IMPORTANT!
import 'stylesheets/admin-bundle'

import AdminApp from '../bundles/Admin/components/App'

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  AdminApp,
})
