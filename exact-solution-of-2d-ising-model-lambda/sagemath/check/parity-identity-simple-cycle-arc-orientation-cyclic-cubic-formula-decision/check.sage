"""固定原始特徴の次数三以下の式を二係数について一括判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

絶対境界方向の四指示関数、相対端点十成分、境界基準の巡回三文字
出現回数の偶奇を原始特徴に固定する。定数・一次・相異なる二特徴積・
相異なる三特徴積を全て許す F_2 多項式が、二つの正準係数を全候補で
同時に返すかを、一つの有限線形系で判定する。
"""

import json
from itertools import combinations
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-quadratic-formula/"
    "check.sage"
)

QUADRATIC_COEFFICIENT_COUNT = COEFFICIENT_COUNT
CUBIC_COEFFICIENT_COUNT = binomial(PRIMITIVE_COUNT, 3)
TOTAL_COEFFICIENT_COUNT = QUADRATIC_COEFFICIENT_COUNT + CUBIC_COEFFICIENT_COUNT


def cubic_offset(first, second, third):
    assert 0 <= first < second < third < PRIMITIVE_COUNT
    # 相異なる三添字の colex 順位。0 以上 binomial(PRIMITIVE_COUNT, 3) 未満。
    return binomial(first, 1) + binomial(second, 2) + binomial(third, 3)


observed_cubic_columns = {}
for observation in observations:
    row = set(observation["row"])
    for first, second, third in combinations(observation["active"], 3):
        column = QUADRATIC_COEFFICIENT_COUNT + cubic_offset(first, second, third)
        row.add(column)
        observed_cubic_columns[column] = (first, second, third)
    observation["row"] = row

observed_columns = set().union(*(
    observation["row"] for observation in observations
))
print(
    "SYSTEM: observations=%d primitives=%d coefficients=%d observed_columns=%d observed_cubics=%d" % (
        len(observations), PRIMITIVE_COUNT, TOTAL_COEFFICIENT_COUNT,
        len(observed_columns), len(observed_cubic_columns),
    ),
    flush=True,
)

# 行と二つの標的を同じ消去で処理する。証拠は元の観測行の XOR として保持する。
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
        targets = [
            (left + right) % 2
            for left, right in zip(targets, basis_targets)
        ]
        witness.symmetric_difference_update(basis_witness)
    if not row:
        for support_index, target in enumerate(targets):
            if target == 1 and contradictions[support_index] is None:
                contradictions[support_index] = tuple(sorted(witness))

rank = len(basis)


def xor_rows(indices):
    total = set()
    for index in indices:
        total.symmetric_difference_update(observations[index]["row"])
    return total


def xor_target(indices, support_index):
    total = ZZ(0)
    for index in indices:
        total = (total + observations[index]["targets"][support_index]) % 2
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
    if contradiction is not None:
        assert not xor_rows(contradiction)
        assert xor_target(contradiction, support_index) == 1
        result["left_kernel_observation_indices"] = list(map(int, contradiction))
        result["left_kernel_observation_count"] = len(contradiction)
    else:
        values = {}
        for pivot in sorted(basis):
            row, targets, _ = basis[pivot]
            value = targets[support_index]
            for column in row:
                if column != pivot:
                    value = (value + values.get(column, 0)) % 2
            values[pivot] = ZZ(value)
        canonical_support = {
            column for column, value in values.items() if value == 1
        }
        for observation in observations:
            actual = sum(
                (ZZ(column in canonical_support) for column in observation["row"]),
                ZZ(0),
            ) % 2
            assert actual == observation["targets"][support_index]
        result["canonical_support_columns"] = list(map(int, sorted(canonical_support)))
        result["canonical_support_size"] = len(canonical_support)
        result["solution_space_dimension"] = TOTAL_COEFFICIENT_COUNT - rank
    results[support_name] = result
    print(
        "RESULT %s: rank=%d augmented_rank=%d solvable=%s" % (
            support_name, result["rank"], result["augmented_rank"], solvable,
        ),
        flush=True,
    )

certificate = {
    "kind": "cyclic-cubic-formula-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "observation_count": len(observations),
    "primitive_feature_counts": {
        "absolute_boundary_direction_indicators": DIRECTION_COUNT,
        "relative_endpoint_components": ENDPOINT_COUNT,
        "boundary_framed_triple_parities": TRIPLE_COUNT,
        "total": PRIMITIVE_COUNT,
    },
    "coefficient_count": int(TOTAL_COEFFICIENT_COUNT),
    "observed_coefficient_count": len(observed_columns),
    "observed_cubic_coefficient_count": len(observed_cubic_columns),
    "support_order": list(support_names),
    "results": results,
    "conclusion": (
        "a degree-at-most-three polynomial in the fixed primitive features "
        "exists for both canonical coefficients on every feasible candidate"
        if all(result["solvable"] for result in results.values()) else
        "the degree-at-most-three candidate class is obstructed for at least "
        "one canonical coefficient on the finite universe"
    ),
    "no_automatic_escalation": (
        "an inconsistent result does not authorize degree four or new primitive features"
    ),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-cubic-formula-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: degree-at-most-three formula class decided", flush=True)
