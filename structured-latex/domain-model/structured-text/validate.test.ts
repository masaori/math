import assert from 'node:assert/strict'
import { test } from 'node:test'
import { z } from 'zod'

import { createRuntimeSchema } from './validate.ts'

const schema = createRuntimeSchema()

test('正しいブロックはそのまま通る', () => {
  const result = schema.validateBlock(
    {
      id: 'b1',
      kind: 'theorem',
      labels: ['thm:a'],
      statement: [{ type: 'paragraph', children: [{ type: 'text', value: '本文' }] }],
    },
    'fixture',
  )
  assert.equal(result.success, true)
})

test('未知のフィールドは拒否する（打ち間違いで中身が黙って捨てられるのを防ぐ）', () => {
  const result = schema.validateBlock(
    { id: 'b1', kind: 'theorem', labels: [], statement: [], proofs: [] },
    'fixture',
  )
  assert.equal(result.success, false)
  assert.equal(result.success === false && result.error[0]?.path, 'fixture:b1')
  assert.match(result.success === false ? (result.error[0]?.message ?? '') : '', /proofs/)
})

test('見出しは本文を持てない', () => {
  const result = schema.validateBlock(
    { id: 'h1', kind: 'heading', level: 1, labels: [], title: { text: '章' }, statement: [] },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('タイトルは text か tex の少なくとも一方が必須', () => {
  const result = schema.validateBlock(
    { id: 'h1', kind: 'heading', level: 1, labels: [], title: {} },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('見出しの level は 1..6', () => {
  const result = schema.validateBlock(
    { id: 'h1', kind: 'heading', level: 7, labels: [], title: { text: '章' } },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('ノード種別は閉じている（語彙外は拒否）', () => {
  const result = schema.validateBlock(
    { id: 'b1', kind: 'claim', labels: [], statement: [{ type: 'callout', value: 'x' }] },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('図表ブロックと画像ノードを受け入れる', () => {
  const result = schema.validateBlock(
    {
      id: 'f1',
      kind: 'figure',
      labels: ['fig:a'],
      content: [{ type: 'image', assetKey: 'a.png', alt: '格子の図' }],
      caption: [{ type: 'text', value: '格子' }],
    },
    'fixture',
  )
  assert.equal(result.success, true)
})

test('画像は alt が必須（テキストしか出せない文脈へ劣化できるようにするため）', () => {
  const result = schema.validateBlock(
    {
      id: 'f1',
      kind: 'figure',
      labels: [],
      content: [{ type: 'image', assetKey: 'a.png' }],
    },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('引用ノードを受け入れる（note は任意）', () => {
  const result = schema.validateBlock(
    {
      id: 'b1',
      kind: 'claim',
      labels: [],
      statement: [
        { type: 'cite', keys: ['Monsky1981'] },
        { type: 'cite', keys: ['Monsky1981', 'CuocoMonsky1981'], note: 'Theorem 5.6' },
      ],
    },
    'fixture',
  )
  assert.equal(result.success, true)
})

test('引用ノードの keys は 1 件以上（引用先の無い引用は意味を持たない）', () => {
  const result = schema.validateBlock(
    { id: 'b1', kind: 'claim', labels: [], statement: [{ type: 'cite', keys: [] }] },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('引用ノードの未知フィールドは拒否する（キー名の打ち間違いで引用が黙って消えるのを防ぐ）', () => {
  const result = schema.validateBlock(
    { id: 'b1', kind: 'claim', labels: [], statement: [{ type: 'cite', key: ['Monsky1981'] }] },
    'fixture',
  )
  assert.equal(result.success, false)
})

test('ノートの targets は 1 件以上', () => {
  const result = schema.validateNote({ id: 'n1', targets: [], body: [] }, 'fixture')
  assert.equal(result.success, false)
})

test('宣言したメタデータのキーだけが許可キーに加わる', () => {
  const withMeta = createRuntimeSchema<string, { habitat: string }, { habitat: z.ZodTypeAny }>({
    blockMeta: { habitat: z.enum(['countable', 'uncountable']) },
  })
  assert.equal(
    withMeta.validateBlock(
      { id: 'b1', kind: 'claim', labels: [], statement: [], habitat: 'countable' },
      'fixture',
    ).success,
    true,
  )
  // 宣言していないキーは拒否される。
  assert.equal(
    withMeta.validateBlock(
      { id: 'b1', kind: 'claim', labels: [], statement: [], habitatt: 'countable' },
      'fixture',
    ).success,
    false,
  )
  // 宣言した値域から外れた値も拒否される。
  assert.equal(
    withMeta.validateBlock(
      { id: 'b1', kind: 'claim', labels: [], statement: [], habitat: 'complex' },
      'fixture',
    ).success,
    false,
  )
})

test('語彙を所有しない読み手は、未知のメタデータを落とさずに通せる', () => {
  const reader = createRuntimeSchema({ unknownBlockMeta: 'passthrough' })
  const block = {
    id: 'b1',
    kind: 'claim',
    labels: [],
    statement: [],
    habitat: 'countable',
    lean: ['Foo.bar'],
  }
  const result = reader.validateBlock(block, 'fixture')
  assert.equal(result.success, true)
  // **通すだけでなく、値を保つこと**が要件。strip されるとメタデータが黙って消える。
  assert.deepEqual(result.success ? result.data : null, block)

  // 見出しと図表はメタデータを持てない設計なので、passthrough でも拒否したまま。
  assert.equal(
    reader.validateBlock(
      { id: 'h1', kind: 'heading', level: 1, labels: [], title: { text: '章' }, habitat: 'x' },
      'fixture',
    ).success,
    false,
  )
})

test('エラーは 1 件目で止めずに全件返す', () => {
  const result = schema.validateBlocks(
    [
      { id: 'b1', kind: 'claim', labels: [], statement: [], oops: 1 },
      { id: 'b2', kind: 'claim', labels: [], statement: [], oops: 1 },
    ],
    'fixture',
  )
  assert.equal(result.success, false)
  assert.equal(result.success === false && result.error.length, 2)
})
