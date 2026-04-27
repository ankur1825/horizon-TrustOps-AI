import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (_req, res) => {
  res.json({
    service: 'horizon-demo-nodejs',
    framework: 'Node.js',
    status: 'ready'
  });
});

app.get('/health', (_req, res) => {
  res.json({ status: 'UP' });
});

app.listen(port, () => {
  console.log(`horizon-demo-nodejs listening on ${port}`);
});
