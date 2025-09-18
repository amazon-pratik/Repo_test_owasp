//{fact rule=cross-site-scripting@v1.0 defects=0}

const striptags = require('striptags');
module.exports = function showBoldName(name) {
  document.getElementById('name').innerHTML = "<b>" + striptags(name) + "</b>";
}

//{/fact}