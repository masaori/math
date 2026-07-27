// 自動生成ファイル — 直接編集しない。
// 生成元: content/ notes/ のファイル一覧（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
//
// 文書全体を 1 本のタプル型へ連結し、**ファイルを跨いだ一意性**をコンパイル時に主張する。
// 1 ファイル内の重複は defineBlocks / defineNotes の型引数が落とすが、ファイル間の重複は
// 両方を同時に見るこのモジュールでしか判定できない。実行時には誰も import しない
// （tsc の検査対象に入れるためだけに存在する）。

import type { Label } from "./labels.generated.ts";
import type {
  Assert,
  AssertNoDuplicate,
  BlockIdsOf,
  ConvertedBlock,
  FindDuplicate,
  LabelsOf,
  Note,
  NoteIdsOf,
} from "./schema.ts";
import blocks_001_setup from "./content/001_setup.ts";
import blocks_002_lambda_side_finite from "./content/002_lambda_side_finite.ts";
import blocks_003_towers_and_graphs from "./content/003_towers_and_graphs.ts";
import notes_001_pending_judgment from "./notes/001_pending_judgment.ts";

/** 文書順（ファイル名昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_001_setup,
  ...typeof blocks_002_lambda_side_finite,
  ...typeof blocks_003_towers_and_graphs,
];

/** 全ノート。 */
export type AllNotes = [
  ...typeof notes_001_pending_judgment,
];

type AllBlockIds = BlockIdsOf<AllBlocks>;
type AllNoteIds = NoteIdsOf<AllNotes>;
type AllLabels = LabelsOf<AllBlocks>;

/**
 * 型が壊れていないことの確認（ここが落ちたら生成物か schema の不整合）。
 * Assert<T extends true> の制約で包む。制約なしの "A extends B ? true : never" だと
 * 条件が偽でも「never という別名が定義されるだけ」でエラーにならない（実測）。
 */
export type _BlocksAreBlocks = Assert<AllBlocks extends readonly ConvertedBlock[] ? true : never>;
export type _NotesAreNotes = Assert<AllNotes extends readonly Note[] ? true : never>;

/** content が空でないこと（空なら「ブロック 0 件で検証通過」という無意味な状態になる）。 */
export type _ContentIsNotEmpty = Assert<AllBlocks extends readonly [] ? never : true>;

/** ブロック id・ノート id・ラベルは文書全体で一意。重複するとその値が型エラーに出る。 */
export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>;
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>;
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<AllLabels>>;

/** ノート id はブロック id とも衝突しない（アンカーが一意に決まらなくなるため）。 */
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>;

/** labels.generated.ts と content の実状が一致すること（両方向）。 */
export type _NoStaleGeneratedLabel = AssertNoDuplicate<Exclude<Label, AllLabels[number]>>;
export type _NoMissingGeneratedLabel = AssertNoDuplicate<Exclude<AllLabels[number], Label>>;
