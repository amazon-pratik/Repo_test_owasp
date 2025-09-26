//{fact rule=mass-assignment@v1.0 defects=1}
const lodash = require('lodash')

app.get('/news', (req, res) => {
  let prefs = lodash.merge({}, JSON.parse(req.query.prefs));
})

//{/fact}