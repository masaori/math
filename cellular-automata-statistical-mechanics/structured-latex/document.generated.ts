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
import blocks_causal_set_primary_literature from './content/causal-set-primary-literature.ts'
import blocks_causal_structure_comparison from './content/causal-structure-comparison.ts'
import blocks_dependency_order_substructures from './content/dependency-order-substructures.ts'
import blocks_essential_dependency from './content/essential-dependency.ts'
import blocks_finite_propagation_boundary from './content/finite-propagation-boundary.ts'
import blocks_redundant_neighbor from './content/redundant-neighbor.ts'
import blocks_time_expansion_dependency from './content/time-expansion-dependency.ts'
import blocks_transitive_closure_antisymmetry from './content/transitive-closure-antisymmetry.ts'



/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_causal_set_primary_literature,
  ...typeof blocks_causal_structure_comparison,
  ...typeof blocks_dependency_order_substructures,
  ...typeof blocks_essential_dependency,
  ...typeof blocks_finite_propagation_boundary,
  ...typeof blocks_redundant_neighbor,
  ...typeof blocks_time_expansion_dependency,
  ...typeof blocks_transitive_closure_antisymmetry,
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
