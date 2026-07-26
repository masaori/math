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
import blocks_000_calculation_formulae_00_09 from "./content/000_calculation_formulae_00_09.ts";
import blocks_000_calculation_formulae_10_19 from "./content/000_calculation_formulae_10_19.ts";
import blocks_000_calculation_formulae_20_29 from "./content/000_calculation_formulae_20_29.ts";
import blocks_000_calculation_formulae_30_44 from "./content/000_calculation_formulae_30_44.ts";
import blocks_000_calculation_formulae_45_46 from "./content/000_calculation_formulae_45_46.ts";
import blocks_001_partition_function_2d_ising from "./content/001_partition_function_2d_ising.ts";
import blocks_002_linear_space_general from "./content/002_linear_space_general.ts";
import blocks_003_exp_linear_map from "./content/003_exp_linear_map.ts";
import blocks_004_transfer_matrix from "./content/004_transfer_matrix.ts";
import blocks_005_exp_conjugation_proof from "./content/005_exp_conjugation_proof.ts";
import blocks_006_Z_Y_anticommutation from "./content/006_Z_Y_anticommutation.ts";
import blocks_007_hatZ_hatY_anticommutation from "./content/007_hatZ_hatY_anticommutation.ts";
import blocks_008_TV1_hatZ_hatY_part1 from "./content/008_TV1_hatZ_hatY_part1.ts";
import blocks_008_TV1_hatZ_hatY_part2 from "./content/008_TV1_hatZ_hatY_part2.ts";
import blocks_009_eigenvalues_of_V from "./content/009_eigenvalues_of_V.ts";
import blocks_010_transfer_matrix_bridge from "./content/010_transfer_matrix_bridge.ts";
import blocks_011_max_eigenvalue from "./content/011_max_eigenvalue.ts";
import blocks_012_free_energy from "./content/012_free_energy.ts";
import blocks_013_even_sector_modes from "./content/013_even_sector_modes.ts";
import blocks_014_even_sector_T_action from "./content/014_even_sector_T_action.ts";
import blocks_015_A_theta_tilde_diagonalization from "./content/015_A_theta_tilde_diagonalization.ts";
import blocks_016_even_sector_fermions from "./content/016_even_sector_fermions.ts";
import blocks_017_even_sector_eigenvalues from "./content/017_even_sector_eigenvalues.ts";
import notes_000_calculation_formulae from "./notes/000_calculation_formulae.ts";
import notes_001_partition_function_2d_ising from "./notes/001_partition_function_2d_ising.ts";
import notes_002_linear_space_general from "./notes/002_linear_space_general.ts";
import notes_003_exp_abstract_normed_space from "./notes/003_exp_abstract_normed_space.ts";
import notes_005_exp_conjugation_lie_route from "./notes/005_exp_conjugation_lie_route.ts";
import notes_008_TV1_hatZ_hatY from "./notes/008_TV1_hatZ_hatY.ts";
import notes_008_group_theory_general from "./notes/008_group_theory_general.ts";
import notes_009_clifford_algebra from "./notes/009_clifford_algebra.ts";

/** 文書順（ファイル名昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_000_calculation_formulae_00_09,
  ...typeof blocks_000_calculation_formulae_10_19,
  ...typeof blocks_000_calculation_formulae_20_29,
  ...typeof blocks_000_calculation_formulae_30_44,
  ...typeof blocks_000_calculation_formulae_45_46,
  ...typeof blocks_001_partition_function_2d_ising,
  ...typeof blocks_002_linear_space_general,
  ...typeof blocks_003_exp_linear_map,
  ...typeof blocks_004_transfer_matrix,
  ...typeof blocks_005_exp_conjugation_proof,
  ...typeof blocks_006_Z_Y_anticommutation,
  ...typeof blocks_007_hatZ_hatY_anticommutation,
  ...typeof blocks_008_TV1_hatZ_hatY_part1,
  ...typeof blocks_008_TV1_hatZ_hatY_part2,
  ...typeof blocks_009_eigenvalues_of_V,
  ...typeof blocks_010_transfer_matrix_bridge,
  ...typeof blocks_011_max_eigenvalue,
  ...typeof blocks_012_free_energy,
  ...typeof blocks_013_even_sector_modes,
  ...typeof blocks_014_even_sector_T_action,
  ...typeof blocks_015_A_theta_tilde_diagonalization,
  ...typeof blocks_016_even_sector_fermions,
  ...typeof blocks_017_even_sector_eigenvalues,
];

/** 全ノート。 */
export type AllNotes = [
  ...typeof notes_000_calculation_formulae,
  ...typeof notes_001_partition_function_2d_ising,
  ...typeof notes_002_linear_space_general,
  ...typeof notes_003_exp_abstract_normed_space,
  ...typeof notes_005_exp_conjugation_lie_route,
  ...typeof notes_008_TV1_hatZ_hatY,
  ...typeof notes_008_group_theory_general,
  ...typeof notes_009_clifford_algebra,
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
