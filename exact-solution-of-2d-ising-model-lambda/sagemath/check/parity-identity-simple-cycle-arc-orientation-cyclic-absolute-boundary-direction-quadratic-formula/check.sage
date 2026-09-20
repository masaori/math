"""絶対境界方向・相対端点・巡回三文字頻度の次数二以下の式を一括判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

原始特徴を、絶対境界方向の四指示関数、既存の相対端点十成分、
境界基準の巡回三文字出現回数の偶奇に固定する。定数項・一次項・
相異なる二特徴の積を全て許す F_2 多項式が、二つの正準係数を
各弧型の全ての実現可能な境界入射候補で同時に返すかを判定する。
"""

import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-decision/"
    "check.sage"
)

DIRECTION_COUNT = 4
ENDPOINT_COUNT = len(selected)
TRIPLE_COUNT = len(boundary_framed_triples)
PRIMITIVE_COUNT = DIRECTION_COUNT + ENDPOINT_COUNT + TRIPLE_COUNT
COEFFICIENT_COUNT = 1 + PRIMITIVE_COUNT + PRIMITIVE_COUNT * (PRIMITIVE_COUNT - 1) // 2
support_names = tuple(sorted(supports))


def pair_offset(first, second):
    assert 0 <= first < second < PRIMITIVE_COUNT
    return first * (2 * PRIMITIVE_COUNT - first - 1) // 2 + second - first - 1


def candidate_active_primitives(candidate):
    boundary_direction, endpoint_bits, sparse_counts = candidate
    active = [ZZ(boundary_direction)]
    active.extend(
        DIRECTION_COUNT + index
        for index, bit in enumerate(endpoint_bits) if bit % 2 == 1
    )
    active.extend(
        DIRECTION_COUNT + ENDPOINT_COUNT + index
        for index, count in sparse_counts if count % 2 == 1
    )
    assert len(set(active)) == len(active)
    return tuple(sorted(active))


def degree_two_row(active):
    row = {0}
    row.update(1 + index for index in active)
    quadratic_start = 1 + PRIMITIVE_COUNT
    for offset, first in enumerate(active):
        for second in active[offset + 1:]:
            row.add(quadratic_start + pair_offset(first, second))
    return row


observations = []
observed_pair_columns = {}
quadratic_start = 1 + PRIMITIVE_COUNT
for arc_type in arc_types:
    targets = tuple(ZZ(arc_type in supports[name]) for name in support_names)
    for candidate_index, candidate in enumerate(absolute_descriptors[arc_type]):
        active = candidate_active_primitives(candidate)
        row = degree_two_row(active)
        for offset, first in enumerate(active):
            for second in active[offset + 1:]:
                column = quadratic_start + pair_offset(first, second)
                observed_pair_columns[column] = (first, second)
        observations.append({
            "arc_type": arc_type,
            "candidate_index": candidate_index,
            "active": active,
            "row": row,
            "targets": targets,
        })

print(
    "SYSTEM: observations=%d primitives=%d coefficients=%d observed_columns=%d" % (
        len(observations), PRIMITIVE_COUNT, COEFFICIENT_COUNT,
        len(set().union(*(observation["row"] for observation in observations))),
    ),
    flush=True,
)

# 疎な集合の XOR だけで F_2 の消去を行う。各基底行には元の観測行の
# 組合せも保持し、非可解なら左核矛盾証拠をその場で再検算する。
basis = {}
contradictions = [None for _ in support_names]
for observation_index, observation in enumerate(observations):
    row = set(observation["row"])
    targets = list(observation["targets"])
    witness = {observation_index}
    while row:
        pivot = max(row)
        if pivot not in basis:
            basis[pivot] = (row, tuple(targets), witness)
            break
        basis_row, basis_targets, basis_witness = basis[pivot]
        row.symmetric_difference_update(basis_row)
        targets = [left + right for left, right in zip(targets, basis_targets)]
        witness.symmetric_difference_update(basis_witness)
    if not row:
        for support_index, target in enumerate(targets):
            if target == 1 and contradictions[support_index] is None:
                contradictions[support_index] = tuple(sorted(witness))

rank = len(basis)


def xor_observation_rows(indices):
    total = set()
    for index in indices:
        total.symmetric_difference_update(observations[index]["row"])
    return total


def xor_targets(indices, support_index):
    total = ZZ(0)
    for index in indices:
        total += observations[index]["targets"][support_index]
    return total


results = {}
for support_index, support_name in enumerate(support_names):
    contradiction = contradictions[support_index]
    solvable = contradiction is None
    result = {
        "rank": rank,
        "augmented_rank": rank if solvable else rank + 1,
        "solvable": solvable,
    }
    if not solvable:
        assert not xor_observation_rows(contradiction)
        assert xor_targets(contradiction, support_index) == 1
        result["left_kernel_observation_indices"] = list(map(int, contradiction))
        result["left_kernel_observation_count"] = len(contradiction)
    else:
        values = {}
        for pivot in sorted(basis):
            row, targets, _ = basis[pivot]
            value = targets[support_index]
            for column in row:
                if column != pivot:
                    value += values.get(column, 0)
            values[pivot] = ZZ(value)
        canonical_support = {column for column, value in values.items() if value == 1}
        for observation in observations:
            actual = sum((ZZ(column in canonical_support) for column in observation["row"]), ZZ(0))
            assert actual == observation["targets"][support_index]
        result["canonical_support_columns"] = list(map(int, sorted(canonical_support)))
        result["canonical_support_size"] = len(canonical_support)
        result["solution_space_dimension"] = COEFFICIENT_COUNT - rank
    results[support_name] = result
    print(
        "RESULT %s: rank=%d augmented_rank=%d solvable=%s" % (
            support_name, result["rank"], result["augmented_rank"], solvable,
        ),
        flush=True,
    )

certificate = {
    "kind": "cyclic-absolute-boundary-direction-quadratic-formula-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "observation_count": len(observations),
    "primitive_feature_counts": {
        "absolute_boundary_direction_indicators": DIRECTION_COUNT,
        "relative_endpoint_components": ENDPOINT_COUNT,
        "boundary_framed_triple_parities": TRIPLE_COUNT,
        "total": PRIMITIVE_COUNT,
    },
    "coefficient_count": COEFFICIENT_COUNT,
    "observed_coefficient_count": len(set().union(*(
        observation["row"] for observation in observations
    ))),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "support_order": support_names,
    "results": results,
    "conclusion": (
        "a degree-at-most-two polynomial in the fixed primitive features exists "
        "for both canonical coefficients on every feasible candidate"
        if all(result["solvable"] for result in results.values()) else
        "the degree-at-most-two candidate class is obstructed for at least one "
        "canonical coefficient on the finite universe"
    ),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-quadratic-formula/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int) + "\n"
)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: degree-at-most-two formula class decided", flush=True)
