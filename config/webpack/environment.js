const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
const loaders = require('./loaders');

// Require loaders
environment.loaders.append('CSSLoaders', loaders.CSSLoaders);

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
  })
);

module.exports = environment
