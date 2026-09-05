"""語長 2 の二次式解で、切断旗非関与の二次項を消せる解が存在するかの判定。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-length-two-quadratic-solution で、
語長 2 の二次式解の正準代表は二次項 39 個のうち 14 個が切断旗非関与であり、
語長 1 で見えた切断旗への完全な局在は保たれないと確定した。ただし正準代表は
剰余類ごとに一意なだけで、局在性を最適化する構成ではない。ここでは代表を
固定せず、解空間の側で判定する。すなわち連立 F_2 線型系（orient_d 合同系＋
語長 2 の各弧型での「値＝二次式」の等式）に、切断旗非関与の二次係数を 0 に
固定する拘束行を積み、可解かどうかを見る。可解なら局在の破れは正準化の
副作用であり、非可解なら解空間そのものの障害である。併せて、語長 1 の
正準代表と同じ形（定数項 0・一次項 0・切断旗関与の二次項のみ）の解の存在も
判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-wrap-localization/construction.sage")


compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, system_vector = \
    build_orient_d_congruence_system(compressor)
assert len(all_types) == 10098

length_two_arc_types = [arc_type for arc_type in all_types
                        if arc_type[0] == "arc"
                        and len(arc_type_steps(arc_type)) == 2]
assert len(length_two_arc_types) == 1842
length_two_columns = [column_index[arc_type]
                      for arc_type in length_two_arc_types]

feature_rows = [length_two_feature_bits(arc_type)
                for arc_type in length_two_arc_types]
linear_names = length_two_feature_names()
assert len(linear_names) == 56
deg2_rows = [degree_two_features(features) for features in feature_rows]
deg2_names = degree_two_feature_names(linear_names)
assert len(deg2_names) == 1596

deg2_matrix, deg2_rhs = augmented_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    length_two_columns, deg2_rows)
assert deg2_matrix.ncols() == 11695
print("SYSTEM: rows=%d columns=%d" % (deg2_matrix.nrows(), deg2_matrix.ncols()),
      flush=True)

# 係数座標の並びは「定数項、一次 56、相異なる積 1,540」。
coefficient_start = len(all_types)
constant_column = coefficient_start
linear_columns = [coefficient_start + 1 + index for index in range(56)]
pair_column_start = coefficient_start + 1 + 56

non_wrap_pairs = non_wrap_pair_indices(linear_names)
print("NONWRAP: pairs=%d of 1540" % len(non_wrap_pairs), flush=True)

# 判定その一: 切断旗非関与の二次係数を全て 0 に固定した系の可解性。
non_wrap_columns = [pair_column_start + index for index in non_wrap_pairs]
localized_matrix, localized_rhs = stack_zero_coefficient_constraints(
    deg2_matrix, deg2_rhs, non_wrap_columns)
try:
    localized_matrix.solve_right(localized_rhs)
    localized_solvable = True
except ValueError:
    localized_solvable = False
print("LOCALIZED: rank=%d solvable=%s"
      % (localized_matrix.rank(), localized_solvable), flush=True)

if localized_solvable:
    kernel_dimension, projected_dimension, forced, canonical = \
        coefficient_coset_analysis(
            localized_matrix, localized_rhs, coefficient_start)
    print("LOCALIZED KERNEL: dim=%d projected_dim=%d forced=%d"
          % (kernel_dimension, projected_dimension, len(forced)), flush=True)
    constant_term = canonical[0]
    linear_support = [index for index in range(56)
                      if canonical[1 + index] == 1]
    quadratic_support = [index for index in range(1540)
                         if canonical[57 + index] == 1]
    print("LOCALIZED CANONICAL: constant=%s linear_weight=%d "
          "quadratic_weight=%d"
          % (constant_term, len(linear_support), len(quadratic_support)),
          flush=True)
    non_wrap_pair_set = set(non_wrap_pairs)
    leaked = [index for index in quadratic_support
              if index in non_wrap_pair_set]
    print("LOCALIZED CANONICAL quadratic terms: %s"
          % ", ".join(deg2_names[56 + index] for index in quadratic_support),
          flush=True)
    print("LOCALIZED CANONICAL leaked non-wrap terms: %d" % len(leaked),
          flush=True)

# 判定その二: 語長 1 の正準代表と同じ形（定数項 0・一次項 0・切断旗関与の
# 二次項のみ）の解の存在。
shape_columns = [constant_column] + linear_columns + non_wrap_columns
shape_matrix, shape_rhs = stack_zero_coefficient_constraints(
    deg2_matrix, deg2_rhs, shape_columns)
try:
    shape_matrix.solve_right(shape_rhs)
    shape_solvable = True
except ValueError:
    shape_solvable = False
print("SHAPE: rank=%d solvable=%s" % (shape_matrix.rank(), shape_solvable),
      flush=True)

# 観測（2026-09-05 実行）を固定する。
assert len(non_wrap_pairs) == 780
assert localized_solvable
assert localized_matrix.rank() == 9390
assert (kernel_dimension, projected_dimension, len(forced)) == (2305, 700, 780)
# 強制された係数座標は、0 に固定した切断旗非関与の積の座標にちょうど一致する
# （拘束の外に新たな強制は生じない）。
assert forced == {57 + index for index in non_wrap_pairs}
assert (ZZ(constant_term), len(linear_support), len(quadratic_support)) \
    == (0, 0, 52)
assert len(leaked) == 0
# 正準代表の二次項は反転正準化の後側に偏り、第一ステップ（step0）を含む項は無い。
assert all("step0" not in deg2_names[56 + index]
           for index in quadratic_support)
assert shape_matrix.rank() == 9447
assert shape_solvable

print("PASS: 切断旗非関与の二次係数を全て 0 に固定しても連立系は可解であり、"
      "語長 2 の局在の破れは解空間の障害ではなく正準化の副作用である。"
      "語長 1 と同じ形（定数項 0・一次項 0・切断旗関与の二次項のみ）の解も"
      "存在する。")
