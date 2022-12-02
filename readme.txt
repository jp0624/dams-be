Configure server.js to run app on desired port. This must match any proxy server config pointing to that port.

Create .env file (from .env.sample) and specify environment. (/config.js holds all settings for each environment)

For local environment:

NODE_ENV=dev

For qa environment:

NODE_ENV=qa

First time you have to run npm install command once to install all the packages in packages.json

$ npm install

Then you can run the node server if local: 

$ node serve.js

Or use nodemon - to monitor the scripts. It will rerun the server if any code change happens and useful for developers

$ nodemon



