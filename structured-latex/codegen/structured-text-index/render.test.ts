import assert from 'node:assert/strict'
import { test } from 'node:test'

import { renderDocument, renderLabels } from './render.ts'

test('ラベルのユニオン型は入力どおりに、決定的に出る', () => {
  const rendered = renderLabels(['lab:a', 'lab:b'])
  assert.match(rendered, /export const ALL_LABELS = \[\n {2}"lab:a",\n {2}"lab:b",\n\] as const/)
  assert.match(rendered, /export type Label = \(typeof ALL_LABELS\)\[number\]/)
  // 同じ入力なら常に同じ出力（エントロピー 0）。
  assert.equal(rendered, renderLabels(['lab:a', 'lab:b']))
})

test('集約モジュールは全ファイルを 1 本のタプルへ連結し、一意性を制約として主張する', () => {
  const rendered = renderDocument({
    domainModelSpecifier: '../../domain-model/index.ts',
    contentFiles: ['000_a.ts', '001_b.ts'],
    noteFiles: ['001_b.ts'],
  })
  assert.match(rendered, /import blocks_000_a from '\.\/content\/000_a\.ts'/)
  assert.match(rendered, /import notes_001_b from '\.\/notes\/001_b\.ts'/)
  assert.match(rendered, /export type AllBlocks = \[\n {2}\.\.\.typeof blocks_000_a,/)
  // 一意性は「制約」の形でなければ検査にならない（条件型のままだと偽でも通る）。
  assert.match(rendered, /_UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>/)
  assert.match(rendered, /_UniqueLabels = AssertNoDuplicate<FindDuplicate<AllLabels>>/)
  assert.match(rendered, /_NoIdCollision = AssertNoDuplicate</)
  // 生成済みラベル一覧と実状のずれを両方向で検査する。
  assert.match(rendered, /_NoStaleGeneratedLabel = AssertNoDuplicate<Exclude<Label, AllLabels\[number\]>>/)
  assert.match(rendered, /_NoMissingGeneratedLabel = AssertNoDuplicate<Exclude<AllLabels\[number\], Label>>/)
})

test('ノートが 1 件も無くても集約モジュールは成立する', () => {
  const rendered = renderDocument({
    domainModelSpecifier: '../../domain-model/index.ts',
    contentFiles: ['000_a.ts'],
    noteFiles: [],
  })
  assert.match(rendered, /export type AllNotes = \[\]/)
})
