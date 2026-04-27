import fs from 'fs';
import path from 'path';

const distDir = path.resolve('dist');
fs.mkdirSync(distDir, { recursive: true });
fs.copyFileSync('src/server.js', path.join(distDir, 'server.js'));
fs.writeFileSync(
  path.join(distDir, 'build-info.json'),
  JSON.stringify({ service: 'horizon-demo-nodejs', builtAt: new Date().toISOString() }, null, 2)
);
console.log('Node.js demo build complete');
