"""orient_d 署名の解の支持台を語長で層別し、語長 1 の弧型の値の規則を調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-support で、orient_d 署名の
合同 F_2 線型系の解を核ベクトルの貪欲な縮約で疎にすると、支持台は
2,519 弧型で語長 1 から 8 まで全域に分布する（語長 1 は 222 種）と確定した。
ここでは縮約した解（核基底の順序が決定的なので一意に再現する代表）を
語長 1 の弧型へ制限し、その値（支持台なら 1、外なら 0）が、単一ステップの
向き・切断旗・D 所属と両端点の完全署名のビットから、定数項つきの F_2
一次式（および相異なる二成分の積を加えた二次式）で書けるかを判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-rule/construction.sage")


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
sparse_solution = sparsify_by_kernel(solution, kernel_basis)
assert system_matrix * sparse_solution == system_vector

# 先行検算で固定した縮約結果と一致すること（型 10,098・支持台 2,519）。
assert len(all_types) == 10098
assert sparse_solution.hamming_weight() == 2519

# 語長 1 の弧型の全体（分母集合）と、その中の支持台。
length_one_types = [arc_type for arc_type in all_types
                    if len(arc_type_steps(arc_type)) == 1]
cycle_length_one = sum(1 for arc_type in length_one_types
                       if arc_type[0] == "cycle")
support_length_one = sum(
    1 for arc_type in length_one_types
    if sparse_solution[column_index[arc_type]] != 0)
print("LENGTH-ONE: total=%d cycle=%d support=%d"
      % (len(length_one_types), cycle_length_one, support_length_one),
      flush=True)

# 語長 1 の閉路型は存在しない（単純閉路の頂点語は閉路の全頂点なので長さ 4 以上）。
assert cycle_length_one == 0

feature_rows = [length_one_feature_bits(arc_type)
                for arc_type in length_one_types]
feature_count = len(feature_rows[0])
assert all(len(features) == feature_count for features in feature_rows)
values = [sparse_solution[column_index[arc_type]]
          for arc_type in length_one_types]

deg1_collisions, deg1_rank, deg1_solvable = affine_f2_fit(feature_rows, values)
print("DEG1: features=%d collisions=%d rank=%d solvable=%s"
      % (feature_count, deg1_collisions, deg1_rank, deg1_solvable), flush=True)

deg2_rows = [degree_two_features(features) for features in feature_rows]
deg2_collisions, deg2_rank, deg2_solvable = affine_f2_fit(deg2_rows, values)
print("DEG2: features=%d collisions=%d rank=%d solvable=%s"
      % (len(deg2_rows[0]), deg2_collisions, deg2_rank, deg2_solvable),
      flush=True)

# 観測（2026-09-05 実行）を固定する。縮約代表は決定的なので再現する。
assert len(length_one_types) == 1249
assert support_length_one == 222
assert feature_count == 44
assert (deg1_collisions, deg1_rank, deg1_solvable) == (0, 37, False)
assert (deg2_collisions, deg2_rank, deg2_solvable) == (0, 439, False)

print("PASS: 語長 1 の弧型では直接衝突は無いが、縮約代表の値は特徴ビットの"
      "一次式でも二成分の積を加えた二次式でも書けないことを固定した。")
