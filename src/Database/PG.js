'use strict';

var pg = require('pg');

exports.connect = function(url) {
  return function(onSuccess, onError) {
    var client = new pg.Client(url);
    client.connect(function(err) {
      if (err) {
        onError(err);
      } else {
        onSuccess(client);
      }
    });
  };
};

exports._queryResultType = function(client) {
  return function(sql) {
    sql = 'SELECT t.* FROM (' + sql + ') AS t LIMIT 0';
    return function(onSuccess, onError) {
      client.query(sql, [], function(err, result) {
        if (err) {
          onError(err);
        } else {
          onSuccess(result.fields.map(function(field) {
            return {name: field.name, type: field.dataTypeID};
          }));
        }
      });
    };
  };
};
