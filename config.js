var config = {
  dev: {
    mysql: {
      host: 'localhost',
      port: 3306,
      user: 'dams',
      password: 'Password#1',
      database: 'dams_schema'
    },
    mongo: {
      host: '127.0.0.1',
      port: 27017,
      user: '',
      password: '',
      database: 'dams_mongo'
    },
    server: {
      host: 'localhost',
      port: 3001
    },
    keycloak: {
      clientId: 'nodejs',
      bearerOnly: true,
      serverUrl: 'http://localhost:8080/auth',
      realm: 'master',
      realmPublicKey:
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiyiYRap/12wcQIHORYt9F4JNT/zY8i9zEbBVhBcUAoyhuRA2bAsb2xvjjJD7aOm41t4DakWdl6cJF9tPDp583O86C9Y1iLi9A2Xs5dU+erHPp2K1d7kTPwQAV72Yy6CgvqgCqkZ58keEl4v2E6ZpI6AS7OVNziZWl2TBLiCKYCq4++ExHhM9R9BW1sDVwp02OKoDkjt5dmJKwgvyJfC9IkkJ8wfin4q8bodo4OVCyg/mMWB9/IxrjLaQw8rIu0thIupbDG/bcMefbnx+aWfSJyKFte85n3/6gsBTMHuC9f8IHvGqbLlIjQ6HMi1w5YI6ZBqWaWc9A9Qmyiu9+xqUrQIDAQAB'
    },
    lessonsFolderPath: './media/courses/',
    isMongoStorageRequired: false
  },
  int: {
    mysql: {
      host: '192.168.4.46',
      port: 3306,
      user: 'admin',
      password: 'sonic_root',
      database: 'dams_schema'
    },
    mongo: {
      host: 'lrs1.int.fleetdefense.com',
      port: 27017,
      user: '',
      password: '',
      database: 'dams_mongo'
    },
    server: {
      host: '127.0.0.1',
      port: 3001
    },
    keycloak: {
      clientId: 'AD-dams',
      bearerOnly: true,
      serverUrl: 'https://login.int.fleetdefense.com/auth',
      realm: 'fleetdefense',
      realmPublicKey:
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoynqBFcP2CustZOMSOV2v8B1i6MX9IBiySDYVbDicLwlzpIfaknpky9qa06aAoU8gh77LLTKAxXrCLEhC0NobmxTdscHEWCPiN2r9waVpTlbCj+v6a4MpFpNEIYG/8RSGDj16HjxLsKGu2wYQxHUpduMKrf9zRhW+z3MRDy4c9/wFwlQDNs+f/4T4/+TDKNxQhkCaKBz4N8l87ri3ukTbn05VHp1aibqQf66RSB1X7mHu///G2Zh9Orz+XfQEuclaL37wPsY2X4Ught7MOEaavfSbLZviStiH7mwZq0OeRTRSN+66c/tVnMwaKQSGeaHBzTedbcV0yz2TLQ4HU/ebQIDAQAB'
    },
    lessonsFolderPath: './media/courses/',
    isMongoStorageRequired: false
  },
  default: {
    mysql: {
      host: 'sql.fleetdefense.com',
      port: 3306,
      user: 'dams',
      password: 'sonic_root',
      database: 'dams_schema'
    },
    mongo: {
      host: '127.0.0.1',
      port: 27017,
      user: '',
      password: '',
      database: 'dams_mongo'
    },
    server: {
      host: '127.0.0.1',
      port: 3001
    },
    keycloak: {
      clientId: 'nodejs',
      bearerOnly: true,
      serverUrl: 'http://localhost:8080/auth',
      realm: 'master',
      realmPublicKey:
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiyiYRap/12wcQIHORYt9F4JNT/zY8i9zEbBVhBcUAoyhuRA2bAsb2xvjjJD7aOm41t4DakWdl6cJF9tPDp583O86C9Y1iLi9A2Xs5dU+erHPp2K1d7kTPwQAV72Yy6CgvqgCqkZ58keEl4v2E6ZpI6AS7OVNziZWl2TBLiCKYCq4++ExHhM9R9BW1sDVwp02OKoDkjt5dmJKwgvyJfC9IkkJ8wfin4q8bodo4OVCyg/mMWB9/IxrjLaQw8rIu0thIupbDG/bcMefbnx+aWfSJyKFte85n3/6gsBTMHuC9f8IHvGqbLlIjQ6HMi1w5YI6ZBqWaWc9A9Qmyiu9+xqUrQIDAQAB'
    },
    lessonsFolderPath: './media/courses/',
    isMongoStorageRequired: false
  }
};
module.exports = config;
