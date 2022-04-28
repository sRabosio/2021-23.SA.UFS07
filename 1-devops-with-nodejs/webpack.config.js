const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    devServer: {
        watchFiles: ['js/**/*.js', 'index.html', 'css/**/.css', 'img/**/*.png'],
        compress: true,
        port: 9000,
    },
    entry: "./js/index.js",
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [
                    "style-loader",
                    {
                        loader: "css-loader",
                        options: {
                            sourceMap: true,
                        },
                    },
                ],
            },
            {
                test: /\.scss$/,
                use: [
                    "style-loader",
                    {
                        loader: "sass-loader",
                        options: {
                            sourceMap: true,
                        },
                    },
                ],
            },
            {
                test: /\.(jpg|jpeg|gif|png|svg|webp)$/,
                use: [
                    {
                        loader: "file-loader",
                        options: {
                            name: "[path]/[name].[ext]",
                        },
                    },
                ]
            },
            {
                test: /\.(md)$/,
                use: [
                    {
                        loader: "file-loader",
                        options: {
                            name: "[path]/[name].[ext]",
                        },
                    },
                ]
            },
        ]
    },
    output: {
        path: path.resolve(__dirname, 'dist'), // output directory
        filename: "[name].min.js" // name of the generated bundle
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "index.html",
            inject: "body",
            scriptLoading: "blocking"
        })
    ],
};
