var express = require('express');

//.env file congig
require('dotenv').config();

// Server and Database configurations
var env = process.env.NODE_ENV || 'dev';
var config = require('./config')[env];

// Initialize Express App
var app = require('./app.js');

app.listen(
            {
                host: config.server.host,
                port: config.server.port,
                exclusive: true
            }, function () {
                if (process.env.DEBUG) {
                    // Log the message if DEBUG is enabled in .env file (root directory)
                    console.log("listening to port " + config.server.port);
                    console.log("in environment " + env);
                    console.log(process.env.NODE_ENV);
                }
            }
        );
