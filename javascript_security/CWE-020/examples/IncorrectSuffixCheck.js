//{fact rule=improper-input-validation@v1.0 defects=1}

function endsWith(x, y) {
  return x.lastIndexOf(y) === x.length - y.length;
}

//{/fact}
