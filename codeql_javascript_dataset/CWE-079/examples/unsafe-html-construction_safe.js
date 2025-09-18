//{fact rule=cross-site-scripting@v1.0 defects=0}

module.exports = function showBoldName(name) {
  const bold = document.createElement('b');
  bold.innerText = name;
  document.getElementById('name').appendChild(bold);
}

//{/fact}