"""語長四の一次特徴・二特徴積の候補クラス全体を有限判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

位置ビット閉式へ先行二十特徴を加えた系へ、語長四の完全署名をなす
80 個の一次特徴とその二特徴積のうち未追加のものを一括投入する。
可解なら行階段形が選ぶ代表を、非可解なら左核矛盾証拠を保存する。
"""

print("LOAD: constructing twenty-times-extended finite system", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-twentieth-obstruction-feature-comparison/check.sage")

names = arc_feature_names(4)
assert len(names) == 80
all_pairs = tuple((first, second)
                  for first in range(len(names))
                  for second in range(first, len(names)))


def pair_label(first, second):
    return (names[first] if first == second
            else names[first] + "*" + names[second])


existing_labels = {
    distinguishing_feature_name, second_feature_name, third_feature_name,
    fourth_feature_name, fifth_feature_name, sixth_feature_name,
    seventh_feature_name, eighth_feature_name, ninth_feature_name,
    tenth_feature_name, eleventh_feature_name, twelfth_feature_name,
    thirteenth_feature_name, fourteenth_feature_name, fifteenth_feature_name,
    sixteenth_feature_name, seventeenth_feature_name, eighteenth_feature_name,
    nineteenth_feature_name, twentieth_feature_name,
}
assert len(existing_labels) == 20
remaining_pairs = tuple(
    pair for pair in all_pairs if pair_label(*pair) not in existing_labels)
assert len(all_pairs) == 3240
assert len(remaining_pairs) == 3220
remaining_labels = tuple(pair_label(*pair) for pair in remaining_pairs)
remaining_position = {pair: position
                      for position, pair in enumerate(remaining_pairs)}

# 各固定語長四弧型で一になる未追加単項式を一度だけ計算する。同じ弧型が
# 現れる各鍵へこの疎な行を XOR し、3,220 列を一括して作る。
active_offsets = {}
for column in assigned_values:
    bits = arc_feature_bits(all_types[column])
    active = tuple(index for index, bit in enumerate(bits) if bit)
    offsets = []
    for active_index, first in enumerate(active):
        for second in active[active_index:]:
            pair = (first, second)
            if pair in remaining_position:
                offsets.append(remaining_position[pair])
    active_offsets[column] = tuple(offsets)

feature_entries = {}
for (row_index, column), value in entries.items():
    if value == 0 or column not in active_offsets:
        continue
    for offset in active_offsets[column]:
        key = (row_index, offset)
        if key in feature_entries:
            del feature_entries[key]
        else:
            feature_entries[key] = GF(2)(1)

remaining_feature_matrix = matrix(
    GF(2), len(rhs), len(remaining_pairs), feature_entries, sparse=True)
candidate_system = twenty_times_extended.augment(remaining_feature_matrix)
candidate_rank = candidate_system.rank()
candidate_augmented_rank = candidate_system.augment(
    restricted_rhs.column()).rank()
candidate_solvable = candidate_rank == candidate_augmented_rank
print("CANDIDATE CLASS: features=%d existing=%d remaining=%d" %
      (len(all_pairs), len(existing_labels), len(remaining_pairs)), flush=True)
print("SYSTEM: rows=%d columns=%d rank=%d augmented_rank=%d solvable=%s" %
      (candidate_system.nrows(), candidate_system.ncols(), candidate_rank,
       candidate_augmented_rank, candidate_solvable), flush=True)

import json
from pathlib import Path

certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-full-feature-class-decision/certificate.json")

if candidate_solvable:
    solution = candidate_system.solve_right(restricted_rhs)
    assert candidate_system * solution == restricted_rhs
    feature_start = len(free_columns)
    existing_names = (
        distinguishing_feature_name, second_feature_name, third_feature_name,
        fourth_feature_name, fifth_feature_name, sixth_feature_name,
        seventh_feature_name, eighth_feature_name, ninth_feature_name,
        tenth_feature_name, eleventh_feature_name, twelfth_feature_name,
        thirteenth_feature_name, fourteenth_feature_name, fifteenth_feature_name,
        sixteenth_feature_name, seventeenth_feature_name, eighteenth_feature_name,
        nineteenth_feature_name, twentieth_feature_name,
    )
    feature_labels = existing_names + remaining_labels
    label_to_pair = {pair_label(*pair): pair for pair in all_pairs}
    feature_coefficients = solution[feature_start:]
    feature_support = tuple(
        label for label, coefficient in zip(feature_labels, feature_coefficients)
        if coefficient == 1)

    # 得た係数を固定済み語長四弧型の値へ戻し、元の 7,085 鍵を再構成する。
    corrected_values = dict(assigned_values)
    support_pairs = tuple(label_to_pair[label] for label in feature_support)
    for column in assigned_values:
        bits = arc_feature_bits(all_types[column])
        corrected_values[column] += GF(2)(sum(
            bits[first] * bits[second] for first, second in support_pairs))
    full_values = dict(corrected_values)
    full_values.update({column: solution[position]
                        for position, column in enumerate(free_columns)})
    original = matrix(GF(2), len(rhs), len(all_types), entries)
    full_vector = vector(
        GF(2), [full_values[column] for column in range(len(all_types))])
    assert original * full_vector == rhs
    certificate = {
        "kind": "row-echelon-representative",
        "feature_count": len(all_pairs),
        "rank": candidate_rank,
        "augmented_rank": candidate_augmented_rank,
        "feature_support": feature_support,
        "solution": [int(value) for value in solution],
    }
    print("REPRESENTATIVE: feature_support=%d" % len(feature_support), flush=True)
    print("RECONSTRUCTION: all 7085 keys reconstructed", flush=True)
else:
    obstruction = next(
        row for row in candidate_system.left_kernel_matrix().rows()
        if row * restricted_rhs == 1)
    assert (obstruction * candidate_system).is_zero()
    assert obstruction * restricted_rhs == 1
    obstruction_indices = tuple(obstruction.nonzero_positions())
    certificate = {
        "kind": "left-kernel-obstruction",
        "feature_count": len(all_pairs),
        "rank": candidate_rank,
        "augmented_rank": candidate_augmented_rank,
        "support": obstruction_indices,
        "rhs_sum": 1,
    }
    print("OBSTRUCTION: support=%d indices=%s" %
          (len(obstruction_indices), obstruction_indices), flush=True)

certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: full linear-quadratic feature class decided", flush=True)
