"""左スロットの正準二項を固定した解の係数を縮約する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

語長一の全純二次項と語長三の固定項を保ち、語長二では直前までに
残した 400 項に加えて

  step0_e_up * end0_d_left,
  step0_d_up * end0_e_left

だけを許す。保存済みの厳密解を、係数座標へ射影した右核の既約階段
基底で縮約し、解空間だけで決まる正準代表の支持台を取り出す。
有限集合と F_2 の厳密演算だけを使い、浮動小数点は使わない。
"""

print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-up-end0-horizontal-slot-split/construction.sage")

print("LOAD: finite key data ready", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
system, system_rhs, blocks = length_two_step0_up_end0_horizontal_slot_system(
    entries, rhs, all_types, column_index, "left")
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
assert system.dimensions() == (12220, 13356)
assert tuple(len(blocks[n][0]) for n in (1, 2, 3)) == (1249, 1842, 2044)
assert tuple(len(blocks[n][2]) for n in (1, 2, 3)) == (946, 1162, 1150)

import json
from pathlib import Path

certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-up-end0-horizontal-slot-split/certificate.json")
saved = json.loads(certificate_path.read_text())["end0_left"]
particular = vector(GF(2), saved["solution"])
assert len(particular) == system.ncols()
assert system * particular == system_rhs

coefficient_start = len(all_types)
coefficient_columns = list(range(coefficient_start, system.ncols()))
print("KERNEL: computing projected solution freedom", flush=True)
kernel_basis = system.right_kernel_matrix()
projected = kernel_basis.matrix_from_columns(coefficient_columns)
projected_echelon = projected.echelon_form()
projected_dimension = projected_echelon.rank()
canonical = vector(GF(2), particular[coefficient_start:])
for row_index in range(projected_dimension):
    row = projected_echelon.row(row_index)
    pivot = row.nonzero_positions()[0]
    if canonical[pivot] == 1:
        canonical += row

forced = {index for index in range(len(coefficient_columns))
          if projected_echelon.column(index).is_zero()}
forced_nonzero = sorted(index for index in forced if canonical[index] == 1)
print("KERNEL: dim=%d projected_dim=%d forced=%d forced_nonzero=%d" %
      (kernel_basis.nrows(), projected_dimension, len(forced),
       len(forced_nonzero)), flush=True)

# 既約階段基底で定めた正準代表から、同じ決定的な基底順で Hamming 重みが
# 真に減る変更だけを反復する。これは最小重みの主張ではなく、閉じた候補式を
# 読める大きさへ縮めるための再現可能な正規化である。
sparse = canonical
improved = True
while improved:
    improved = False
    for row_index in range(projected_dimension):
        candidate = sparse + projected_echelon.row(row_index)
        if candidate.hamming_weight() < sparse.hamming_weight():
            sparse = candidate
            improved = True
print("SPARSE: canonical_weight=%d sparse_weight=%d" %
      (canonical.hamming_weight(), sparse.hamming_weight()), flush=True)


def coefficient_name_data(length, block):
    _, names, pairs, start = block
    return tuple("%s*%s" % (names[first], names[second])
                 for first, second in pairs), start - coefficient_start


support_by_length = {}
selected_terms = {
    "step0_e_up*end0_d_left",
    "step0_d_up*end0_e_left",
}
for length in (1, 2, 3):
    names, local_start = coefficient_name_data(length, blocks[length])
    support = tuple(names[offset] for offset in range(len(names))
                    if sparse[local_start + offset] == 1)
    support_by_length[length] = support
    print("CANONICAL: length=%d support=%d" % (length, len(support)),
          flush=True)
    if len(support) <= 120:
        print("CANONICAL TERMS %d: %s" % (length, ", ".join(support)),
              flush=True)

assert selected_terms.issubset(set(support_by_length[2]))

# 初回観測を固定する。射影核の階数と強制係数は解空間そのものの量、
# canonical は既約階段基底に関する正準代表である。
assert (kernel_basis.nrows(), projected_dimension,
        len(forced), len(forced_nonzero)) == (1521, 1386, 22, 10)
assert canonical.hamming_weight() == 881
assert sparse.hamming_weight() == 768
assert tuple(sum(1 for offset in range(len(blocks[length][2]))
                 if canonical[blocks[length][3] - coefficient_start + offset] == 1)
             for length in (1, 2, 3)) == (125, 372, 384)
assert tuple(len(support_by_length[length]) for length in (1, 2, 3)) \
    == (106, 318, 344)

# 正準係数が定める弧型の値を代入し、元の合同系がなお可解であることを
# 独立に確かめる。ここでは保存済みの特殊解を使わない。
assigned_values = {}
for length, (types, names, pairs, start) in blocks.items():
    local_start = start - coefficient_start
    for arc_type in types:
        bits = arc_feature_bits(arc_type)
        assigned_values[column_index[arc_type]] = GF(2)(sum(
            sparse[local_start + offset] * bits[first] * bits[second]
            for offset, (first, second) in enumerate(pairs)) +
            (sum(bits[12 * k] * bits[12 * k + 2] for k in range(length))
             if length == 3 else 0))

assigned_columns = set(assigned_values)
free_columns = [column for column in range(len(all_types))
                if column not in assigned_columns]
free_position = {column: position for position, column in enumerate(free_columns)}
restricted_entries = {}
adjusted_rhs = list(rhs)
for (row_index, column), value in entries.items():
    if column in assigned_columns:
        adjusted_rhs[row_index] += value * assigned_values[column]
    else:
        restricted_entries[(row_index, free_position[column])] = value
restricted_matrix = matrix(
    GF(2), len(rhs), len(free_columns), restricted_entries)
restricted_matrix.solve_right(vector(GF(2), adjusted_rhs))
print("SUBSTITUTION: all 7085 keys reconstructed", flush=True)

print("RESULT: PASS", flush=True)
