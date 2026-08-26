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
import blocks_composed_neighborhood_closure from './content/composed-neighborhood-closure.ts'
import blocks_composite_map_essential_dependency from './content/composite-map-essential-dependency.ts'
import blocks_conjugacy_class_code_image_bijection from './content/conjugacy-class-code-image-bijection.ts'
import blocks_dependency_order_substructures from './content/dependency-order-substructures.ts'
import blocks_essential_dependency from './content/essential-dependency.ts'
import blocks_finite_neighborhood_assignment_monoid from './content/finite-neighborhood-assignment-monoid.ts'
import blocks_finite_propagation_boundary from './content/finite-propagation-boundary.ts'
import blocks_global_map_iteration from './content/global-map-iteration.ts'
import blocks_inverse_map_locality from './content/inverse-map-locality.ts'
import blocks_iterate_monoid_conjugacy_invariance from './content/iterate-monoid-conjugacy-invariance.ts'
import blocks_iterate_monoid_conjugacy_numerical_profile from './content/iterate-monoid-conjugacy-numerical-profile.ts'
import blocks_iterate_monoid_cycle_idempotent from './content/iterate-monoid-cycle-idempotent.ts'
import blocks_iterate_monoid_cyclic_group from './content/iterate-monoid-cyclic-group.ts'
import blocks_iterate_monoid_idempotents from './content/iterate-monoid-idempotents.ts'
import blocks_iterate_monoid_minimal_period from './content/iterate-monoid-minimal-period.ts'
import blocks_iterate_monoid_principal_ideal_tail from './content/iterate-monoid-principal-ideal-tail.ts'
import blocks_iterate_monoid_root_depth_preperiod_correspondence from './content/iterate-monoid-root-depth-preperiod-correspondence.ts'
import blocks_iterate_monoid_stabilization_index from './content/iterate-monoid-stabilization-index.ts'
import blocks_iterate_monoid_stable_fiber_depth from './content/iterate-monoid-stable-fiber-depth.ts'
import blocks_iterate_monoid_stable_fiber_dynamics from './content/iterate-monoid-stable-fiber-dynamics.ts'
import blocks_iterate_monoid_stable_fiber_layer_branching from './content/iterate-monoid-stable-fiber-layer-branching.ts'
import blocks_iterate_monoid_stable_fiber_layer_preimage from './content/iterate-monoid-stable-fiber-layer-preimage.ts'
import blocks_iterate_monoid_stable_fiber_predecessor_count from './content/iterate-monoid-stable-fiber-predecessor-count.ts'
import blocks_iterate_monoid_stable_fiber_rooted_tree from './content/iterate-monoid-stable-fiber-rooted-tree.ts'
import blocks_iterate_monoid_stable_image from './content/iterate-monoid-stable-image.ts'
import blocks_iterate_monoid_stable_partition from './content/iterate-monoid-stable-partition.ts'
import blocks_iterate_monoid_tail_cycle_decomposition from './content/iterate-monoid-tail-cycle-decomposition.ts'
import blocks_iterate_monoid_tail_equivalence from './content/iterate-monoid-tail-equivalence.ts'
import blocks_iterate_monoid from './content/iterate-monoid.ts'
import blocks_local_rule_representation from './content/local-rule-representation.ts'
import blocks_locality_restricts_cycle_type from './content/locality-restricts-cycle-type.ts'
import blocks_minimal_preperiod_period from './content/minimal-preperiod-period.ts'
import blocks_neighborhood_assignment_intersection_minimal_counterexample from './content/neighborhood-assignment-intersection-minimal-counterexample.ts'
import blocks_neighborhood_assignment_intersection_nondistributivity from './content/neighborhood-assignment-intersection-nondistributivity.ts'
import blocks_neighborhood_assignment_transpose_involution from './content/neighborhood-assignment-transpose-involution.ts'
import blocks_neighborhood_assignment_union_distributivity from './content/neighborhood-assignment-union-distributivity.ts'
import blocks_ordered_neighborhood_assignment_monoid from './content/ordered-neighborhood-assignment-monoid.ts'
import blocks_periodic_point_count from './content/periodic-point-count.ts'
import blocks_recursive_preimage_tree_code from './content/recursive-preimage-tree-code.ts'
import blocks_redundant_neighbor from './content/redundant-neighbor.ts'
import blocks_reversibility_finite_decidability from './content/reversibility-finite-decidability.ts'
import blocks_reversible_global_map_cycle_type from './content/reversible-global-map-cycle-type.ts'
import blocks_self_neighborhood_reversible_map_group from './content/self-neighborhood-reversible-map-group.ts'
import blocks_self_transpose_neighborhood_assignment_count from './content/self-transpose-neighborhood-assignment-count.ts'
import blocks_stage_reversible_composition_nonclosure from './content/stage-reversible-composition-nonclosure.ts'
import blocks_time_expansion_dependency from './content/time-expansion-dependency.ts'
import blocks_transitive_closure_antisymmetry from './content/transitive-closure-antisymmetry.ts'



