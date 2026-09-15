"""語長四の解空間で弧型係数を含む巡回共変な固定線型関係を分類する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

一次特徴と二特徴積 3,240 項を許した可解な有限合同系について、
自由な弧型係数と特徴係数だけからなる固定線型形式の空間を求める。
語位置の巡回移動は特徴係数へ作用し、弧型係数は固定する。その作用で
不変な関係と、四つの巡回移送が全て固定関係に留まる共変核を分類する。
"""

print("LOAD: constructing solvable full feature system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-full-feature-class-decision/check.sage")

assert candidate_solvable
assert len(feature_labels) == 3240
assert feature_start == len(free_columns)
assert candidate_system * solution == restricted_rhs

arc_positions = tuple(
    position for position, column in enumerate(free_columns)
    if all_types[column][0] == "arc")
cycle_positions = tuple(
    position for position, column in enumerate(free_columns)
    if all_types[column][0] == "cycle")
assert len(arc_positions) + len(cycle_positions) == feature_start

name_position = {name: position for position, name in enumerate(names)}
label_position = {label: position for position, label in enumerate(feature_labels)}


def shift_atom(atom, amount):
    if not atom.startswith("step"):
        return atom
    prefix, rest = atom.split("_", 1)
    position = int(prefix[4:])
    return "step%d_%s" % ((position + amount) % 4, rest)


def shift_label(label, amount):
    atoms = label.split("*")
    shifted = tuple(shift_atom(atom, amount) for atom in atoms)
    return "*".join(sorted(shifted, key=name_position.__getitem__))


for label in feature_labels:
    for amount in range(4):
        assert shift_label(label, amount) in label_position


left_kernel_dimension = candidate_system.nrows() - candidate_rank
cycle_system = candidate_system.matrix_from_columns(cycle_positions)
feature_system = candidate_system.matrix_from_columns(
    range(feature_start, candidate_system.ncols()))

# 行結合 yA が弧型係数と特徴係数だけに台を持つ条件は yC=0 である。
# さらに特徴部分が一位置の巡回移動で不変である条件は
# yF_j=yF_{shift(j)}、すなわち y(F_j+F_{shift(j)})=0 である。
print("RELATIONS: ranking support and invariance constraints", flush=True)
arc_feature_constraint_rank = cycle_system.rank()
arc_feature_relation_dimension = (
    candidate_system.nrows() - arc_feature_constraint_rank - left_kernel_dimension)

pure_arc_constraints = cycle_system.augment(feature_system)
pure_arc_constraint_rank = pure_arc_constraints.rank()
pure_arc_relation_dimension = (
    candidate_system.nrows() - pure_arc_constraint_rank - left_kernel_dimension)

shifted_positions = tuple(
    label_position[shift_label(label, 1)] for label in feature_labels)
shifted_feature_system = feature_system.matrix_from_columns(shifted_positions)
invariance_differences = feature_system + shifted_feature_system
invariant_constraints = cycle_system.augment(invariance_differences)
invariant_constraint_rank = invariant_constraints.rank()
invariant_relation_dimension = (
    candidate_system.nrows() - invariant_constraint_rank - left_kernel_dimension)
invariant_mixed_dimension = (
    invariant_relation_dimension - pure_arc_relation_dimension)

assert 0 <= pure_arc_relation_dimension <= invariant_relation_dimension
assert invariant_relation_dimension <= arc_feature_relation_dimension
assert invariant_mixed_dimension >= 0
assert (len(arc_positions), len(cycle_positions)) == (7609, 359)
assert (arc_feature_constraint_rank,
        arc_feature_relation_dimension) == (359, 6434)
assert (pure_arc_constraint_rank, pure_arc_relation_dimension) == (1917, 4876)
assert (invariant_constraint_rank, invariant_relation_dimension,
        invariant_mixed_dimension) == (1578, 5215, 339)

print("SUPPORTED: arcs=%d cycles=%d constraint_rank=%d relation_dimension=%d" %
      (len(arc_positions), len(cycle_positions), arc_feature_constraint_rank,
       arc_feature_relation_dimension), flush=True)
print("PURE ARC: constraint_rank=%d relation_dimension=%d" %
      (pure_arc_constraint_rank, pure_arc_relation_dimension), flush=True)
print("INVARIANT: constraint_rank=%d relation_dimension=%d "
      "mixed_quotient_dimension=%d" %
      (invariant_constraint_rank, invariant_relation_dimension,
       invariant_mixed_dimension), flush=True)

import json
from pathlib import Path

certificate = {
    "kind": "cyclic-arc-feature-relations",
    "rank": int(candidate_rank),
    "column_count": int(candidate_system.ncols()),
    "arc_coefficient_count": len(arc_positions),
    "cycle_coefficient_count": len(cycle_positions),
    "feature_count": len(feature_labels),
    "left_kernel_dimension": int(left_kernel_dimension),
    "arc_feature_constraint_rank": int(arc_feature_constraint_rank),
    "arc_feature_relation_dimension": int(arc_feature_relation_dimension),
    "pure_arc_constraint_rank": int(pure_arc_constraint_rank),
    "pure_arc_relation_dimension": int(pure_arc_relation_dimension),
    "cyclic_invariant_constraint_rank": int(invariant_constraint_rank),
    "cyclic_invariant_relation_dimension": int(invariant_relation_dimension),
    "cyclic_invariant_mixed_quotient_dimension": int(invariant_mixed_dimension),
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-arc-feature-relations/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic arc-feature relations classified", flush=True)
