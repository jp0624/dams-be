# Dams Be

An administration API with content models, Keycloak integration, SQL and MongoDB dependencies, and spreadsheet import/export tooling.

## Local development

Run these commands from the repository root:

```sh
npm install
npm start
```

## Main dependencies

`express`, `mysql`, `mongodb`. See `package.json` for the full dependency list and versions.

Configure the external services used by the application before testing data-dependent features. Use your own development credentials and keep secrets out of Git.

Copy `.env.sample` to `.env`, choose `NODE_ENV=dev` or `NODE_ENV=qa`, and review `config.js` for the matching service settings. Keep the server port consistent with the reverse proxy.
