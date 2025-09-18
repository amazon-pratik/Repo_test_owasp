//{fact rule=cross-site-scripting@v1.0 defects=1}

module.exports = function showBoldName(name) {
  document.getElementById('name').innerHTML = "<b>" + name + "</b>";
}

//{/fact}