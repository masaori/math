"""orient_d 署名の合同線型系の解の支持台を調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-membership で、内部頂点を
スロット名順の E 所属（向き）・切断旗・D 所属の組へ圧縮した orient_d 署名は
直接衝突なしで合同 F_2 線型系に解を持つと確定した。ここではその解の
支持台（値 1 を取る弧型の集合）を核ベクトルによる貪欲な縮約で小さくし、
支持台の構造——種別（閉路型か弧型か）・語長の分布・内部頂点の D 所属や
切断旗が関与する割合——を観測して、弧型ごとの値の閉じた式の候補を絞る。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-support/construction.sage")


compressor = make_orientation_membership_compressor(True, False, True)

type_lists = []
for side, doubled, single, _ in joint_keys:
    type_lists.append(compressed_arc_types(side, doubled, single, compressor))
all_types = sorted({arc_type for types in type_lists for arc_type in types})
column_index = {arc_type: index for index, arc_type in enumerate(all_types)}

# 行は「奇数回現れる弧型の台」だけを持つ疎な形で作る
# （parity-identity-simple-cycle-arc-orientation-membership と同じ）。
entries = {}
for row_index, types in enumerate(type_lists):
    multiplicities = {}
    for arc_type in types:
        multiplicities[arc_type] = multiplicities.get(arc_type, 0) + 1
    for arc_type, count in multiplicities.items():
        if count % 2 == 1:
            entries[(row_index, column_index[arc_type])] = GF(2)(1)
system_matrix = matrix(GF(2), len(joint_keys), len(all_types), entries)
system_vector = vector(GF(2), [term for _, _, _, term in joint_keys])

solution = system_matrix.solve_right(system_vector)
kernel_basis = system_matrix.right_kernel().basis()
raw_weight = solution.hamming_weight()
sparse_solution = sparsify_by_kernel(solution, kernel_basis)
sparse_weight = sparse_solution.hamming_weight()
print("SUPPORT: raw=%d kernel-dim=%d sparse=%d"
      % (raw_weight, len(kernel_basis), sparse_weight), flush=True)

# 縮めた解が実際に解であることを検査する。
assert system_matrix * sparse_solution == system_vector
assert sparse_weight <= raw_weight

support_types = [all_types[index] for index in range(len(all_types))
                 if sparse_solution[index] != 0]
cycle_count = sum(1 for arc_type in support_types if arc_type[0] == "cycle")
arc_count = sum(1 for arc_type in support_types if arc_type[0] == "arc")
length_counts = {}
doubled_free = 0
wrap_free = 0
for arc_type in support_types:
    steps = arc_type_steps(arc_type)
    length = len(steps)
    length_counts[length] = length_counts.get(length, 0) + 1
    if not any(step_uses_doubled(step) for step in steps):
        doubled_free += 1
    if not any(step_uses_wrap(step) for step in steps):
        wrap_free += 1
print("KINDS: cycle=%d arc=%d" % (cycle_count, arc_count), flush=True)
print("LENGTHS: %s" % sorted(length_counts.items()), flush=True)
print("INTERIOR: doubled-free=%d wrap-free=%d of %d"
      % (doubled_free, wrap_free, len(support_types)), flush=True)

# 型の種数と核の次元は先行検算の観測（型 10,098・階数 6,799）と一致すること。
assert len(all_types) == 10098
assert len(kernel_basis) == 10098 - 6799

# 観測（2026-09-05 実行）を固定する。核基底の順序は決定的なので縮約結果も再現する。
assert raw_weight == 2904
assert sparse_weight == 2519
assert cycle_count == 87
assert arc_count == 2432
assert sorted(length_counts.items()) == [
    (1, 222), (2, 447), (3, 510), (4, 531), (5, 256), (6, 340), (7, 90), (8, 123)]
assert doubled_free == 79
assert wrap_free == 20

print("PASS: orient_d 署名の合同線型系の解の支持台を核ベクトルで縮約し、"
      "支持台の種別・語長分布・内部頂点の D 所属と切断旗の関与を固定した。")
