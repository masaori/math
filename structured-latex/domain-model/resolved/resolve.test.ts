import assert from 'node:assert/strict'
import { test } from 'node:test'

import { paragraph, text } from '../structured-text/node.ts'
import type { Block, Note } from '../structured-text/block.ts'
import { DEFAULT_NUMBERING_POLICY } from './numbering.ts'
import { resolve, resolveTolerantly, type RevisionSnapshot } from './resolve.ts'

const heading = (id: string, level: 1 | 2, label: string): Block => ({
  id,
  kind: 'heading',
  level,
  labels: [label],
  title: { text: id },
})

const claim = (id: string, labels: readonly string[], body: Block['statement'] = []): Block => ({
  id,
  kind: 'claim',
  labels,
  statement: body ?? [],
})

const snapshot = (segments: RevisionSnapshot['segments']): RevisionSnapshot => ({
  documentId: 'doc',
  revision: 1,
  segments,
})

const options = { numbering: DEFAULT_NUMBERING_POLICY, audience: 'publication' as const }

test('セグメントはキー昇順が文書順（配列の並び順ではない）', () => {
  const result = resolve(
    snapshot([
      { key: '002', blocks: [claim('b', [])] },
      { key: '001', blocks: [claim('a', [])] },
    ]),
    options,
  )
  assert.equal(result.success, true)
  assert.deepEqual(result.success && result.data.blocks.map((block) => block.blockId), ['a', 'b'])
})

test('採番: 見出しの階層と、見出しごとにリセットされる定理番号', () => {
  const result = resolve(
    snapshot([
      {
        key: '001',
        blocks: [
          heading('h1', 1, 'sec:1'),
          claim('c1', ['c:1']),
          claim('c2', ['c:2']),
          heading('h2', 2, 'sec:1.1'),
          claim('c3', ['c:3']),
          heading('h3', 1, 'sec:2'),
          claim('c4', ['c:4']),
        ],
      },
    ]),
    options,
  )
  assert.equal(result.success, true)
  if (!result.success) return
  const displays = Object.fromEntries(
    result.data.blocks.map((block) => [block.blockId, block.number?.display ?? null]),
  )
  assert.deepEqual(displays, {
    h1: '1',
    c1: '1.1',
    c2: '1.2',
    h2: '1.1',
    c3: '1.3',
    h3: '2',
    c4: '2.1',
  })
})

test('採番: 見出しより前のブロックは前置なしの通し番号になる', () => {
  const result = resolve(
    snapshot([{ key: '001', blocks: [claim('c1', []), heading('h1', 1, 'sec:1'), claim('c2', [])] }]),
    options,
  )
  assert.equal(result.success, true)
  if (!result.success) return
  assert.equal(result.data.blocks[0]?.number?.display, '1')
  assert.equal(result.data.blocks[2]?.number?.display, '1.1')
})

test('採番: 図表は定理型とは別のカウンタを持つ', () => {
  const figure: Block = { id: 'f1', kind: 'figure', labels: ['fig:1'], content: [] }
  const result = resolve(
    snapshot([{ key: '001', blocks: [claim('c1', []), figure, claim('c2', [])] }]),
    options,
  )
  assert.equal(result.success, true)
  if (!result.success) return
  assert.deepEqual(
    result.data.blocks.map((block) => `${block.kind}:${block.number?.display}`),
    ['claim:1', 'figure:1', 'claim:2'],
  )
})

test('参照は宛先の番号・種別・アンカーへ解決される（前方参照も含む）', () => {
  const result = resolve(
    snapshot([
      {
        key: '001',
        blocks: [
          claim('c1', ['c:1'], [paragraph([{ type: 'ref', target: 'c:2' }])]),
          claim('c2', ['c:2']),
        ],
      },
    ]),
    options,
  )
  assert.equal(result.success, true)
  if (!result.success) return
  const first = result.data.blocks[0]
  assert.equal(first?.kind, 'claim')
  const node = first?.kind === 'claim' ? first.statement[0] : undefined
  assert.equal(node?.type, 'paragraph')
  const ref = node?.type === 'paragraph' ? node.children[0] : undefined
  assert.deepEqual(ref, {
    type: 'ref',
    targetBlockId: 'c2',
    targetKind: 'claim',
    targetNumber: { path: [2], display: '2' },
    targetTitle: null,
    anchor: 'c2',
    overrideText: null,
  })
})

test('anchorPrefix は文書合成でアンカーが衝突しないための前置になる', () => {
  const result = resolve(snapshot([{ key: '001', blocks: [claim('c1', [])] }]), {
    ...options,
    anchorPrefix: 'commentary:',
  })
  assert.equal(result.success && result.data.blocks[0]?.anchor, 'commentary:c1')
})

test('ノートは publication では配置されず、working では配置される（I5）', () => {
  const note: Note = { id: 'n1', targets: ['c:1'], body: [text('補足')] }
  const revision = snapshot([{ key: '001', blocks: [claim('c1', ['c:1'])], notes: [note] }])

  const publication = resolve(revision, options)
  assert.equal(publication.success, true)
  assert.deepEqual(publication.success && publication.data.notesByBlockId, {})

  const working = resolve(revision, { ...options, audience: 'working' })
  assert.equal(working.success, true)
  assert.equal(working.success && working.data.notesByBlockId['c1']?.[0]?.noteId, 'n1')
})

