"""語長 1 の制限が低次式になる解が orient_d 合同系の解空間に存在するかを判定する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-length-one-rule では、核ベクトルの
貪欲な縮約で固定した一つの代表について、語長 1 の弧型の値が特徴ビットの
一次式でも二次式でも書けないと確定した。値は代表の取り方に依存するので、
ここでは代表を固定せず、弧型ごとの値と式の係数を同時に未知数とする連立
F_2 線型系（もとの合同系＋語長 1 の各弧型での「値＝定数項つき低次式」の等式）
が可解か、すなわち語長 1 の制限が低次式になる解が解空間に存在するかを判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-existence/construction.sage")


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
base_rank = system_matrix.rank()

# 先行検算で固定した合同系と一致すること（型 10,098・階数 6,799・可解）。
assert len(all_types) == 10098
assert base_rank == 6799
system_matrix.solve_right(system_vector)

length_one_types = [arc_type for arc_type in all_types
                    if len(arc_type_steps(arc_type)) == 1]
assert len(length_one_types) == 1249
length_one_columns = [column_index[arc_type] for arc_type in length_one_types]

feature_rows = [length_one_feature_bits(arc_type)
                for arc_type in length_one_types]
feature_count = len(feature_rows[0])
assert feature_count == 44
assert all(len(features) == feature_count for features in feature_rows)

# 一次式: 未知数は弧型の値 10,098 個＋定数項 1 個＋係数 44 個。
deg1_matrix, deg1_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_one_columns, feature_rows)
deg1_rank = deg1_matrix.rank()
try:
    deg1_matrix.solve_right(deg1_rhs)
    deg1_solvable = True
except ValueError:
    deg1_solvable = False
print("DEG1: unknowns=%d rank=%d solvable=%s"
      % (deg1_matrix.ncols(), deg1_rank, deg1_solvable), flush=True)

# 二次式: 一次の 44 成分に相異なる二成分の積 946 個を加えた 990 特徴。
deg2_rows = [degree_two_features(features) for features in feature_rows]
assert len(deg2_rows[0]) == 990
deg2_matrix, deg2_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_one_columns, deg2_rows)
deg2_rank = deg2_matrix.rank()
try:
    deg2_matrix.solve_right(deg2_rhs)
    deg2_solvable = True
except ValueError:
    deg2_solvable = False
print("DEG2: unknowns=%d rank=%d solvable=%s"
      % (deg2_matrix.ncols(), deg2_rank, deg2_solvable), flush=True)

# 観測（2026-09-05 実行）を固定する。
assert (deg1_matrix.ncols(), deg1_rank, deg1_solvable) == (10143, 7988, False)
assert (deg2_matrix.ncols(), deg2_rank, deg2_solvable) == (11089, 8020, True)

print("PASS: 語長 1 の制限が特徴ビットの一次式になる解は解空間に存在しないが、"
      "二成分の積を加えた二次式になる解は存在することを固定した。")
