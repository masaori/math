import assert from 'node:assert/strict'
import test from 'node:test'

import { compileDocumentStructure, type DocumentStructure, type Section } from './document-structure.ts'
import { createStructuredTextSchema } from './schema-factory.ts'
import type { BlocksOfSection } from './document-structure.ts'

const definition = (id: string) => ({ id, kind: 'definition' as const, labels: [], statement: [] })
const theorem = (id: string) => ({ id, kind: 'theorem' as const, labels: [], statement: [] })

test('節・要素グループを文書順のブロック列へ正規化し、所属を索引へ残す', () => {
  const document: DocumentStructure = {
    kind: 'documentStructure',
    sections: [
      {
        kind: 'section',
        id: 'transfer-matrix',
        labels: [],
        title: { text: '転送行列' },
        children: [
          {
            role: 'primary',
            element: {
              kind: 'elementGroup',
              id: 'transfer-matrix-definition-group',
              focus: definition('transfer-matrix-definition'),
            },
          },
          {
            role: 'primary',
            element: {
              kind: 'elementGroup',
              id: 'trace-formula-group',
              beforeFocus: [{ role: 'prerequisiteDefinition', element: definition('row-state') }],
              focus: theorem('trace-formula'),
            },
          },
        ],
      },
    ],
  }

  const result = compileDocumentStructure(document)
  assert.equal(result.success, true)
  if (!result.success) return
  assert.deepEqual(result.data.blocks.map((block) => block.id), [
    'transfer-matrix',
    'transfer-matrix-definition',
    'row-state',
    'trace-formula',
  ])
  assert.deepEqual(result.data.sections[0]?.primaryGroupIds, [
    'transfer-matrix-definition-group',
    'trace-formula-group',
  ])
  assert.equal(result.data.groups[0]?.focusBlockId, 'transfer-matrix-definition')
  assert.equal(result.data.groups[1]?.focusBlockId, 'trace-formula')
})

test('同じブロックを二つの所属へ置くと拒否する', () => {
  const shared = definition('shared')
  const document: DocumentStructure = {
    kind: 'documentStructure',
    sections: [{
      kind: 'section', id: 'section', labels: [], title: { text: '節' }, children: [
        { role: 'primary', element: { kind: 'elementGroup', id: 'first', focus: shared } },
        { role: 'supporting', element: { kind: 'elementGroup', id: 'second', focus: shared } },
      ],
    }],
  }
  const result = compileDocumentStructure(document)
  assert.equal(result.success, false)
  if (result.success) return
  assert.deepEqual(result.error, [{ code: 'duplicate_block_membership', blockId: 'shared' }])
})

test('節の深さが見出しの表現上限を超えると拒否する', () => {
  let section: Section = {
    kind: 'section' as const,
    id: 'depth-7', labels: [], title: { text: '深さ7' }, children: [],
  }
  for (let depth = 6; depth >= 1; depth -= 1) {
    section = {
      kind: 'section', id: `depth-${depth}`, labels: [], title: { text: `深さ${depth}` },
      children: [{ role: 'subsection', element: section }],
    }
  }
  const result = compileDocumentStructure({ kind: 'documentStructure', sections: [section] })
  assert.equal(result.success, false)
  if (result.success) return
  assert.deepEqual(result.error, [{ code: 'section_depth_exceeded', sectionId: 'depth-7', depth: 7 }])
})

test('defineSectionは章単位で文脈型を与え、型レベル平坦化はidのタプル情報を保つ', () => {
  const { defineSection } = createStructuredTextSchema<string>()
  const section = defineSection({
    kind: 'section', id: 'section', labels: [], title: { text: '節' }, children: [{
      role: 'primary', element: {
        kind: 'elementGroup', id: 'definition-group',
        focus: { kind: 'definition', id: 'definition', labels: [], statement: [] },
      },
    }],
  })
  type Flattened = BlocksOfSection<typeof section>
  const ids: [Flattened[0]['id'], Flattened[1]['id']] = ['section', 'definition']
  assert.deepEqual(ids, ['section', 'definition'])
})
