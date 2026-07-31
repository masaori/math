/**
 * 寛容な解決（`resolveTolerantly`）の単体テスト。
 *
 * 見るべき性質は 2 つ:
 *   1. **壊れていても文書を返す**（プレビューが画面を落とさないための条件。live-preview F-9）
 *   2. **壊れた事実を捨てない**（未解決参照は本文にノードとして残り、迷子ノートも残る）
 *
 * 厳格な `resolve` が同じ入力でエラーになることも併せて確かめる
 * （両者が同じ実装を通っており、振る舞いの差が「畳み方」だけであることの担保）。
 */

import assert from 'node:assert/strict'
import { test } from 'node:test'

import type { Block, Note } from '../structured-text/block.ts'
import { paragraph, text } from '../structured-text/node.ts'
import { DEFAULT_NUMBERING_POLICY } from './numbering.ts'
import { resolve, resolveTolerantly, type RevisionSnapshot } from './resolve.ts'

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

const working = { numbering: DEFAULT_NUMBERING_POLICY, audience: 'working' as const }

test('未解決参照は本文から消えず unresolvedRef ノードとして残り、診断にも出る', () => {
  const revision = snapshot([
    {
      key: '001',
      blocks: [
        claim('a', ['c:1'], [paragraph([{ type: 'ref', target: 'c:missing', label: '例の補題' }])]),
      ],
    },
  ])

  const { document, diagnostics } = resolveTolerantly(revision, working)

  const block = document.blocks[0]
  assert.equal(block?.kind, 'claim')
  const node = block?.kind === 'claim' ? block.statement[0] : undefined
  assert.equal(node?.type, 'paragraph')
  assert.deepEqual(node?.type === 'paragraph' ? node.children[0] : undefined, {
    type: 'unresolvedRef',
    target: 'c:missing',
    fromBlockId: 'a',
    overrideText: '例の補題',
  })
  assert.deepEqual(diagnostics, [
    { code: 'unresolved_reference', fromBlockId: 'a', target: 'c:missing' },
  ])

  // 同じ入力を厳格に解決するとエラーになる（出版物には出さない）。
  assert.deepEqual(resolve(revision, working), {
    success: false,
    error: {
      code: 'unresolved_reference',
      references: [{ fromBlockId: 'a', target: 'c:missing' }],
    },
  })
})

test('迷子ノートは捨てられず orphanNotes に解決済みで残る（targets も分かる）', () => {
  const note: Note = { id: 'n1', targets: ['c:missing'], body: [text('補足')] }
  const revision = snapshot([{ key: '001', blocks: [claim('a', ['c:1'])], notes: [note] }])

  const { document, orphanNotes, diagnostics } = resolveTolerantly(revision, working)

  assert.deepEqual(document.notesByBlockId, {})
  assert.equal(orphanNotes.length, 1)
  assert.equal(orphanNotes[0]?.noteId, 'n1')
  assert.deepEqual(orphanNotes[0]?.targets, ['c:missing'])
  assert.deepEqual(orphanNotes[0]?.body, [{ type: 'text', value: '補足' }])
  assert.deepEqual(diagnostics, [
    { code: 'orphan_note', noteId: 'n1', targets: ['c:missing'] },
  ])

  assert.deepEqual(resolve(revision, working), {
    success: false,
    error: { code: 'orphan_note', noteIds: ['n1'] },
  })
})

test('紐づけ先が解決できるノートは、迷子ノートが同居していても配置される', () => {
  const good: Note = { id: 'n-good', targets: ['c:1'], body: [] }
  const orphan: Note = { id: 'n-orphan', targets: ['c:missing'], body: [] }
  const { document, orphanNotes } = resolveTolerantly(
    snapshot([{ key: '001', blocks: [claim('a', ['c:1'])], notes: [good, orphan] }]),
    working,
  )

  assert.deepEqual(
    document.notesByBlockId['a']?.map((note) => note.noteId),
    ['n-good'],
  )
  assert.deepEqual(
    orphanNotes.map((note) => note.noteId),
    ['n-orphan'],
  )
})

test('空文書でも文書を返す（ブロック 0 件 + 診断）', () => {
  const { document, diagnostics } = resolveTolerantly(snapshot([]), working)
  assert.deepEqual(document.blocks, [])
  assert.deepEqual(document.outline, [])
  assert.deepEqual(diagnostics, [{ code: 'empty_document' }])
})

test('id・ラベル・セグメントキーの重複でも解決を止めず、重複の事実を診断に残す', () => {
  const { document, diagnostics } = resolveTolerantly(
    snapshot([
      { key: 'dup', blocks: [claim('same', ['l:dup'])] },
      { key: 'dup', blocks: [claim('same', ['l:dup'])] },
    ]),
    working,
  )

  // 2 件とも文書に残る（黙って捨てない）。
  assert.deepEqual(
    document.blocks.map((block) => block.blockId),
    ['same', 'same'],
  )
  assert.deepEqual(diagnostics, [
    { code: 'duplicate_segment_key', key: 'dup' },
    { code: 'duplicate_block_id', blockId: 'same' },
    { code: 'duplicate_label', label: 'l:dup' },
  ])
})

test('壊れていなければ、寛容な解決の文書は厳格な解決の文書と同一である', () => {
  const revision = snapshot([
    {
      key: '001',
      blocks: [
        {
          id: 'h1',
          kind: 'heading',
          level: 1,
          labels: ['sec:1'],
          title: { text: '第1章' },
          origin: { path: '000_intro.ts', ordinal: 1 },
        },
        claim('a', ['c:1'], [paragraph([{ type: 'ref', target: 'c:2' }])]),
        claim('b', ['c:2']),
      ],
      notes: [{ id: 'n1', targets: ['c:1'], body: [text('補足')] }],
    },
  ])

  const strict = resolve(revision, working)
  const tolerant = resolveTolerantly(revision, working)

  assert.equal(strict.success, true)
  assert.deepEqual(strict.success ? strict.data : null, tolerant.document)
  assert.deepEqual(tolerant.diagnostics, [])
  assert.deepEqual(tolerant.orphanNotes, [])
})

test('解決済みブロックは由来（labels / origin）を運ぶ（画面に出すため。体裁には使わない）', () => {
  const { document } = resolveTolerantly(
    snapshot([
      {
        key: '001',
        blocks: [
          {
            id: 'a',
            kind: 'claim',
            labels: ['c:1', 'c:alias'],
            statement: [],
            origin: { path: '001_main.ts', ordinal: 3 },
          },
          claim('b', []),
        ],
      },
    ]),
    working,
  )

  assert.deepEqual(document.blocks[0]?.labels, ['c:1', 'c:alias'])
  assert.deepEqual(document.blocks[0]?.origin, { path: '001_main.ts', ordinal: 3 })
  assert.deepEqual(document.blocks[1]?.labels, [])
  assert.equal(document.blocks[1]?.origin, null)
})
