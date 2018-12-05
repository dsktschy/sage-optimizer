const url = require('url');
const webpack = require('webpack');
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');

const config = require('./config');

const target = process.env.DEVURL || config.devUrl;

/**
 * We do this to enable injection over SSL.
 */
if (url.parse(target).protocol === 'https:') {
  process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0;

  config.proxyUrl = config.proxyUrl.replace('http:', 'https:');
}

module.exports = {
  output: {
    pathinfo: true,
    publicPath: config.proxyUrl + config.publicPath,
  },
  devtool: '#cheap-module-source-map',
  stats: false,
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    /**
     * Instead of https://github.com/QWp6t/browsersync-webpack-plugin
     * use https://github.com/Va1/browser-sync-webpack-plugin
     * Because Va1's one is simpler to set reload without warnings when changing JS
     */
    new BrowserSyncPlugin(
      /**
       * BrowserSync options
       */
      {
        open: config.open,
        host: url.parse(config.proxyUrl).hostname,
        port: url.parse(config.proxyUrl).port,
        proxy: target,
        /**
         * Use SSL certificate to avoid browser warnings
         */
        https: {
          key: process.env.BROWSER_SYNC_HTTPS_KEY,
          cert: process.env.BROWSER_SYNC_HTTPS_CERT,
        },
        /**
         * Settings to inject PHP changes
         */
        plugins: [
          {
            module: 'bs-html-injector',
            options: {
              files: Array.isArray(config.watch)
                ? Array.from(new Set(config.watch))
                : [config.watch],
            },
          },
        ],
      },
      /**
       * BrowserSync plugin options
       */
      {
        /**
         * Settings to inject CSS changes
         */
        injectCss: true,
      },
    ),
  ],
};
