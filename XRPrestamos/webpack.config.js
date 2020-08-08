const htmlWebpackPlugin = require('html-webpack-plugin');
const LiveReloadPlugin = require('webpack-livereload-plugin');
const { server } = require('./src/keys');
//const MiniCSSExtractPlugin = require('mini-css-extract-plugin');
const path = require('path');

module.exports = {
  devServer: {
    host: server.host,
    port: server.port
  },
  entry: './src/app/index.js',
  output: {
    crossOriginLoading: 'anonymous',
    path: path.resolve(__dirname, 'src/public'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-react']
          }
        }
      },
      {
        test: /\.html$/,
        use: [
          {
            loader: "html-loader"
          }
        ]
      },
      {
        use: ['style-loader', 'css-loader'],
        test: /\.css$/
      },
      {
        test: /\.scss$/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader', options: {
              sourceMap: true
            }
          },
          {
            loader: 'sass-loader', options: {
              sourceMap: true
            }
          }
        ]
      },
      {
        test: /\.(png|jpg|gif)$/i,//test: /\.(png|jpg|gif)$/i,
        use: [
          {
            loader: 'url-loader',
            options: {
              mimetype: 'image/png',
            },
          },
        ],
      }
    ]
  },
  plugins: [
    new htmlWebpackPlugin({
      template: './src/public/index.html',
      filename: "./index.html"
    }),/*
    new MiniCSSExtractPlugin({
      filename: "./src/public/estilos.css",
    }),*/
    new LiveReloadPlugin()
  ]
}