test('ノートの targets が解決できなければ publication でもエラーになる', () => {
  const note: Note = { id: 'n1', targets: ['c:missing'], body: [] }
  const result = resolve(
    snapshot([{ key: '001', blocks: [claim('c1', ['c:1'])], notes: [note] }]),
    options,
  )
  assert.deepEqual(result, { success: false, error: { code: 'orphan_note', noteIds: ['n1'] } })
})

test('迷子かつ未解決参照を含むノートは unresolved_reference になる（迷子でも本文を解決するため）', () => {
  // 先行実装は迷子ノートの本文を解決せず読み飛ばしていたため、この未解決参照を見逃していた。
  // 今は迷子でも本文を解決するので診断が 2 件出て、`firstErrorOf` の優先順位により
  // 厳格な解決が返す種別は orphan_note ではなく unresolved_reference になる。
  const note: Note = {
    id: 'n1',
    targets: ['c:missing'],
    body: [paragraph([{ type: 'ref', target: 'c:also-missing' }])],
  }
  const revision = snapshot([{ key: '001', blocks: [claim('c1', ['c:1'])], notes: [note] }])

  assert.deepEqual(resolve(revision, options), {
    success: false,
    error: {
      code: 'unresolved_reference',
      references: [{ fromBlockId: 'n1', target: 'c:also-missing' }],
    },
  })

  // 寛容な解決は両方の不備を捨てずに返す（画面には迷子ノートも未解決参照も出す）。
  const tolerant = resolveTolerantly(revision, options)
  assert.deepEqual(tolerant.diagnostics, [
    { code: 'unresolved_reference', fromBlockId: 'n1', target: 'c:also-missing' },
    { code: 'orphan_note', noteId: 'n1', targets: ['c:missing'] },
  ])
  assert.deepEqual(tolerant.orphanNotes.map((n) => n.noteId), ['n1'])
  assert.deepEqual(tolerant.orphanNotes[0]?.body, [
    {
      type: 'paragraph',
      children: [
        {
          type: 'unresolvedRef',
          target: 'c:also-missing',
          fromBlockId: 'n1',
          overrideText: null,
        },
      ],
    },
  ])
})

test('文書全体にかかる不変条件の違反を、それぞれの code で返す', () => {
  assert.deepEqual(resolve(snapshot([]), options), {
    success: false,
    error: { code: 'empty_document' },
  })

  assert.deepEqual(
    resolve(
      snapshot([
        { key: 'dup', blocks: [claim('a', [])] },
        { key: 'dup', blocks: [claim('b', [])] },
      ]),
      options,
    ),
    { success: false, error: { code: 'duplicate_segment_key', keys: ['dup'] } },
  )

  assert.deepEqual(
    resolve(
      snapshot([
        { key: '001', blocks: [claim('same', [])] },
        { key: '002', blocks: [claim('same', [])] },
      ]),
      options,
    ),
    { success: false, error: { code: 'duplicate_block_id', blockIds: ['same'] } },
  )

  assert.deepEqual(
    resolve(
      snapshot([
        { key: '001', blocks: [claim('a', ['dup'])] },
        { key: '002', blocks: [claim('b', ['dup'])] },
      ]),
      options,
    ),
    { success: false, error: { code: 'duplicate_label', labels: ['dup'] } },
  )

  assert.deepEqual(
    resolve(
      snapshot([
        {
          key: '001',
          blocks: [claim('a', ['c:1'])],
          notes: [{ id: 'a', targets: ['c:1'], body: [] }],
        },
      ]),
      options,
    ),
    { success: false, error: { code: 'duplicate_note_id', noteIds: ['a'] } },
  )

  assert.deepEqual(
    resolve(
      snapshot([
        { key: '001', blocks: [claim('a', ['c:1'], [{ type: 'ref', target: 'c:missing' }])] },
      ]),
      options,
    ),
    {
      success: false,
      error: {
        code: 'unresolved_reference',
        references: [{ fromBlockId: 'a', target: 'c:missing' }],
      },
    },
  )
})

test('目次は見出しだけを文書順に並べたものになる', () => {
  const result = resolve(
    snapshot([
      { key: '001', blocks: [heading('h1', 1, 'sec:1'), claim('c1', []), heading('h2', 2, 'sec:2')] },
    ]),
    options,
  )
  assert.equal(result.success, true)
  assert.deepEqual(
    result.success && result.data.outline.map((entry) => [entry.blockId, entry.level]),
    [
      ['h1', 1],
      ['h2', 2],
    ],
  )
})

test('プロジェクト固有メタデータは meta へそのまま運ばれる（解釈しない）', () => {
  const block = {
    id: 'c1',
    kind: 'claim',
    labels: [],
    statement: [],
    habitat: 'uncountable',
    realEscape: '極限を取る箇所',
  } as const
  const result = resolve(snapshot([{ key: '001', blocks: [block] }]), options)
  assert.equal(result.success, true)
  if (!result.success) return
  const resolved = result.data.blocks[0]
  assert.deepEqual(resolved?.kind === 'claim' ? resolved.meta : null, {
    habitat: 'uncountable',
    realEscape: '極限を取る箇所',
  })
})