/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
  ...typeof blocks_causal_set_primary_literature,
  ...typeof blocks_causal_structure_comparison,
  ...typeof blocks_composed_neighborhood_closure,
  ...typeof blocks_composite_map_essential_dependency,
  ...typeof blocks_conjugacy_class_code_image_bijection,
  ...typeof blocks_dependency_order_substructures,
  ...typeof blocks_essential_dependency,
  ...typeof blocks_finite_neighborhood_assignment_monoid,
  ...typeof blocks_finite_propagation_boundary,
  ...typeof blocks_global_map_iteration,
  ...typeof blocks_inverse_map_locality,
  ...typeof blocks_iterate_monoid_conjugacy_invariance,
  ...typeof blocks_iterate_monoid_conjugacy_numerical_profile,
  ...typeof blocks_iterate_monoid_cycle_idempotent,
  ...typeof blocks_iterate_monoid_cyclic_group,
  ...typeof blocks_iterate_monoid_idempotents,
  ...typeof blocks_iterate_monoid_minimal_period,
  ...typeof blocks_iterate_monoid_principal_ideal_tail,
  ...typeof blocks_iterate_monoid_root_depth_preperiod_correspondence,
  ...typeof blocks_iterate_monoid_stabilization_index,
  ...typeof blocks_iterate_monoid_stable_fiber_depth,
  ...typeof blocks_iterate_monoid_stable_fiber_dynamics,
  ...typeof blocks_iterate_monoid_stable_fiber_layer_branching,
  ...typeof blocks_iterate_monoid_stable_fiber_layer_preimage,
  ...typeof blocks_iterate_monoid_stable_fiber_predecessor_count,
  ...typeof blocks_iterate_monoid_stable_fiber_rooted_tree,
  ...typeof blocks_iterate_monoid_stable_image,
  ...typeof blocks_iterate_monoid_stable_partition,
  ...typeof blocks_iterate_monoid_tail_cycle_decomposition,
  ...typeof blocks_iterate_monoid_tail_equivalence,
  ...typeof blocks_iterate_monoid,
  ...typeof blocks_local_rule_representation,
  ...typeof blocks_locality_restricts_cycle_type,
  ...typeof blocks_minimal_preperiod_period,
  ...typeof blocks_neighborhood_assignment_intersection_minimal_counterexample,
  ...typeof blocks_neighborhood_assignment_intersection_nondistributivity,
  ...typeof blocks_neighborhood_assignment_transpose_involution,
  ...typeof blocks_neighborhood_assignment_union_distributivity,
  ...typeof blocks_ordered_neighborhood_assignment_monoid,
  ...typeof blocks_periodic_point_count,
  ...typeof blocks_recursive_preimage_tree_code,
  ...typeof blocks_redundant_neighbor,
  ...typeof blocks_reversibility_finite_decidability,
  ...typeof blocks_reversible_global_map_cycle_type,
  ...typeof blocks_self_neighborhood_reversible_map_group,
  ...typeof blocks_self_transpose_neighborhood_assignment_count,
  ...typeof blocks_stage_reversible_composition_nonclosure,
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
