// 自動生成ファイル — 直接編集しない。
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
} from '../../structured-latex/domain-model/index.ts'
import type { AnyLocaleLabel, Label, TranslationOnlyLabel } from './labels.generated.ts'
import blocks_about_article_scope from './content/about-article-scope.ts'
import blocks_arithmetic_invariants from './content/arithmetic-invariants.ts'
import blocks_arithmetic_tools from './content/arithmetic-tools.ts'
import blocks_finite_cellulation from './content/finite-cellulation.ts'
import blocks_finite_fourier_duality from './content/finite-fourier-duality.ts'
import blocks_finite_quotient_lattice from './content/finite-quotient-lattice.ts'
import blocks_homology_sector_expansion from './content/homology-sector-expansion.ts'
import blocks_main_text from './content/main-text.ts'
import blocks_publication_structure from './content/publication-structure.ts'
import blocks_quotient_tower from './content/quotient-tower.ts'



/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_about_article_scope,
  ...typeof blocks_arithmetic_invariants,
  ...typeof blocks_arithmetic_tools,
  ...typeof blocks_finite_cellulation,
  ...typeof blocks_finite_fourier_duality,
  ...typeof blocks_finite_quotient_lattice,
  ...typeof blocks_homology_sector_expansion,
  ...typeof blocks_main_text,
  ...typeof blocks_publication_structure,
  ...typeof blocks_quotient_tower,
]

/** 全ノート。 */
export type AllNotes = []

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

/** 翻訳ロケール用のラベル型は原文のラベルを必ず含む。 */
export type _AnyLocaleLabelIncludesLabel = Assert<Label extends AnyLocaleLabel ? true : never>

/** 翻訳限定のラベルは原文のラベルと交わらない（交わればどちらの版のものか決まらない）。 */
export type _TranslationOnlyLabelIsDisjoint = AssertNoDuplicate<Extract<TranslationOnlyLabel, Label>>
