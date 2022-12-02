var env = process.env.NODE_ENV || 'dev';
var config = require('./config')[env];

var express = require('express');
var bodyParser = require('body-parser');
var bcrypt = require('bcryptjs');
var mysql = require('mysql');
var multer = require('multer');
var cors = require('cors');
var app = express();
var swaggerUi = require('swagger-ui-express');
var swaggerDocument = require('./swagger.json');
// var logger = require('./logger');

// Use CORS Middleware
app.use(cors());

// Cors set response headers
app.use(function(req, res, next) {
  // Website you wish to allow to connect
  // res.setHeader('Access-Control-Allow-Origin', 'http://localhost:4200');
  // res.setHeader('Access-Control-Allow-Origin', 'https://www.google.ca');
  res.header('Access-Control-Allow-Origin', '*');

  // Request headers you wish to allow
  res.header(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With,content-type, Origin, Accept, Authorization'
  );

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.header('Access-Control-Allow-Credentials', true);

  if ( 'OPTIONS' === req.method ) {
    // Access-Control-Allow-Methods is required only for OPTION method
    // Request methods you wish to allow
    // res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.header(
      'Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'
    );

    return res.status(200).json({});
  }

  // Pass to next layer of middleware
  next();
});

// Body parder - to read the request body content (eg: req.body.task_id)
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// app.use(logger);
// Set Static Path
app.use('/', express.static(__dirname));

//swagger
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
//app.use('/api/v1', app);

var session = require('express-session');
// var Keycloak = require('keycloak-connect');

// var memoryStore = new session.MemoryStore();
// app.use(
//   session({
//     secret: 'XXj_XLsr7Skbg2djablo9ImtgFwuHFKMCnFII8g5pB0',
//     resave: false,
//     saveUninitialized: true,
//     store: memoryStore
//   })
// );

// console.log('config.keycloak' + config.keycloak);
// var keycloak = new Keycloak({ store: memoryStore }, config.keycloak);

// app.use(keycloak.middleware({ logout: '/logoff' }));

// Import API Routes
const lessonRoutes = require('./router/lesson_api');
const globalRoutes = require('./router/_global_api');
const userRoutes = require('./router/user_api');
const loginRoutes = require('./router/login_api');
const languageRoutes = require('./router/language_api');
const countryRoutes = require('./router/country_api');
const courseRoutes = require('./router/course_api');
const translationRoutes = require('./router/translation_api');
const vehicleRoutes = require('./router/vehicle_api');
const statusRoutes = require('./router/status_api');
const dictionaryRoutes = require('./router/dictionary_api');
const taskRoutes = require('./router/task_api');
const localizeRoutes = require('./router/localize_api');
const mediaRoutes = require('./router/media_api');
const excelRoutes = require('./router/excel_api');
const fieldExistsRoutes = require('./router/field_exists_api');
const lessonTypeRoutes = require('./router/lesson_type_api');
const alertRoutes = require('./router/alert_api');
const versionRoutes = require('./router/version_api');

app.use('/lesson', lessonRoutes);
app.use('/global', globalRoutes);
app.use('/user', userRoutes);
app.use('/security', loginRoutes);
app.use('/language', languageRoutes);
app.use('/country', countryRoutes);
app.use('/course', courseRoutes);
app.use('/translation', translationRoutes);
app.use('/vehicle', vehicleRoutes);
app.use('/status', statusRoutes);
app.use('/dictionary', dictionaryRoutes);
app.use('/task', taskRoutes);
app.use('/localize', localizeRoutes);
app.use('/media', mediaRoutes);
app.use('/excel', excelRoutes);
app.use('/fieldexists', fieldExistsRoutes);
app.use('/lesson-type', lessonTypeRoutes);
app.use('/alert', alertRoutes);
app.use('/version', versionRoutes);

module.exports = app;
