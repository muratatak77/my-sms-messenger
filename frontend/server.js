const express = require('express');
const path = require('path');
const app = express();

// Güncellenmiş yol
app.use(express.static(path.join(__dirname, 'dist/frontend')));

app.get('/*', function(req, res) {
  res.sendFile(path.join(__dirname, 'dist/frontend/index.html'));
});

app.listen(process.env.PORT || 8080, () => {
  console.log(`Server listening on port ${process.env.PORT || 8080}`);
});