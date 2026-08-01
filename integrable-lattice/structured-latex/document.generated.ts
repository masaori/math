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
import blocks_001_intro from './content/001_intro.ts'
import blocks_002_setup from './content/002_setup.ts'
import blocks_003_archimedean from './content/003_archimedean.ts'
import blocks_004_lambda_finite from './content/004_lambda_finite.ts'
import blocks_005_duality from './content/005_duality.ts'
import blocks_005b_theta_infinity from './content/005b_theta_infinity.ts'
import blocks_005c_ell2_family from './content/005c_ell2_family.ts'
import blocks_006_propositions_TVW from './content/006_propositions_TVW.ts'
import blocks_007_asymmetry_scope from './content/007_asymmetry_scope.ts'
import blocks_008_theta_padic from './content/008_theta_padic.ts'
import blocks_009_s_infinity_decision from './content/009_s_infinity_decision.ts'
import blocks_009_theta_recursion from './content/009_theta_recursion.ts'
import blocks_010_general_closed_form from './content/010_general_closed_form.ts'

import blocks_en_001_intro from './locales/en/content/001_intro.ts'
import blocks_en_001a_reader_guide from './locales/en/content/001a_reader_guide.ts'
import blocks_en_002_setup from './locales/en/content/002_setup.ts'
import blocks_en_003_archimedean from './locales/en/content/003_archimedean.ts'
import blocks_en_004_lambda_finite from './locales/en/content/004_lambda_finite.ts'
import blocks_en_005_duality from './locales/en/content/005_duality.ts'
import blocks_en_005b_theta_infinity from './locales/en/content/005b_theta_infinity.ts'
import blocks_en_005c_ell2_family from './locales/en/content/005c_ell2_family.ts'
import blocks_en_006_propositions_TVW from './locales/en/content/006_propositions_TVW.ts'
import blocks_en_007_asymmetry_scope from './locales/en/content/007_asymmetry_scope.ts'
import blocks_en_008_theta_padic from './locales/en/content/008_theta_padic.ts'
import blocks_en_009_s_infinity_decision from './locales/en/content/009_s_infinity_decision.ts'
import blocks_en_009_theta_recursion from './locales/en/content/009_theta_recursion.ts'
import blocks_en_010_general_closed_form from './locales/en/content/010_general_closed_form.ts'
import blocks_en_010_prior_art from './locales/en/content/010_prior_art.ts'

/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_001_intro,
  ...typeof blocks_002_setup,
  ...typeof blocks_003_archimedean,
  ...typeof blocks_004_lambda_finite,
  ...typeof blocks_005_duality,
  ...typeof blocks_005b_theta_infinity,
  ...typeof blocks_005c_ell2_family,
  ...typeof blocks_006_propositions_TVW,
  ...typeof blocks_007_asymmetry_scope,
  ...typeof blocks_008_theta_padic,
  ...typeof blocks_009_s_infinity_decision,
  ...typeof blocks_009_theta_recursion,
  ...typeof blocks_010_general_closed_form,
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

/** 翻訳ロケール en の全ブロック（文書順）。 */
export type AllBlocks_en = [
  ...typeof blocks_en_001_intro,
  ...typeof blocks_en_001a_reader_guide,
  ...typeof blocks_en_002_setup,
  ...typeof blocks_en_003_archimedean,
  ...typeof blocks_en_004_lambda_finite,
  ...typeof blocks_en_005_duality,
  ...typeof blocks_en_005b_theta_infinity,
  ...typeof blocks_en_005c_ell2_family,
  ...typeof blocks_en_006_propositions_TVW,
  ...typeof blocks_en_007_asymmetry_scope,
  ...typeof blocks_en_008_theta_padic,
  ...typeof blocks_en_009_s_infinity_decision,
  ...typeof blocks_en_009_theta_recursion,
  ...typeof blocks_en_010_general_closed_form,
  ...typeof blocks_en_010_prior_art,
]

export type _TranslationBlocksAreBlocks_en = Assert<
  AllBlocks_en extends readonly Block<AnyLocaleLabel>[] ? true : never
>
export type _TranslationIsNotEmpty_en = Assert<AllBlocks_en extends readonly [] ? never : true>
export type _UniqueTranslationBlockIds_en = AssertNoDuplicate<
  FindDuplicate<BlockIdsOf<AllBlocks_en>>
>
export type _UniqueTranslationLabels_en = AssertNoDuplicate<
  FindDuplicate<LabelsOf<AllBlocks_en>>
>
/** 翻訳ロケールが実際に持つラベルの全体。 */
type AllTranslationLabels = LabelsOf<AllBlocks_en>[number]

/** 生成した TranslationOnlyLabel と、翻訳ロケールの実状が一致すること（両方向）。 */
export type _NoStaleTranslationOnlyLabel = AssertNoDuplicate<
  Exclude<TranslationOnlyLabel, AllTranslationLabels>
>
export type _NoMissingTranslationOnlyLabel = AssertNoDuplicate<
  Exclude<AllTranslationLabels, AnyLocaleLabel>
>
