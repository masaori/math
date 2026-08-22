import assert from 'node:assert/strict'
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import test from 'node:test'

import { loadBlockFiles } from './content-modules.ts'

test('章配列のdefault exportを検証し、文書順のブロック列へ正規化する', async () => {
  const dir = mkdtempSync(join(tmpdir(), 'structured-latex-structure-'))
  try {
    writeFileSync(join(dir, 'chapter.ts'), `
export default [{
  kind: 'section', id: 'chapter', labels: [], title: { text: '章' }, children: [{
    role: 'primary', element: {
      kind: 'elementGroup', id: 'main-definition-group',
      focus: { kind: 'definition', id: 'main-definition', labels: [], statement: [] },
    },
  }],
}] as const
`)
    const loaded = await loadBlockFiles(dir)
    assert.equal(loaded[0]?.sourceKind, 'sections')
    assert.deepEqual(loaded[0]?.blocks.map(({ id }) => id), ['chapter', 'main-definition'])
  } finally {
    rmSync(dir, { recursive: true, force: true })
  }
})
