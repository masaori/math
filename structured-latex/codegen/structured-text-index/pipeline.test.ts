/**
 * 入力から解決済み文書までを通しで確かめる統合テスト。
 *
 * 単体テストは各段を個別に見るが、「著者が書いた実物を読み込み → 実行時検証 → 解決」という
 * 経路が繋がっていることは通しでしか確かめられない。対象は `examples/minimal-document/`。
 */

import assert from 'node:assert/strict'
import { dirname, join } from 'node:path'
import { test } from 'node:test'
import { fileURLToPath } from 'node:url'

import { DEFAULT_NUMBERING_POLICY, resolve } from '../../domain-model/index.ts'
import type { SegmentSnapshot } from '../../domain-model/index.ts'
import { runtimeSchema } from '../../examples/minimal-document/schema.ts'
import { loadContentFiles, loadNoteFiles } from './content-modules.ts'

const systemDir = join(dirname(fileURLToPath(import.meta.url)), '..', '..')
const projectDir = join(systemDir, 'examples', 'minimal-document')

const loadSegments = async (): Promise<SegmentSnapshot[]> => {
  const content = await loadContentFiles(projectDir)
  const notes = await loadNoteFiles(projectDir)
  return content.map(({ file, blocks }) => ({
    key: file,
    blocks,
    notes: notes.find((note) => note.file === file)?.notes ?? [],
  }))
}

test('著者が書いた実物が、実行時検証を通る', async () => {
  for (const { file, blocks } of await loadContentFiles(projectDir)) {
    const result = runtimeSchema.validateBlocks(blocks, file)
    assert.equal(result.success, true, JSON.stringify(result.success ? [] : result.error))
  }
  for (const { file, notes } of await loadNoteFiles(projectDir)) {
    const result = runtimeSchema.validateNotes(notes, file)
    assert.equal(result.success, true, JSON.stringify(result.success ? [] : result.error))
  }
})

test('実物が解決済み文書まで通り、採番と参照が確定する', async () => {
  const result = resolve(
    { documentId: 'minimal', revision: 1, segments: await loadSegments() },
    { numbering: DEFAULT_NUMBERING_POLICY, audience: 'publication' },
  )
  assert.equal(result.success, true, JSON.stringify(result.success ? '' : result.error))
  if (!result.success) return

  // 文書順（セグメントのキー昇順 × 配列順）と採番。
  assert.deepEqual(
    result.data.blocks.map((block) => `${block.kind}:${block.number?.display ?? '-'}`),
    ['heading:1', 'definition:1.1', 'heading:2', 'theorem:2.1', 'figure:2.1'],
  )

  // 図表は定理型と別カウンタなので、同じ「2.1」でも衝突ではない。
  const figure = result.data.blocks.find((block) => block.kind === 'figure')
  assert.equal(figure?.kind === 'figure' && figure.caption !== null, true)

  // 出版ターゲットではノートが配置されない（I5）。
  assert.deepEqual(result.data.notesByBlockId, {})

  // 目次は見出しだけ。
  assert.deepEqual(
    result.data.outline.map((entry) => entry.blockId),
    ['intro_heading', 'main_heading'],
  )
})

test('working では同じ入力からノートが配置される', async () => {
  const result = resolve(
    { documentId: 'minimal', revision: 1, segments: await loadSegments() },
    { numbering: DEFAULT_NUMBERING_POLICY, audience: 'working' },
  )
  assert.equal(result.success, true)
  assert.equal(
    result.success && result.data.notesByBlockId['main_theorem_limit']?.[0]?.noteId,
    'note_main_theorem_limit_background',
  )
})
