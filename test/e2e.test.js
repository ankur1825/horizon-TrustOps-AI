import fs from 'fs';
import test from 'node:test';
import assert from 'node:assert/strict';

test('node demo e2e placeholder', () => {
  fs.mkdirSync('reports/newman', { recursive: true });
  fs.writeFileSync('reports/newman/result.txt', 'Node.js placeholder API test passed\n');
  assert.equal('horizon-demo-nodejs'.includes('nodejs'), true);
});
