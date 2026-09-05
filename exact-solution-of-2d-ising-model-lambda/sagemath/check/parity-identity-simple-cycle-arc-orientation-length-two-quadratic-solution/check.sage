"""語長 2 の弧型の値を書く低次式の存在と、二次式解の正準代表の形を読む。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution で、
語長 1 の弧型の値を書く二次式の正準代表が切断旗を含む二次単項式 16 個に
局在すると確定した。ここでは同じ正準化を語長 2 の弧型へ延ばす。すなわち、
二つのステップと両端点の 56 特徴ビットについて、語長 2 の制限が一次式・
二次式になる解の存在を代表を固定せず判定し、二次式が可解なら、係数座標へ
射影した核の既約階段基底で特殊解の係数部分を消去した正準代表（剰余類だけで
決まる）を取り、係数の形（切断旗への局在が語長を跨いで保たれるか）を読む。
併せて、正準代表の二次式が定める語長 2 の値を合同系へ代入して残りが可解で
あることを確かめる。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-quadratic-solution/construction.sage")


compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, system_vector = \
    build_orient_d_congruence_system(compressor)

# 先行検算で固定した合同系と一致すること（型 10,098・階数 6,799・可解）。
system_matrix = matrix(GF(2), len(joint_keys), len(all_types), entries)
assert len(all_types) == 10098
assert system_matrix.rank() == 6799
system_matrix.solve_right(system_vector)

length_two_arc_types = [arc_type for arc_type in all_types
                        if arc_type[0] == "arc"
                        and len(arc_type_steps(arc_type)) == 2]
length_two_cycle_types = [arc_type for arc_type in all_types
                          if arc_type[0] == "cycle"
                          and len(arc_type_steps(arc_type)) == 2]
print("LENGTH2: arcs=%d cycles=%d"
      % (len(length_two_arc_types), len(length_two_cycle_types)), flush=True)
length_two_columns = [column_index[arc_type]
                      for arc_type in length_two_arc_types]

feature_rows = [length_two_feature_bits(arc_type)
                for arc_type in length_two_arc_types]
linear_names = length_two_feature_names()
assert len(linear_names) == 56
assert all(len(features) == len(linear_names) for features in feature_rows)

# 一次式（定数項＋ 56 係数）になる解の存在。
linear_matrix, linear_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_two_columns, feature_rows)
try:
    linear_matrix.solve_right(linear_rhs)
    linear_solvable = True
except ValueError:
    linear_solvable = False
print("LINEAR: columns=%d rank=%d solvable=%s"
      % (linear_matrix.ncols(), linear_matrix.rank(), linear_solvable),
      flush=True)

# 相異なる二成分の積 1,540 を加えた二次式になる解の存在。
deg2_rows = [degree_two_features(features) for features in feature_rows]
deg2_names = degree_two_feature_names(linear_names)
assert len(deg2_names) == 1596
assert len(deg2_rows[0]) == 1596
deg2_matrix, deg2_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_two_columns, deg2_rows)
try:
    deg2_matrix.solve_right(deg2_rhs)
    deg2_solvable = True
except ValueError:
    deg2_solvable = False
print("QUADRATIC: columns=%d rank=%d solvable=%s"
      % (deg2_matrix.ncols(), deg2_matrix.rank(), deg2_solvable), flush=True)
assert deg2_solvable

coefficient_start = len(all_types)
kernel_dimension, projected_dimension, forced, canonical = \
    coefficient_coset_analysis(deg2_matrix, deg2_rhs, coefficient_start)
print("KERNEL: dim=%d projected_dim=%d forced=%d"
      % (kernel_dimension, projected_dimension, len(forced)), flush=True)

# 係数座標の並びは「定数項、一次 56、相異なる積 1,540」。
constant_term = canonical[0]
linear_support = [index for index in range(56) if canonical[1 + index] == 1]
quadratic_support = [index for index in range(1540)
                     if canonical[57 + index] == 1]
print("CANONICAL: constant=%s linear_weight=%d quadratic_weight=%d"
      % (constant_term, len(linear_support), len(quadratic_support)),
      flush=True)
print("CANONICAL linear terms: %s"
      % ", ".join(linear_names[index] for index in linear_support), flush=True)

pair_index_to_features = []
for first in range(56):
    for second in range(first + 1, 56):
        pair_index_to_features.append((first, second))
assert len(pair_index_to_features) == 1540

wrap_involved = [index for index in quadratic_support
                 if "wrap" in linear_names[pair_index_to_features[index][0]]
                 or "wrap" in linear_names[pair_index_to_features[index][1]]]
print("CANONICAL quadratic wrap-involved: %d of %d"
      % (len(wrap_involved), len(quadratic_support)), flush=True)


def feature_segment(index):
    if index < 12:
        return "step0"
    if index < 24:
        return "step1"
    if index < 40:
        return "end0"
    return "end1"


segment_pair_counts = {}
for index in quadratic_support:
    first, second = pair_index_to_features[index]
    key = tuple(sorted((feature_segment(first), feature_segment(second))))
    segment_pair_counts[key] = segment_pair_counts.get(key, 0) + 1
print("CANONICAL quadratic segment pairs: %s"
      % sorted(segment_pair_counts.items()), flush=True)
if len(quadratic_support) <= 120:
    print("CANONICAL quadratic terms: %s"
          % ", ".join(deg2_names[56 + index] for index in quadratic_support),
          flush=True)

# 強制された係数（解空間の全ての解で共通の係数）。
forced_nonzero = sorted(index for index in forced if canonical[index] == 1)
print("FORCED: count=%d nonzero=%d" % (len(forced), len(forced_nonzero)),
      flush=True)

# 正準代表の二次式が定める語長 2 の値を合同系へ代入し、残りが可解であること。
assigned_values = {}
for column, features in zip(length_two_columns, deg2_rows):
    value = canonical[0]
    for feature_index, bit in enumerate(features):
        if bit % 2 == 1:
            value += canonical[1 + feature_index]
    assigned_values[column] = value
length_two_column_set = set(length_two_columns)
free_columns = [column for column in range(len(all_types))
                if column not in length_two_column_set]
free_position = {column: position
                 for position, column in enumerate(free_columns)}
restricted_entries = {}
adjusted_rhs = list(system_vector)
for (row_index, column), value in entries.items():
    if column in length_two_column_set:
        adjusted_rhs[row_index] += assigned_values[column]
    else:
        restricted_entries[(row_index, free_position[column])] = value
restricted_matrix = matrix(
    GF(2), len(joint_keys), len(free_columns), restricted_entries)
restricted_matrix.solve_right(vector(GF(2), adjusted_rhs))
print("SUBSTITUTION: solvable=True", flush=True)

# 観測（2026-09-05 実行）を固定する。正準代表は剰余類（＝解空間）だけで決まる
# ので、特殊解や核基底の取り方に依存しない。
assert (len(length_two_arc_types), len(length_two_cycle_types)) == (1842, 16)
assert (linear_matrix.ncols(), linear_solvable) == (10155, False)
assert linear_matrix.rank() == 8520
assert (deg2_matrix.ncols(), deg2_matrix.rank()) == (11695, 8622)
assert (kernel_dimension, projected_dimension, len(forced)) == (3073, 1468, 0)
assert (ZZ(constant_term), len(linear_support), len(quadratic_support)) \
    == (0, 0, 39)
assert len(forced_nonzero) == 0
# 語長 1 と違い、切断旗を含まない二次項が 14 個残る（局在は保たれない）。
assert len(wrap_involved) == 25
assert sorted(segment_pair_counts.items()) == \
    [(("end0", "end1"), 6), (("end0", "step1"), 5),
     (("end1", "end1"), 14), (("end1", "step1"), 14)]
assert [deg2_names[56 + index] for index in quadratic_support] == [
    "step1_d_up*end1_wrap_col0",
    "step1_d_up*end1_wrap_collast",
    "step1_d_down*end1_wrap_rowlast",
    "step1_d_down*end1_wrap_collast",
    "step1_d_left*end0_e_down",
    "step1_d_left*end0_e_right",
    "step1_d_left*end1_c_down",
    "step1_d_left*end1_e_right",
    "step1_d_left*end1_wrap_collast",
    "step1_d_right*end0_e_down",
    "step1_d_right*end0_e_right",
    "step1_d_right*end0_wrap_rowlast",
    "step1_d_right*end1_c_up",
    "step1_d_right*end1_e_down",
    "step1_d_right*end1_c_down",
    "step1_d_right*end1_d_left",
    "step1_d_right*end1_e_right",
    "step1_d_right*end1_wrap_rowlast",
    "step1_d_right*end1_wrap_collast",
    "end0_c_right*end1_wrap_row0",
    "end0_wrap_rowlast*end1_wrap_col0",
    "end0_wrap_col0*end1_e_left",
    "end0_wrap_col0*end1_wrap_rowlast",
    "end0_wrap_collast*end1_e_left",
    "end0_wrap_collast*end1_c_left",
    "end1_d_down*end1_wrap_collast",
    "end1_e_down*end1_d_left",
    "end1_e_down*end1_c_right",
    "end1_e_down*end1_wrap_row0",
    "end1_e_down*end1_wrap_rowlast",
    "end1_e_down*end1_wrap_col0",
    "end1_c_down*end1_wrap_row0",
    "end1_d_left*end1_wrap_col0",
    "end1_e_left*end1_wrap_rowlast",
    "end1_e_left*end1_wrap_collast",
    "end1_c_left*end1_d_right",
    "end1_c_left*end1_wrap_col0",
    "end1_d_right*end1_wrap_collast",
    "end1_e_right*end1_wrap_collast",
]

print("PASS: 語長 2 の弧型の値を書く低次式の存在判定と、"
      "二次式解の正準代表の係数の形、合同系への代入の可解性を確認した。")
