#!/usr/bin/env node
/**
 * 「誤った入力を書くと**型検査が実際に落ちる**」ことの実証テスト。
 *
 * 目的は「型検査は通っているが、実は何も検出していない」状態を否定することである。
 * 先行実装では、集約モジュールを tsconfig の include に入れ忘れて検査が無音で無効化されていた
 * 事故が実際にあり、この負テストを書いて初めて気づいた。
 *
 * 各ケースは**対で**回す:
 *   1. 正しい版 → tsc が**成功すること**（設定不備で常に落ちているだけではないことの対照）
 *   2. 壊した版 → tsc が**失敗し**、診断に期待する語が現れること
 *
 * 使い方: node tools/negative-type-test.ts
 */

import { execFileSync } from 'node:child_process'
import { mkdirSync, rmSync, writeFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const systemDir = join(dirname(fileURLToPath(import.meta.url)), '..')
const tmpDir = join(systemDir, 'tools', '.tmp')
const tsc = join(systemDir, 'node_modules', '.bin', 'tsc')

/** 各ケースに共通で置くファイル（ラベル型とファクトリの具体化）。 */
const commonFiles: Record<string, string> = {
  'labels.ts': `export type Label = 'lab:a' | 'lab:b'\n`,
  'schema.ts': `import { createStructuredTextSchema } from '../../../domain-model/index.ts'
import type { Label } from './labels.ts'

export type Habitation =
  | { habitat: 'countable'; realEscape?: never }
  | { habitat: 'uncountable'; realEscape: string }

export const { defineBlocks, defineNotes, ref } = createStructuredTextSchema<Label, Habitation>()
`,
  // exclude も継承されるので明示的に空へ戻す（親の exclude は tools/.tmp を含むため、
  // そのままだとフィクスチャ自身が検査対象から外れて「入力が 1 件も無い」になる）。
  'tsconfig.json': `{
  "extends": "../../../tsconfig.json",
  "include": ["./**/*.ts"],
  "exclude": []
}
`,
}

const blocksModule = (body: string): string =>
  `import { paragraph } from '../../../domain-model/index.ts'
import { defineBlocks, ref } from './schema.ts'

// 使わないケースでも import は固定にしておく（未使用 import で落ちないよう void で消費する）。
void paragraph
void ref

export default defineBlocks([
${body}
])
`

const notesModule = (body: string): string =>
  `import { defineNotes } from './schema.ts'

export default defineNotes([
${body}
])
`

/** 1 件の定理型ブロック（差し込み用）。 */
const theorem = (options: {
  id: string
  labels?: readonly string[]
  statement?: string
  extra?: string
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: 'claim',
    labels: [${(options.labels ?? []).map((label) => JSON.stringify(label)).join(', ')}],
    habitat: 'countable',
    statement: [${options.statement ?? ''}],${options.extra ?? ''}
  },`

type Case = {
  name: string
  /** `broken` が true のときだけ誤りを含むファイル群を返す。 */
  files: (broken: boolean) => Record<string, string>
  /** 壊した版の診断に必ず現れるべき文字列。 */
  expect: string
}

const aggregatorModule = (): string => `import type {
  AssertNoDuplicate,
  BlockIdsOf,
  FindDuplicate,
  LabelsOf,
  NoteIdsOf,
} from '../../../domain-model/index.ts'
import blocksA from './a.ts'
import blocksB from './b.ts'
import notesC from './c.ts'

type AllBlocks = [...typeof blocksA, ...typeof blocksB]
type AllNotes = [...typeof notesC]
type AllBlockIds = BlockIdsOf<AllBlocks>
type AllNoteIds = NoteIdsOf<AllNotes>

export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<LabelsOf<AllBlocks>>>
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>
`

const cases: Case[] = [
  {
    name: '本文中の ref が存在しないラベルを指す',
    expect: 'lab:missing',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        theorem({
          id: 'ref_case',
          statement: `paragraph(['参照: ', ref(${broken ? "'lab:missing'" : "'lab:a'"})])`,
        }),
      ),
    }),
  },
  {
    name: 'ブロックが未登録のラベルを宣言する（生成物の再生成漏れ）',
    expect: 'lab:unregistered',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        theorem({ id: 'label_case', labels: [broken ? 'lab:unregistered' : 'lab:a'] }),
      ),
    }),
  },
  {
    name: 'ノートの targets が存在しないラベルを指す',
    expect: 'lab:missing',
    files: (broken) => ({
      'fixture.ts': notesModule(
        `  { id: 'note_case', targets: [${broken ? "'lab:missing'" : "'lab:a'"}], body: [] },`,
      ),
    }),
  },
  {
    name: 'ノートの targets が空',
    expect: 'Source has 0 element',
    files: (broken) => ({
      'fixture.ts': notesModule(
        `  { id: 'note_empty', targets: [${broken ? '' : "'lab:a'"}], body: [] },`,
      ),
    }),
  },
  {
    name: '同一ファイル内でブロック id が重複する',
    expect: '__ブロックidが重複している',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `${theorem({ id: 'dup' })}\n${theorem({ id: broken ? 'dup' : 'other' })}`,
      ),
    }),
  },
  {
    name: '同一ファイル内でラベルが重複する',
    expect: '__ラベルが重複している',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `${theorem({ id: 'l1', labels: ['lab:a'] })}\n${theorem({
          id: 'l2',
          labels: [broken ? 'lab:a' : 'lab:b'],
        })}`,
      ),
    }),
  },
  {
    name: 'ファイルを跨いでブロック id が重複する（集約モジュールでのみ判定できる）',
    expect: 'does not satisfy the constraint',
    files: (broken) => ({
      'a.ts': blocksModule(theorem({ id: 'cross_a', labels: ['lab:a'] })),
      'b.ts': blocksModule(theorem({ id: broken ? 'cross_a' : 'cross_b', labels: ['lab:b'] })),
      'c.ts': notesModule(`  { id: 'cross_note', targets: ['lab:a'], body: [] },`),
      'aggregate.ts': aggregatorModule(),
    }),
  },
  {
    name: 'ノート id がブロック id と衝突する（集約モジュールでのみ判定できる）',
    expect: 'does not satisfy the constraint',
    files: (broken) => ({
      'a.ts': blocksModule(theorem({ id: 'collide', labels: ['lab:a'] })),
      'b.ts': blocksModule(theorem({ id: 'other', labels: ['lab:b'] })),
      'c.ts': notesModule(
        `  { id: '${broken ? 'collide' : 'note_ok'}', targets: ['lab:a'], body: [] },`,
      ),
      'aggregate.ts': aggregatorModule(),
    }),
  },
  {
    name: '見出しが本文を持つ',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `  {
    id: 'heading_case',
    kind: 'heading',
    level: 1,
    labels: [],
    title: { text: '章' },${broken ? "\n    statement: [paragraph(['本文'])]," : ''}
  },`,
      ),
    }),
  },
  {
    name: '定理型が見出し専用の level を持つ',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        theorem({ id: 'level_case', extra: broken ? '\n    level: 1,' : '' }),
      ),
    }),
  },
  {
    name: '見出しの level が範囲外',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `  {
    id: 'level_range',
    kind: 'heading',
    level: ${broken ? 7 : 6},
    labels: [],
    title: { text: '章' },
  },`,
      ),
    }),
  },
  {
    name: 'タイトルが text も tex も持たない',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `  {
    id: 'title_case',
    kind: 'heading',
    level: 1,
    labels: [],
    title: ${broken ? '{}' : "{ text: '章' }"},
  },`,
      ),
    }),
  },
  {
    name: 'フィールド名の打ち間違い（proof → proofs）',
    expect: 'proof',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        theorem({
          id: 'typo_case',
          extra: broken ? '\n    proofs: [],' : '\n    proof: [],',
        }),
      ),
    }),
  },
  {
    name: '本文ブロックが notes を持つ（ノートの混入経路）',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        theorem({ id: 'notes_case', extra: broken ? '\n    notes: [],' : '' }),
      ),
    }),
  },
  {
    name: 'プロジェクト固有メタデータの条件違反（非可算なのに脱出箇所が無い）',
    expect: 'realEscape',
    files: (broken) => ({
      'fixture.ts': `import { ${'defineBlocks'} } from './schema.ts'

export default defineBlocks([
  {
    id: 'meta_case',
    kind: 'claim',
    labels: [],
    habitat: 'uncountable',${broken ? '' : "\n    realEscape: '極限を取る箇所',"}
    statement: [],
  },
])
`,
    }),
  },
  {
    name: '図表ブロックが定理型のフィールドを持つ',
    expect: 'TS2322',
    files: (broken) => ({
      'fixture.ts': blocksModule(
        `  {
    id: 'figure_case',
    kind: 'figure',
    labels: [],
    content: [],${broken ? '\n    statement: [],' : ''}
  },`,
      ),
    }),
  },
]

const runTsc = (caseDir: string): { ok: boolean; output: string } => {
  try {
    execFileSync(tsc, ['-p', join(caseDir, 'tsconfig.json'), '--noEmit'], { encoding: 'utf8' })
    return { ok: true, output: '' }
  } catch (error) {
    const shell = error as { stdout?: string; stderr?: string }
    return { ok: false, output: `${shell.stdout ?? ''}${shell.stderr ?? ''}` }
  }
}

rmSync(tmpDir, { recursive: true, force: true })

let failures = 0
cases.forEach((testCase, index) => {
  for (const broken of [false, true]) {
    const caseDir = join(tmpDir, `case-${index}-${broken ? 'broken' : 'valid'}`)
    mkdirSync(caseDir, { recursive: true })
    const files = { ...commonFiles, ...testCase.files(broken) }
    for (const [name, content] of Object.entries(files)) {
      writeFileSync(join(caseDir, name), content, 'utf8')
    }
    const result = runTsc(caseDir)
    if (!broken && !result.ok) {
      failures += 1
      console.error(`✗ ${testCase.name}（正しい版が落ちた）\n${result.output}`)
    }
    if (broken && result.ok) {
      failures += 1
      console.error(`✗ ${testCase.name}（壊した版が型検査を通ってしまった）`)
    }
    if (broken && !result.ok && !result.output.includes(testCase.expect)) {
      failures += 1
      console.error(
        `✗ ${testCase.name}（落ちたが診断に "${testCase.expect}" が無い）\n${result.output}`,
      )
    }
  }
})

if (failures > 0) {
  console.error(`\n負テスト: ${failures} 件が期待どおりでない`)
  process.exit(1)
}
rmSync(tmpDir, { recursive: true, force: true })
console.log(`負テスト: ${cases.length} ケース × (正/誤) すべて期待どおり`)
