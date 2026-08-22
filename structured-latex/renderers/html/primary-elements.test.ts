import assert from 'node:assert/strict'
import test from 'node:test'

import { primaryElementEntriesOf, renderPrimaryElementsLead } from './primary-elements.ts'
import { compileDocumentStructure } from '../../domain-model/structured-text/document-structure.ts'

test('主要要素が無い節では案内を出さない', () => {
  assert.equal(renderPrimaryElementsLead([]), '')
})

test('主な定義と主定理を別の意味見出しで同じ節の案内へ出す', () => {
  const html = renderPrimaryElementsLead([
    { anchor: 'definition', kind: 'definition', text: '定義 2.1（転送行列）' },
    { anchor: 'theorem', kind: 'theorem', text: '定理 2.4（トレース表示）' },
  ])
  assert.match(html, /この節の主な定義/)
  assert.match(html, /href="#definition"/)
  assert.match(html, /この節の主定理・主張/)
  assert.match(html, /href="#theorem"/)
})

test('主張だけの節では空の定義見出しを出さない', () => {
  const html = renderPrimaryElementsLead([
    { anchor: 'claim', kind: 'claim', text: '主張 3.2（補題）' },
  ])
  assert.doesNotMatch(html, /この節の主な定義/)
  assert.match(html, /この節の主定理・主張/)
})

test('主要要素は明示された節所属とグループの中心から取得する', () => {
  const compiled = compileDocumentStructure({
    kind: 'documentStructure',
    sections: [{
      kind: 'section', id: 'section', labels: [], title: { text: '節' }, children: [
        { role: 'primary', element: {
          kind: 'elementGroup', id: 'primary-definition',
          focus: { kind: 'definition', id: 'definition', labels: [], statement: [] },
        } },
        { role: 'supporting', element: {
          kind: 'elementGroup', id: 'supporting-theorem',
          focus: { kind: 'theorem', id: 'theorem', labels: [], statement: [] },
        } },
      ],
    }],
  })
  assert.equal(compiled.success, true)
  if (!compiled.success) return
  assert.deepEqual(
    primaryElementEntriesOf(compiled.data, 'section', (block) => block.id),
    [{ anchor: 'definition', kind: 'definition', text: 'definition' }],
  )
})
