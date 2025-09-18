//{fact rule=code-injection@v1.0 defects=0}

export function safeDeserialize(value) {
  return JSON.parse(value);
}

//{/fact}

//{fact rule=code-injection@v1.0 defects=0}

const _ = require("lodash");
export function safeGetter(object, path) {
  return _.get(object, path);
}

//{/fact}
