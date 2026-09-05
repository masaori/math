"""語長 1 の弧型の値を書く二次式の解を一つ構成し、係数の形を読む。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-length-one-existence で、語長 1 の
制限が特徴ビットの二次式になる解が orient_d 合同系の解空間に存在すると確定した。
ここでは解の取り方に依存しない形でその二次式を一つ構成する。すなわち、
係数座標へ射影した核の既約階段基底で特殊解の係数部分を消去した正準代表を取り、
併せて、核のどのベクトルも動かさない「強制された係数」を数える。さらに、
正準代表の二次式が定める語長 1 の弧型の値を合同系へ代入して残りが可解である
ことを確かめる（二次式が解空間の実際の解の制限であることの直接検証）。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution/construction.sage")


compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, system_vector = \
    build_orient_d_congruence_system(compressor)

# 先行検算で固定した合同系と一致すること（型 10,098・階数 6,799・可解）。
system_matrix = matrix(GF(2), len(joint_keys), len(all_types), entries)
assert len(all_types) == 10098
assert system_matrix.rank() == 6799
system_matrix.solve_right(system_vector)

length_one_types = [arc_type for arc_type in all_types
                    if len(arc_type_steps(arc_type)) == 1]
assert len(length_one_types) == 1249
length_one_columns = [column_index[arc_type] for arc_type in length_one_types]

feature_rows = [length_one_feature_bits(arc_type)
                for arc_type in length_one_types]
linear_names = length_one_feature_names()
assert len(linear_names) == 44
assert all(len(features) == len(linear_names) for features in feature_rows)

deg2_rows = [degree_two_features(features) for features in feature_rows]
deg2_names = degree_two_feature_names(linear_names)
assert len(deg2_names) == 990
assert len(deg2_rows[0]) == 990

deg2_matrix, deg2_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_one_columns, deg2_rows)
assert (deg2_matrix.ncols(), deg2_matrix.rank()) == (11089, 8020)

coefficient_start = len(all_types)
kernel_dimension, projected_dimension, forced, canonical = \
    coefficient_coset_analysis(deg2_matrix, deg2_rhs, coefficient_start)
print("KERNEL: dim=%d projected_dim=%d forced=%d"
      % (kernel_dimension, projected_dimension, len(forced)), flush=True)

# 係数座標の並びは「定数項、一次 44、相異なる積 946」。
constant_term = canonical[0]
linear_support = [index for index in range(44) if canonical[1 + index] == 1]
quadratic_support = [index for index in range(946) if canonical[45 + index] == 1]
print("CANONICAL: constant=%s linear_weight=%d quadratic_weight=%d"
      % (constant_term, len(linear_support), len(quadratic_support)),
      flush=True)
print("CANONICAL linear terms: %s"
      % ", ".join(linear_names[index] for index in linear_support), flush=True)


def feature_segment(index):
    if index < 12:
        return "step"
    if index < 28:
        return "end0"
    return "end1"


pair_index_to_features = []
for first in range(44):
    for second in range(first + 1, 44):
        pair_index_to_features.append((first, second))
assert len(pair_index_to_features) == 946

segment_pair_counts = {}
for index in quadratic_support:
    first, second = pair_index_to_features[index]
    key = tuple(sorted((feature_segment(first), feature_segment(second))))
    segment_pair_counts[key] = segment_pair_counts.get(key, 0) + 1
print("CANONICAL quadratic segment pairs: %s"
      % sorted(segment_pair_counts.items()), flush=True)
if len(quadratic_support) <= 80:
    print("CANONICAL quadratic terms: %s"
          % ", ".join(deg2_names[44 + index] for index in quadratic_support),
          flush=True)

# 強制された係数（解空間の全ての解で共通の係数）。
forced_nonzero = sorted(index for index in forced if canonical[index] == 1)
print("FORCED: count=%d nonzero=%d" % (len(forced), len(forced_nonzero)),
      flush=True)
if len(forced_nonzero) <= 80:
    forced_labels = []
    for index in forced_nonzero:
        if index == 0:
            forced_labels.append("constant")
        elif index <= 44:
            forced_labels.append(linear_names[index - 1])
        else:
            forced_labels.append(deg2_names[index - 1])
    print("FORCED nonzero terms: %s" % ", ".join(forced_labels), flush=True)

# 正準代表の二次式が定める語長 1 の値を合同系へ代入し、残りが可解であること。
assigned_values = {}
for column, features in zip(length_one_columns, deg2_rows):
    value = canonical[0]
    for feature_index, bit in enumerate(features):
        if bit % 2 == 1:
            value += canonical[1 + feature_index]
    assigned_values[column] = value
length_one_column_set = set(length_one_columns)
free_columns = [column for column in range(len(all_types))
                if column not in length_one_column_set]
free_position = {column: position
                 for position, column in enumerate(free_columns)}
restricted_entries = {}
adjusted_rhs = list(system_vector)
for (row_index, column), value in entries.items():
    if column in length_one_column_set:
        adjusted_rhs[row_index] += assigned_values[column]
    else:
        restricted_entries[(row_index, free_position[column])] = value
restricted_matrix = matrix(
    GF(2), len(joint_keys), len(free_columns), restricted_entries)
restricted_matrix.solve_right(vector(GF(2), adjusted_rhs))
print("SUBSTITUTION: solvable=True", flush=True)

# 観測（2026-09-05 実行）を固定する。正準代表は剰余類（＝解空間）だけで決まる
# ので、特殊解や核基底の取り方に依存しない。
assert (kernel_dimension, projected_dimension, len(forced)) == (3069, 946, 0)
assert (ZZ(constant_term), len(linear_support), len(quadratic_support)) \
    == (0, 0, 16)
assert len(forced_nonzero) == 0
assert sorted(segment_pair_counts.items()) == \
    [(("end1", "end1"), 10), (("end1", "step"), 6)]
assert [deg2_names[44 + index] for index in quadratic_support] == [
    "step_wrap_rowlast*end1_wrap_col0",
    "step_wrap_rowlast*end1_wrap_collast",
    "step_wrap_collast*end1_wrap_collast",
    "step_d_down*end1_wrap_collast",
    "step_d_right*end1_wrap_col0",
    "step_d_right*end1_wrap_collast",
    "end1_e_left*end1_wrap_collast",
    "end1_c_left*end1_wrap_col0",
    "end1_d_right*end1_wrap_rowlast",
    "end1_d_right*end1_wrap_col0",
    "end1_e_right*end1_wrap_rowlast",
    "end1_e_right*end1_wrap_col0",
    "end1_c_right*end1_wrap_rowlast",
    "end1_wrap_row0*end1_wrap_collast",
    "end1_wrap_rowlast*end1_wrap_col0",
    "end1_wrap_rowlast*end1_wrap_collast",
]

print("PASS: 語長 1 の弧型の値を書く二次式の正準代表を構成し、"
      "係数の形と、合同系への代入の可解性を固定した。")
