#!/usr/bin/env bash
# 本プロジェクトの形式化した定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd cellular-automata-statistical-mechanics/lean && bash scripts/check-no-sorry.sh
#
# 終了コード 0 = すべて sorry 非依存。1 = sorryAx への依存、ソース中の sorry、
# または入口から import されていない .lean を検出。
set -euo pipefail

cd "$(dirname "$0")/.."

# lake は elan 経由で入るため、非対話シェルの PATH に無いことがある。
if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

status=0

# 0. どの .lean も入口から import されていること。
#    **import されていないファイルはビルドも検査もされない。**
orphans=""
if [ -d CellularAutomata ]; then
  while IFS= read -r file; do
    module="$(printf '%s' "$file" | sed 's#/#.#g; s#\.lean$##')"
    grep -q "^import ${module}$" CellularAutomata.lean || orphans="${orphans}  ${file}
"
  done < <(find CellularAutomata -name '*.lean' | sort)
fi

if [ -n "$orphans" ]; then
  echo "NG: 入口 CellularAutomata.lean から import されていない .lean がある（ビルドも検査もされない）:" >&2
  printf '%s' "$orphans" >&2
  status=1
else
  echo "OK: すべての .lean が入口から import されている"
fi

# 1. ソース中に sorry / admit が残っていないか
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' CellularAutomata.lean CellularAutomata 2>/dev/null; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 形式化した定理の依存公理に sorryAx が含まれていないか。
#    **形式化した定理を増やしたら、必ずこの配列へ追加する（追加漏れは検査の穴になる）。**
targets=(
  CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_order_convex
  CellularAutomata.NecSuf.DependencyOrderSubstructures.up_set_order_convex
  CellularAutomata.NecSuf.DependencyOrderSubstructures.order_convex_intersection
  CellularAutomata.NecSuf.DependencyOrderSubstructures.incomparable_symm
  CellularAutomata.NecSuf.DependencyOrderSubstructures.antichain_order_convex
  CellularAutomata.NecSuf.DependencyOrderSubstructures.time_slice_antichain
  CellularAutomata.NecSuf.DependencyOrderSubstructures.oneStepBoundary_finite
  CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_no_incoming_edge
  CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_boundary_outgoing
  CellularAutomata.DependencyOrderSubstructures.down_set_order_convex
  CellularAutomata.DependencyOrderSubstructures.up_set_order_convex
  CellularAutomata.DependencyOrderSubstructures.order_convex_intersection
  CellularAutomata.DependencyOrderSubstructures.incomparable_symm
  CellularAutomata.DependencyOrderSubstructures.antichain_order_convex
  CellularAutomata.DependencyOrderSubstructures.time_slice_antichain
  CellularAutomata.DependencyOrderSubstructures.oneStepBoundary_finite
  CellularAutomata.DependencyOrderSubstructures.down_set_no_incoming_edge
  CellularAutomata.DependencyOrderSubstructures.down_set_boundary_outgoing
  CellularAutomata.DependencyOrderSubstructures.down_set_order_convex_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.up_set_order_convex_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.order_convex_intersection_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.incomparable_symm_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.antichain_order_convex_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.time_slice_antichain_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.oneStepBoundary_finite_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.down_set_no_incoming_edge_from_necessary_sufficient
  CellularAutomata.DependencyOrderSubstructures.down_set_boundary_outgoing_from_necessary_sufficient
  CellularAutomata.EssentialDependency.ne_iff_eq_nu
  CellularAutomata.EssentialDependency.essentialDep_iff_flip
  CellularAutomata.EssentialDependency.mem_supp_iff
  CellularAutomata.EssentialDependency.card_scan_pairs
  CellularAutomata.EssentialDependency.essentialDep_iff_flip_from_necessary_sufficient
  CellularAutomata.EssentialDependency.card_scan_pairs_from_necessary_sufficient
  CellularAutomata.NecSuf.EssentialDependency.essentialDep_iff_flip
  CellularAutomata.NecSuf.EssentialDependency.card_scan_pairs
  CellularAutomata.RedundantNeighbor.restrict_baseExtend
  CellularAutomata.RedundantNeighbor.no_essentialDep_on_added_element
  CellularAutomata.RedundantNeighbor.essentialDep_transfer
  CellularAutomata.RedundantNeighbor.supp_extendRule
  CellularAutomata.RedundantNeighbor.restrict_baseExtend_from_necessary_sufficient
  CellularAutomata.RedundantNeighbor.no_essentialDep_on_added_element_from_necessary_sufficient
  CellularAutomata.RedundantNeighbor.essentialDep_transfer_from_necessary_sufficient
  CellularAutomata.RedundantNeighbor.supp_extendRule_from_necessary_sufficient
  CellularAutomata.NecSuf.RedundantNeighbor.restrict_baseExtend
  CellularAutomata.NecSuf.RedundantNeighbor.no_essentialDep_on_added_element
  CellularAutomata.NecSuf.RedundantNeighbor.essentialDep_transfer
  CellularAutomata.NecSuf.RedundantNeighbor.essentialDep_extendRule_iff
  CellularAutomata.NecSuf.TimeExpansionDependency.globalMap_eq_extendRule
  CellularAutomata.NecSuf.TimeExpansionDependency.globalFlip_iff_essentialDep
  CellularAutomata.NecSuf.TimeExpansionDependency.card_eventSet
  CellularAutomata.NecSuf.TimeExpansionDependency.directDep_imp_mem_neighborhood
  CellularAutomata.NecSuf.TimeExpansionDependency.time_strictly_increases
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.path_time_strictly_increases
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reachable_subset_product
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reachable_finite
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.oneStep_subset_reachable
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reachable_transitive
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reachable_minimal
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.no_mutual_reachability
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reachable_irreflexive
  CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.reflReachable_partial_order
  CellularAutomata.NecSuf.FinitePropagationBoundary.path_time_increment_exact
  CellularAutomata.NecSuf.FinitePropagationBoundary.propagationBall_one
  CellularAutomata.NecSuf.FinitePropagationBoundary.propagationBall_succ
  CellularAutomata.NecSuf.FinitePropagationBoundary.card_propagationBall_one
  CellularAutomata.NecSuf.FinitePropagationBoundary.card_propagationBall_succ_le
  CellularAutomata.NecSuf.FinitePropagationBoundary.start_cell_in_propagationBall
  CellularAutomata.NecSuf.FinitePropagationBoundary.dependencySourceSet_finite
  CellularAutomata.NecSuf.FinitePropagationBoundary.dependencySourceSet_subset_boundary
  CellularAutomata.NecSuf.FinitePropagationBoundary.card_dependencySourceSet_le
  CellularAutomata.NecSuf.FinitePropagationBoundary.dependencySourceSet_zero_empty
  CellularAutomata.TimeExpansionDependency.globalMap_eq_extendRule
  CellularAutomata.TimeExpansionDependency.globalFlip_iff_mem_supp
  CellularAutomata.TimeExpansionDependency.mem_timeInterval
  CellularAutomata.TimeExpansionDependency.card_timeInterval
  CellularAutomata.TimeExpansionDependency.card_eventSet
  CellularAutomata.TimeExpansionDependency.mem_oneStepDep
  CellularAutomata.TimeExpansionDependency.mem_supp_map_imp_mem_neighborhood
  CellularAutomata.TimeExpansionDependency.oneStepDep_subset
  CellularAutomata.TimeExpansionDependency.card_scan_pairs_local
  CellularAutomata.TimeExpansionDependency.time_strictly_increases
  CellularAutomata.TimeExpansionDependency.globalMap_eq_extendRule_from_necessary_sufficient
  CellularAutomata.TimeExpansionDependency.globalFlip_iff_mem_supp_from_necessary_sufficient
  CellularAutomata.TimeExpansionDependency.card_eventSet_from_necessary_sufficient
  CellularAutomata.TimeExpansionDependency.time_strictly_increases_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.path_time_strictly_increases
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_subset_event_product
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_finite
  CellularAutomata.TransitiveClosureAntisymmetry.oneStep_subset_reachable
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_transitive
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_minimal
  CellularAutomata.TransitiveClosureAntisymmetry.no_mutual_reachability
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_irreflexive
  CellularAutomata.TransitiveClosureAntisymmetry.reflReachable_partial_order
  CellularAutomata.TransitiveClosureAntisymmetry.isDepPath_iff_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_iff_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reflReachable_iff_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.path_time_strictly_increases_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_finite_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.oneStep_subset_reachable_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_transitive_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_minimal_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.no_mutual_reachability_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reachable_irreflexive_from_necessary_sufficient
  CellularAutomata.TransitiveClosureAntisymmetry.reflReachable_partial_order_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.oneStep_time_succ
  CellularAutomata.FinitePropagationBoundary.oneStep_source_mem_suppV
  CellularAutomata.FinitePropagationBoundary.path_time_increment_exact
  CellularAutomata.FinitePropagationBoundary.propagationBall_one
  CellularAutomata.FinitePropagationBoundary.propagationBall_succ
  CellularAutomata.FinitePropagationBoundary.card_propagationBall_one
  CellularAutomata.FinitePropagationBoundary.card_propagationBall_succ_le
  CellularAutomata.FinitePropagationBoundary.start_cell_in_propagationBall
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_finite
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_subset_boundary
  CellularAutomata.FinitePropagationBoundary.card_dependencySourceSet_le
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_zero_empty
  CellularAutomata.FinitePropagationBoundary.path_time_increment_exact_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.propagationBall_eq_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.card_propagationBall_succ_le_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.start_cell_in_propagationBall_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_eq_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_finite_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_subset_boundary_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.card_dependencySourceSet_le_from_necessary_sufficient
  CellularAutomata.FinitePropagationBoundary.dependencySourceSet_zero_empty_from_necessary_sufficient
)

tmpdir="$(mktemp -d /tmp/check-axioms-XXXXXX)"
tmpfile="$tmpdir/check.lean"
trap 'rm -f "$tmpfile"; rmdir "$tmpdir"' EXIT

{
  echo "import CellularAutomata"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > "$tmpfile"

output="$(lake env lean "$tmpfile" 2>&1)" || {
  echo "NG: 公理検査用ファイルの実行に失敗した" >&2
  printf '%s\n' "$output" >&2
  exit 1
}

printf '%s\n' "$output"

if printf '%s' "$output" | grep -q "sorryAx"; then
  echo "NG: sorryAx に依存する定理がある" >&2
  status=1
else
  echo "OK: 登録した定理はいずれも sorryAx に依存しない"
fi

exit $status
