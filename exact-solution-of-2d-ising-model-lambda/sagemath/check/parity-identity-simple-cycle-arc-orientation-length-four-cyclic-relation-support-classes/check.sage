"""語長四の巡回不変な混合関係商を特徴支持の種類で分類する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

弧型係数と特徴係数を混ぜる巡回不変関係の特徴部分は、弧型だけの
関係で割った商を忠実に表す。この 339 次元部分空間を巡回軌道座標へ
圧縮し、一次特徴・端点特徴・語位置間隔ごとの二特徴積へ分類する。
"""

print("LOAD: constructing cyclic arc-feature relation system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-arc-feature-relations/check.sage")

# 行空間 [B | F] を B の列から先に掃き出す。B 部分が零の行の F 部分は、
# yB=0 を満たす行結合 y が作る特徴関係の基底である。ここで
# B=[閉路型係数 | 巡回移送との差]、F=特徴係数である。
print("RELATIONS: extracting feature images", flush=True)
prefix_width = invariant_constraints.ncols()
combined_echelon = invariant_constraints.augment(feature_system).echelon_form()
feature_relation_rows = []
for row in combined_echelon.rows():
    if any(row[position] for position in range(prefix_width)):
        continue
    suffix = vector(GF(2), row[prefix_width:])
    if not suffix.is_zero():
        feature_relation_rows.append(suffix)

feature_relations = matrix(GF(2), feature_relation_rows, sparse=True)
assert feature_relations.nrows() == feature_relations.rank() == 339
assert feature_relations.ncols() == len(feature_labels) == 3240

# 巡回移送の軌道へ圧縮する。不変関係では同じ軌道の係数が等しい。
unseen = set(feature_labels)
orbits = []
while unseen:
    representative = min(unseen, key=label_position.__getitem__)
    orbit = tuple(dict.fromkeys(
        shift_label(representative, amount) for amount in range(4)))
    assert all(label in unseen for label in orbit)
    unseen.difference_update(orbit)
    orbits.append(orbit)

assert len(orbits) == 1212
orbit_positions = tuple(
    tuple(label_position[label] for label in orbit) for orbit in orbits)
for row in feature_relations.rows():
    for positions in orbit_positions:
        assert len({row[position] for position in positions}) == 1

compressed = matrix(
    GF(2),
    [[row[positions[0]] for positions in orbit_positions]
     for row in feature_relations.rows()],
    sparse=True,
)
assert compressed.rank() == 339


def atom_step(atom):
    """語位置特徴なら位置を返し、端点特徴なら None を返す。"""
    if not atom.startswith("step"):
        return None
    return int(atom.split("_", 1)[0][4:])


def support_class(label):
    atoms = label.split("*")
    if len(atoms) == 1:
        return ("step_linear" if atom_step(atoms[0]) is not None
                else "endpoint_linear")
    assert len(atoms) == 2
    steps = tuple(atom_step(atom) for atom in atoms)
    if steps == (None, None):
        return "endpoint_endpoint"
    if (steps[0] is None) != (steps[1] is None):
        return "step_endpoint"
    distance = (steps[1] - steps[0]) % 4
    if distance == 0:
        return "step_step_same_position"
    if distance == 2:
        return "step_step_opposite_positions"
    return "step_step_neighboring_positions"


class_order = (
    "step_linear",
    "endpoint_linear",
    "step_step_same_position",
    "step_step_neighboring_positions",
    "step_step_opposite_positions",
    "step_endpoint",
    "endpoint_endpoint",
)
class_positions = {
    name: tuple(index for index, orbit in enumerate(orbits)
                if support_class(orbit[0]) == name)
    for name in class_order
}
assert tuple(len(class_positions[name]) for name in class_order) == (
    12, 32, 66, 144, 78, 384, 496)
assert sum(len(positions) for positions in class_positions.values()) == 1212

class_results = {}
all_positions = set(range(compressed.ncols()))
for name in class_order:
    positions = class_positions[name]
    complement = tuple(sorted(all_positions.difference(positions)))
    projection_rank = compressed.matrix_from_columns(positions).rank()
    complement_rank = compressed.matrix_from_columns(complement).rank()
    supported_dimension = compressed.rank() - complement_rank
    class_results[name] = {
        "orbit_count": len(positions),
        "projection_rank": int(projection_rank),
        "supported_dimension": int(supported_dimension),
    }
    print("CLASS: %s orbits=%d projection_rank=%d supported_dimension=%d" %
          (name, len(positions), projection_rank, supported_dimension),
          flush=True)

# 語位置だけ、端点だけ、および両者を混ぜる座標群でも同じ不変量を取る。
group_positions = {
    "step_only": tuple(sorted(
        class_positions["step_linear"] +
        class_positions["step_step_same_position"] +
        class_positions["step_step_neighboring_positions"] +
        class_positions["step_step_opposite_positions"])),
    "endpoint_only": tuple(sorted(
        class_positions["endpoint_linear"] +
        class_positions["endpoint_endpoint"])),
    "step_endpoint": class_positions["step_endpoint"],
}
group_results = {}
for name, positions in group_positions.items():
    complement = tuple(sorted(all_positions.difference(positions)))
    projection_rank = compressed.matrix_from_columns(positions).rank()
    supported_dimension = compressed.rank() - compressed.matrix_from_columns(
        complement).rank()
    group_results[name] = {
        "orbit_count": len(positions),
        "projection_rank": int(projection_rank),
        "supported_dimension": int(supported_dimension),
    }
    print("GROUP: %s orbits=%d projection_rank=%d supported_dimension=%d" %
          (name, len(positions), projection_rank, supported_dimension),
          flush=True)

import json
from pathlib import Path

certificate = {
    "kind": "cyclic-relation-support-classes",
    "feature_count": len(feature_labels),
    "cyclic_orbit_count": len(orbits),
    "mixed_quotient_dimension": int(compressed.rank()),
    "classes": class_results,
    "groups": group_results,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-support-classes/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic mixed relation support classified", flush=True)
