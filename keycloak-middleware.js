var express = require('express');
var app = express();
var env = process.env.NODE_ENV || 'dev';
var config = require('./config')[env];
const Keycloak = require('keycloak-connect');
var session = require('express-session');
const memoryStore = new session.MemoryStore();
app.use(
  session({
    secret: 'XXj_XLsr7Skbg2djablo9ImtgFwuHFKMCnFII8g5pB0',
    resave: false,
    saveUninitialized: true,
    store: memoryStore
  })
);
var keycloak = new Keycloak({ store: memoryStore }, config.keycloak);

module.exports = keycloak;