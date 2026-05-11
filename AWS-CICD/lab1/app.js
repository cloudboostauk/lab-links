const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => {
  res.send('<h1>QuickShop</h1><p>Deployed with CI/CD to EC2.</p>');
});

app.listen(port, () => {
  console.log(`QuickShop app listening on port ${port}`);
});
