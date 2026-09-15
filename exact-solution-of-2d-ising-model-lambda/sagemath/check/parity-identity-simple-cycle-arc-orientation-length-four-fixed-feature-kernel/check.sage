"""語長四の候補クラスの解空間で固定される特徴係数を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

一次特徴と二特徴積 3,240 項を許した可解な有限合同系の全解について、
値が固定される特徴係数を被約行階段形から取り出す。さらに語位置の
巡回移動で閉じる固定非零係数の軌道があるかを判定する。
"""

print("LOAD: constructing solvable full feature system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-full-feature-class-decision/check.sage")

assert candidate_solvable
assert len(feature_labels) == 3240
assert candidate_system * solution == restricted_rhs

print("ECHELON: reducing candidate system", flush=True)
reduced = candidate_system.echelon_form()
pivots = reduced.pivots()
assert len(pivots) == candidate_rank

# 被約行階段形の行が標準基底ベクトル e_j であることと、j 番目の
# 係数が同次解空間の全方向で零であることは同値である。従って、その
# 係数は非同次系の全解で固定され、値は既知の一解から読める。
unit_pivot_columns = set()
for row in reduced.rows():
    support = row.nonzero_positions()
    if len(support) == 1:
        unit_pivot_columns.add(support[0])

fixed_features = []
for offset, label in enumerate(feature_labels):
    column = feature_start + offset
    if column in unit_pivot_columns:
        fixed_features.append((label, int(solution[column])))

fixed_one = tuple(label for label, value in fixed_features if value == 1)
fixed_zero = tuple(label for label, value in fixed_features if value == 0)
print("FIXED FEATURES: total=%d zero=%d one=%d" %
      (len(fixed_features), len(fixed_zero), len(fixed_one)), flush=True)


def shift_atom(atom, amount):
    if not atom.startswith("step"):
        return atom
    prefix, rest = atom.split("_", 1)
    position = int(prefix[4:])
    return "step%d_%s" % ((position + amount) % 4, rest)


def shift_label(label, amount):
    atoms = label.split("*")
    shifted = tuple(shift_atom(atom, amount) for atom in atoms)
    return "*".join(sorted(shifted, key=names.index))


fixed_value = dict(fixed_features)
fixed_one_set = set(fixed_one)
fixed_one_orbits = []
unseen = set(fixed_one)
while unseen:
    representative = min(unseen)
    orbit = tuple(sorted({shift_label(representative, amount)
                          for amount in range(4)}))
    present = tuple(label for label in orbit if label in fixed_one_set)
    fixed_one_orbits.append((orbit, present))
    unseen.difference_update(present)

complete_fixed_one_orbits = tuple(
    orbit for orbit, present in fixed_one_orbits if len(orbit) == len(present))
partial_fixed_one_orbits = tuple(
    (orbit, present) for orbit, present in fixed_one_orbits
    if len(orbit) != len(present))
print("SHIFT: complete_fixed_one_orbits=%d partial_fixed_one_orbits=%d" %
      (len(complete_fixed_one_orbits), len(partial_fixed_one_orbits)), flush=True)

# 固定係数の判定を右核の定義へ戻す。固定と判定した列は標準基底が
# 行空間に属するので、任意の右核ベクトルとの内積が零になる。
for column in unit_pivot_columns:
    assert tuple(reduced.column(column).nonzero_positions()) == (
        pivots.index(column),)

import json
from pathlib import Path

certificate = {
    "kind": "fixed-feature-kernel",
    "rank": candidate_rank,
    "column_count": candidate_system.ncols(),
    "solution_dimension": candidate_system.ncols() - candidate_rank,
    "feature_count": len(feature_labels),
    "fixed_feature_count": len(fixed_features),
    "fixed_zero_count": len(fixed_zero),
    "fixed_one": fixed_one,
    "complete_fixed_one_shift_orbits": complete_fixed_one_orbits,
    "partial_fixed_one_shift_orbits": partial_fixed_one_orbits,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-fixed-feature-kernel/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: fixed feature kernel decided", flush=True)
