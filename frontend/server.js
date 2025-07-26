const express = require('express');
const path = require('path');
const app = express();

// Static klasörü doğru ayarla
app.use(express.static(path.join(__dirname, 'dist/frontend/browser')));

// Tüm route'lara index.html dön
app.get('*', function(req, res) {
  res.sendFile(path.join(__dirname, 'dist/frontend/browser/index.html'));
});

app.listen(process.env.PORT || 8080, () => {
  console.log(`Server listening on port ${process.env.PORT || 8080}`);
});
