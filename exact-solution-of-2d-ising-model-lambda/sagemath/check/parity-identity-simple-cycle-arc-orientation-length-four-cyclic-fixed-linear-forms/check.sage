"""語長四の解空間で固定される巡回不変な特徴係数線型結合を分類する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

一次特徴と二特徴積 3,240 項を許した可解な有限合同系について、
特徴係数だけからなる固定線型形式の空間を求める。そのうち語位置の
巡回移動で不変な部分空間を取り出し、被約行階段基底と値を保存する。
"""

print("LOAD: constructing solvable full feature system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-full-feature-class-decision/check.sage")

assert candidate_solvable
assert len(feature_labels) == 3240
assert feature_start == len(free_columns)
assert candidate_system * solution == restricted_rhs


def shift_atom(atom, amount):
    if not atom.startswith("step"):
        return atom
    prefix, rest = atom.split("_", 1)
    position = int(prefix[4:])
    return "step%d_%s" % ((position + amount) % 4, rest)


name_position = {name: position for position, name in enumerate(names)}


def shift_label(label, amount):
    atoms = label.split("*")
    shifted = tuple(shift_atom(atom, amount) for atom in atoms)
    return "*".join(sorted(shifted, key=name_position.__getitem__))


label_position = {label: position for position, label in enumerate(feature_labels)}
assert len(label_position) == len(feature_labels)
for label in feature_labels:
    for amount in range(4):
        assert shift_label(label, amount) in label_position

# 行結合 yA が特徴係数だけを含む条件は、非特徴列 B に対して yB=0
# となることである。その y を左核から全て取り、特徴列 C へ作用させる。
print("FIXED FORMS: computing feature-only row-space intersection", flush=True)
nonfeature_system = candidate_system.matrix_from_columns(range(feature_start))
feature_system = candidate_system.matrix_from_columns(
    range(feature_start, candidate_system.ncols()))
annihilators = nonfeature_system.left_kernel_matrix()
fixed_form_generators = annihilators * feature_system
fixed_form_space = fixed_form_generators.row_space()
print("FIXED FORMS: left_annihilator_dimension=%d dimension=%d" %
      (annihilators.nrows(), fixed_form_space.dimension()), flush=True)

# 巡回移動で不変な特徴線型形式は、各巡回軌道の指示ベクトルの和で
# 生成される。軌道和空間と固定線型形式空間の共通部分を取る。
unseen = set(feature_labels)
shift_orbits = []
while unseen:
    representative = min(unseen)
    orbit = tuple(sorted(
        {shift_label(representative, amount) for amount in range(4)},
        key=label_position.__getitem__))
    assert set(orbit) <= unseen
    shift_orbits.append(orbit)
    unseen.difference_update(orbit)

orbit_sum_matrix = matrix(
    GF(2), len(shift_orbits), len(feature_labels),
    {(row, label_position[label]): GF(2)(1)
     for row, orbit in enumerate(shift_orbits)
     for label in orbit}, sparse=True)
cyclic_invariant_space = orbit_sum_matrix.row_space()
assert cyclic_invariant_space.dimension() == len(shift_orbits)

cyclic_fixed_space = fixed_form_space.intersection(cyclic_invariant_space)
cyclic_fixed_basis = cyclic_fixed_space.basis_matrix().echelon_form()
feature_solution = vector(GF(2), solution[feature_start:])


def shift_vector(row, amount):
    shifted = vector(GF(2), len(feature_labels))
    for position in row.nonzero_positions():
        shifted[label_position[shift_label(feature_labels[position], amount)]] += 1
    return shifted


# 一つの固定形式がたまたま得られるだけでなく、その巡回移動四つが
# 全て固定である線型形式の空間を直接取る。これが一般語位置へ運べる
# 候補の巡回安定核である。
cyclic_stable_core = fixed_form_space
stable_dimensions = [int(cyclic_stable_core.dimension())]
fixed_basis = fixed_form_space.basis_matrix()
for amount in range(1, 4):
    shifted_space = matrix(
        GF(2), [shift_vector(row, amount) for row in fixed_basis.rows()]
    ).row_space()
    cyclic_stable_core = cyclic_stable_core.intersection(shifted_space)
    stable_dimensions.append(int(cyclic_stable_core.dimension()))

for row in cyclic_fixed_basis.rows():
    for amount in range(4):
        assert shift_vector(row, amount) == row

assert cyclic_stable_core.intersection(cyclic_invariant_space) == cyclic_fixed_space

basis_supports = tuple(
    tuple(feature_labels[position] for position in row.nonzero_positions())
    for row in cyclic_fixed_basis.rows())
basis_values = tuple(int(row * feature_solution)
                     for row in cyclic_fixed_basis.rows())

print("CYCLIC: orbit_count=%d orbit_sizes=%s invariant_dimension=%d" %
      (len(shift_orbits),
       {size: sum(1 for orbit in shift_orbits if len(orbit) == size)
        for size in sorted({len(orbit) for orbit in shift_orbits})},
       cyclic_invariant_space.dimension()), flush=True)
print("CYCLIC FIXED FORMS: dimension=%d zero=%d one=%d support_sizes=%s" %
      (cyclic_fixed_space.dimension(), basis_values.count(0),
       basis_values.count(1), tuple(map(len, basis_supports))), flush=True)
print("CYCLIC STABLE CORE: intersection_dimensions=%s" %
      (tuple(stable_dimensions),), flush=True)

import json
from pathlib import Path

certificate = {
    "kind": "cyclic-fixed-linear-forms",
    "rank": int(candidate_rank),
    "column_count": int(candidate_system.ncols()),
    "solution_dimension": int(candidate_system.ncols() - candidate_rank),
    "feature_count": len(feature_labels),
    "fixed_linear_form_dimension": int(fixed_form_space.dimension()),
    "shift_orbit_count": len(shift_orbits),
    "shift_orbit_size_counts": {
        str(size): sum(1 for orbit in shift_orbits if len(orbit) == size)
        for size in sorted({len(orbit) for orbit in shift_orbits})
    },
    "cyclic_fixed_linear_form_dimension": int(cyclic_fixed_space.dimension()),
    "cyclic_stable_core_intersection_dimensions": stable_dimensions,
    "cyclic_stable_core_dimension": int(cyclic_stable_core.dimension()),
    "basis_values": basis_values,
    "basis_supports": basis_supports,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-fixed-linear-forms/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic fixed linear forms classified", flush=True)
