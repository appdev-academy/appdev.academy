const ExtractTextPlugin = require('extract-text-webpack-plugin');

const CSSLoaders = {
  test: /\.(scss|sass|css)$/i,
  use: ExtractTextPlugin.extract({
    fallback: 'style-loader',
    use: [
      { loader: 'css-loader' },
      { loader: 'postcss-loader', options: { sourceMap: true } },
      'resolve-url-loader',
      { loader: 'sass-loader', options: { sourceMap: true } }
    ]
  })
};

module.exports = {
  CSSLoaders: CSSLoaders
};
