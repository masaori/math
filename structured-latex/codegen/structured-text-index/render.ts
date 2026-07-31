/**
 * 生成物のレンダリング（純関数。決定性・冪等性を持つ）。
 *
 * 生成するのは 2 つ:
 *   1. `labels.generated.ts`   … 実在するラベルのユニオン型 `Label`
 *   2. `document.generated.ts` … 全ファイルを 1 本のタプル型へ連結し、
 *                                **ファイルを跨いだ一意性**をコンパイル時に主張するモジュール
 *
 * なぜ 2 が要るか: 1 ファイル内の重複は `defineBlocks` の型引数で落とせるが、
 * **ファイルを跨いだ重複**は、その 2 ファイルを同時に見る場所が無いと型で判定できない。
 * 全ファイルを import して連結する生成モジュールが、その「同時に見る場所」になる。
 */

const identifierFor = (prefix: string, fileName: string): string =>
  `${prefix}_${fileName.replace(/\.ts$/, '').replace(/[^A-Za-z0-9_]/g, '_')}`

export const renderLabels = (sortedLabels: readonly string[]): string => {
  const body = sortedLabels.map((label) => `  ${JSON.stringify(label)},`).join('\n')
  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
${body}
] as const

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number]
`
}

export const renderDocument = (options: {
  /** このファイルから見た domain-model の import 指定子（例: `../../domain-model/index.ts`）。 */
  domainModelSpecifier: string
  contentFiles: readonly string[]
  noteFiles: readonly string[]
}): string => {
  const contentImports = options.contentFiles
    .map((file) => `import ${identifierFor('blocks', file)} from './content/${file}'`)
    .join('\n')
  const noteImports = options.noteFiles
    .map((file) => `import ${identifierFor('notes', file)} from './notes/${file}'`)
    .join('\n')
  const contentSpread = options.contentFiles
    .map((file) => `  ...typeof ${identifierFor('blocks', file)},`)
    .join('\n')
  const noteSpread = options.noteFiles
    .map((file) => `  ...typeof ${identifierFor('notes', file)},`)
    .join('\n')

  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ notes/ のファイル一覧
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// 文書全体を 1 本のタプル型へ連結し、**ファイルを跨いだ一意性**をコンパイル時に主張する。
// 1 ファイル内の重複は defineBlocks / defineNotes の型引数が落とすが、ファイル間の重複は
// 両方を同時に見るこのモジュールでしか判定できない。実行時には誰も import しない
// （型検査の対象に入れるためだけに存在する）。

import type {
  Assert,
  AssertNoDuplicate,
  Block,
  BlockIdsOf,
  FindDuplicate,
  LabelsOf,
  Note,
  NoteIdsOf,
} from '${options.domainModelSpecifier}'
import type { Label } from './labels.generated.ts'
${contentImports}
${noteImports}

/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = ${contentSpread === '' ? '[]' : `[\n${contentSpread}\n]`}

/** 全ノート。 */
export type AllNotes = ${noteSpread === '' ? '[]' : `[\n${noteSpread}\n]`}

type AllBlockIds = BlockIdsOf<AllBlocks>
type AllNoteIds = NoteIdsOf<AllNotes>
type AllLabels = LabelsOf<AllBlocks>

/**
 * 型が壊れていないことの確認（ここが落ちたら生成物かスキーマの不整合）。
 * Assert<T extends true> の制約で包む。制約なしの "A extends B ? true : never" だと
 * 条件が偽でも「never という別名が定義されるだけ」でエラーにならない。
 */
export type _BlocksAreBlocks = Assert<AllBlocks extends readonly Block<Label>[] ? true : never>
export type _NotesAreNotes = Assert<AllNotes extends readonly Note<Label>[] ? true : never>

/** content が空でないこと（I3。空なら「0 件で検証通過」という無意味な状態になる）。 */
export type _ContentIsNotEmpty = Assert<AllBlocks extends readonly [] ? never : true>

/** ブロック id・ノート id・ラベルは文書全体で一意（I1）。重複するとその値が型エラーに出る。 */
export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<AllLabels>>

/** ノート id はブロック id とも衝突しない（アンカーが一意に決まらなくなるため）。 */
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>

/** labels.generated.ts と content の実状が一致すること（両方向）。 */
export type _NoStaleGeneratedLabel = AssertNoDuplicate<Exclude<Label, AllLabels[number]>>
export type _NoMissingGeneratedLabel = AssertNoDuplicate<Exclude<AllLabels[number], Label>>
`
}
