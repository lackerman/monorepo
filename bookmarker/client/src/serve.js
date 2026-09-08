// Minimal static file server for local development and as a smoke check of
// the built client assets. Deliberately dependency-free (uses only Node's
// built-in `http` module) so it needs no npm package linking at all.
const fs = require('fs');
const http = require('http');
const path = require('path');

const port = Number(process.argv[2]) || 3000;
const root = process.argv[3] || '.';

const CONTENT_TYPES = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.ico': 'image/x-icon',
  '.png': 'image/png',
};

http
  .createServer((req, res) => {
    const filePath = path.join(root, req.url === '/' ? 'index.html' : req.url);
    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not found');
        return;
      }
      const contentType = CONTENT_TYPES[path.extname(filePath)] || 'application/octet-stream';
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(data);
    });
  })
  .listen(port, () => {
    console.log(`Serving ${root} on port ${port}`);
  });
