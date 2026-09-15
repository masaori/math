"""語長四の疎な巡回不変特徴関係の弧型係数側を復元する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

前段で選んだ端点だけの二軌道代表と、語位置・端点積だけの一軌道
代表を、元の有限合同系の行空間へ持ち上げる。持ち上げの弧型係数は
弧型だけの固定関係を足す自由度を持つので、その既約階段基底の
ピボットを零にする正準剰余へ縮約する。
"""

print("LOAD: constructing sparse cyclic feature representatives", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-sparse-representatives/check.sage")


def smallest_sparse_row(positions, expected_dimension):
    canonical = supported_feature_basis(positions)
    assert len(canonical) == expected_dimension
    sparse_basis = sparsify_basis(canonical)
    return min(
        sparse_basis,
        key=lambda row: (
            row.hamming_weight(),
            support_labels(row, positions),
        ),
    )


def expand_orbit_row(row, positions):
    expanded = vector(GF(2), len(feature_labels))
    for local_index in row.nonzero_positions():
        orbit_index = positions[local_index]
        for label in orbits[orbit_index]:
            expanded[label_position[label]] = 1
    return expanded


endpoint_row = smallest_sparse_row(group_positions["endpoint_only"], 144)
step_endpoint_row = smallest_sparse_row(group_positions["step_endpoint"], 115)
targets = {
    "endpoint_only": expand_orbit_row(
        endpoint_row, group_positions["endpoint_only"]),
    "step_endpoint": expand_orbit_row(
        step_endpoint_row, group_positions["step_endpoint"]),
}
assert tuple(targets["endpoint_only"].nonzero_positions()) == tuple(
    label_position[label] for label in (
        "end0_c_down*end0_wrap_col0",
        "end0_c_right*end0_wrap_col0",
    ))
assert tuple(feature_labels[position]
             for position in targets["step_endpoint"].nonzero_positions()) == (
    "step0_wrap_col0*end0_wrap_col0",
    "step1_wrap_col0*end0_wrap_col0",
    "step2_wrap_col0*end0_wrap_col0",
    "step3_wrap_col0*end0_wrap_col0",
)

arc_system = candidate_system.matrix_from_columns(arc_positions)
relation_system = invariant_constraints.augment(feature_system)

# 弧型だけの固定関係を、弧型係数とその固定値を並べた行空間として作る。
# 可解な系なので、弧型係数が零の関係の固定値は必ず零である。
pure_arc_annihilators = cycle_system.augment(feature_system).left_kernel_matrix()
pure_arc_coefficients = pure_arc_annihilators * arc_system
pure_arc_values = pure_arc_annihilators * restricted_rhs
pure_arc_augmented = pure_arc_coefficients.augment(pure_arc_values.column())
pure_arc_echelon = pure_arc_augmented.echelon_form()
pure_arc_basis = []
for row in pure_arc_echelon.rows():
    coefficients = vector(GF(2), row[:len(arc_positions)])
    value = row[len(arc_positions)]
    if coefficients.is_zero():
        assert value == 0
        continue
    pure_arc_basis.append((coefficients, value))
assert len(pure_arc_basis) == pure_arc_relation_dimension == 4876


def canonical_arc_lift(name, feature_target):
    target = vector(
        GF(2),
        invariant_constraints.ncols() + feature_system.ncols(),
    )
    target[invariant_constraints.ncols():] = feature_target

    # y が作る行結合は、巡回不変性の制約を消し、指定した特徴関係を残す。
    witness = relation_system.transpose().solve_right(target)
    assert witness * invariant_constraints == 0
    assert witness * feature_system == feature_target

    arc_coefficients = vector(GF(2), witness * arc_system)
    relation_value = witness * restricted_rhs
    raw_weight = arc_coefficients.hamming_weight()

    # 弧型だけの関係を加えて、既約階段基底の各ピボットを零にする。
    for pure_coefficients, pure_value in pure_arc_basis:
        pivot = pure_coefficients.nonzero_positions()[0]
        if arc_coefficients[pivot] == 1:
            arc_coefficients += pure_coefficients
            relation_value += pure_value
    for pure_coefficients, _ in pure_arc_basis:
        assert arc_coefficients[pure_coefficients.nonzero_positions()[0]] == 0

    full_relation = vector(GF(2), candidate_system.ncols())
    for local_position, coefficient in enumerate(arc_coefficients):
        full_relation[arc_positions[local_position]] = coefficient
    for position, coefficient in enumerate(feature_target):
        full_relation[feature_start + position] = coefficient

    assert all(full_relation[position] == 0 for position in cycle_positions)
    assert vector(GF(2), full_relation[feature_start:]) == feature_target
    assert full_relation in candidate_system.row_space()
    assert full_relation * solution == relation_value

    arc_support_positions = tuple(arc_coefficients.nonzero_positions())
    result = {
        "feature_support": tuple(
            feature_labels[position]
            for position in feature_target.nonzero_positions()),
        "raw_arc_weight": int(raw_weight),
        "canonical_arc_weight": int(len(arc_support_positions)),
        "relation_value": int(relation_value),
        "arc_support": tuple(
            repr(all_types[free_columns[arc_positions[position]]])
            for position in arc_support_positions),
    }
    print(
        "LIFT %s: feature_weight=%d raw_arc_weight=%d "
        "canonical_arc_weight=%d value=%d" % (
            name,
            feature_target.hamming_weight(),
            raw_weight,
            len(arc_support_positions),
            relation_value,
        ),
        flush=True,
    )
    return result


results = {
    name: canonical_arc_lift(name, target)
    for name, target in targets.items()
}

import json
from pathlib import Path

certificate = {
    "kind": "cyclic-relation-arc-lifts",
    "normal_form": "zero the pivots of the reduced basis of pure-arc fixed relations",
    "pure_arc_relation_dimension": int(pure_arc_relation_dimension),
    "lifts": results,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: sparse cyclic feature relations lifted to arc coefficients", flush=True)
