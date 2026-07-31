/**
 * ライブプレビューの配信契約の単体テスト。
 * 境界（HTTP レスポンス）で throw せず Result になること、
 * 語彙を所有しない立場でプロジェクト固有メタデータを落とさないことを見る。
 */

import assert from 'node:assert/strict'
import { test } from 'node:test'

import { PREVIEW_RELOAD_EVENT, parseDocumentResponse } from './live-preview.ts'

const validBody = {
  blocks: [
    { id: 'a', kind: 'claim', labels: ['c:1'], statement: [{ type: 'text', value: 'x' }] },
  ],
  notes: [{ id: 'n1', targets: ['c:1'], body: [] }],
  generatedAt: '2026-08-01T00:00:00.000Z',
  sourceLabel: 'proj/structured-latex/content',
}

test('正しいレスポンスは blocks / notes ごと通る', () => {
  const parsed = parseDocumentResponse(validBody)
  assert.equal(parsed.success, true)
  if (!parsed.success) return
  assert.equal(parsed.data.blocks.length, 1)
  assert.equal(parsed.data.notes.length, 1)
  assert.equal(parsed.data.sourceLabel, 'proj/structured-latex/content')
})

test('notes が無いレスポンスはノート 0 件として通る（ノートは任意）', () => {
  const { notes: _notes, ...withoutNotes } = validBody
  const parsed = parseDocumentResponse(withoutNotes)
  assert.equal(parsed.success && parsed.data.notes.length, 0)
})

test('プロジェクト固有メタデータは未知のキーでも落とさずに通す', () => {
  const parsed = parseDocumentResponse({
    ...validBody,
    blocks: [{ ...validBody.blocks[0], habitat: 'countable' }],
  })
  assert.equal(parsed.success, true)
  if (!parsed.success) return
  assert.equal((parsed.data.blocks[0] as { habitat?: unknown }).habitat, 'countable')
})

test('外枠が壊れていれば throw せず validation_error になる', () => {
  const parsed = parseDocumentResponse({ blocks: 'not an array' })
  assert.equal(parsed.success, false)
  assert.equal(parsed.success === false && parsed.error.code, 'validation_error')
})

test('入力言語として不正なブロックは validation_error になり、位置が分かる', () => {
  const parsed = parseDocumentResponse({
    ...validBody,
    blocks: [{ id: 'a', kind: 'claim', labels: [], statement: [{ type: 'unknown-node' }] }],
  })
  assert.equal(parsed.success, false)
  if (parsed.success || parsed.error.code !== 'validation_error') return
  assert.ok(parsed.error.issues.length > 0)
  assert.ok(parsed.error.issues[0]?.path.startsWith('blocks[0]:a'))
})

test('SSE のイベント名は reload', () => {
  assert.equal(PREVIEW_RELOAD_EVENT, 'reload')
})
