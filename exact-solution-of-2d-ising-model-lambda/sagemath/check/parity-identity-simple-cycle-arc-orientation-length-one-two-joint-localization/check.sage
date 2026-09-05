"""語長 1 と語長 2 の切断旗局在の拘束を同時に課した単一の解の存在判定。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution と
parity-identity-simple-cycle-arc-orientation-length-two-wrap-localization で、
語長 1・語長 2 のそれぞれについては「弧型の値が、定数項 0・一次項 0・
切断旗を含む二次単項式だけの和で書ける」解が orient_d 合同系の解空間に
存在すると確定した。ただし判定は語長ごとに別々で、同じ一つの解が両方の
局在形を同時に満たすかは未判定である。ここでは弧型ごとの値と両語長の
式の係数を同時に未知数とする単一の連立 F_2 線型系（orient_d 合同系＋
語長 1 の各弧型での「値＝二次式」の等式＋語長 2 の各弧型での同じ等式）に、
両ブロックの定数項・一次係数・切断旗非関与の二次係数を全て 0 に固定する
拘束行を積み、可解かどうかを判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-two-joint-localization/construction.sage")


compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, system_vector = \
    build_orient_d_congruence_system(compressor)
assert len(all_types) == 10098

length_one_types = [arc_type for arc_type in all_types
                    if arc_type[0] == "arc"
                    and len(arc_type_steps(arc_type)) == 1]
assert len(length_one_types) == 1249
length_two_types = [arc_type for arc_type in all_types
                    if arc_type[0] == "arc"
                    and len(arc_type_steps(arc_type)) == 2]
assert len(length_two_types) == 1842

one_names = length_one_feature_names()
assert len(one_names) == 44
one_deg2_rows = [degree_two_features(length_one_feature_bits(arc_type))
                 for arc_type in length_one_types]
assert len(one_deg2_rows[0]) == 990
two_names = length_two_feature_names()
assert len(two_names) == 56
two_deg2_rows = [degree_two_features(length_two_feature_bits(arc_type))
                 for arc_type in length_two_types]
assert len(two_deg2_rows[0]) == 1596

joint_matrix, joint_rhs, block_starts = augmented_two_block_low_degree_system(
    entries, len(joint_keys), len(all_types), system_vector,
    (([column_index[arc_type] for arc_type in length_one_types],
      one_deg2_rows),
     ([column_index[arc_type] for arc_type in length_two_types],
      two_deg2_rows)))
one_start, two_start = block_starts
assert one_start == len(all_types)
assert two_start == one_start + 1 + 990
assert joint_matrix.ncols() == 12686
print("SYSTEM: rows=%d columns=%d"
      % (joint_matrix.nrows(), joint_matrix.ncols()), flush=True)

one_non_wrap = non_wrap_pair_indices(one_names)
two_non_wrap = non_wrap_pair_indices(two_names)
print("NONWRAP: length-one pairs=%d of 946, length-two pairs=%d of 1540"
      % (len(one_non_wrap), len(two_non_wrap)), flush=True)

# 両ブロックの定数項・一次係数・切断旗非関与の二次係数を全て 0 に固定する。
shape_columns = (
    [one_start] + [one_start + 1 + index for index in range(44)]
    + [one_start + 1 + 44 + index for index in one_non_wrap]
    + [two_start] + [two_start + 1 + index for index in range(56)]
    + [two_start + 1 + 56 + index for index in two_non_wrap])
shape_matrix, shape_rhs = stack_zero_coefficient_constraints(
    joint_matrix, joint_rhs, shape_columns)
try:
    shape_matrix.solve_right(shape_rhs)
    shape_solvable = True
except ValueError:
    shape_solvable = False
print("JOINT SHAPE: rows=%d rank=%d solvable=%s"
      % (shape_matrix.nrows(), shape_matrix.rank(), shape_solvable),
      flush=True)

if shape_solvable:
    kernel_dimension, projected_dimension, forced, canonical = \
        coefficient_coset_analysis(shape_matrix, shape_rhs, len(all_types))
    print("JOINT KERNEL: dim=%d projected_dim=%d forced=%d"
          % (kernel_dimension, projected_dimension, len(forced)), flush=True)
    one_constant = canonical[0]
    one_linear = [index for index in range(44) if canonical[1 + index] == 1]
    one_quadratic = [index for index in range(946)
                     if canonical[45 + index] == 1]
    two_offset = 1 + 990
    two_constant = canonical[two_offset]
    two_linear = [index for index in range(56)
                  if canonical[two_offset + 1 + index] == 1]
    two_quadratic = [index for index in range(1540)
                     if canonical[two_offset + 57 + index] == 1]
    print("CANONICAL length-one: constant=%s linear_weight=%d "
          "quadratic_weight=%d" % (one_constant, len(one_linear),
                                   len(one_quadratic)), flush=True)
    print("CANONICAL length-two: constant=%s linear_weight=%d "
          "quadratic_weight=%d" % (two_constant, len(two_linear),
                                   len(two_quadratic)), flush=True)
    one_deg2_names = degree_two_feature_names(one_names)
    two_deg2_names = degree_two_feature_names(two_names)
    one_leaked = [index for index in one_quadratic
                  if index in set(one_non_wrap)]
    two_leaked = [index for index in two_quadratic
                  if index in set(two_non_wrap)]
    print("CANONICAL length-one quadratic terms: %s"
          % ", ".join(one_deg2_names[44 + index] for index in one_quadratic),
          flush=True)
    print("CANONICAL length-two quadratic terms: %s"
          % ", ".join(two_deg2_names[56 + index] for index in two_quadratic),
          flush=True)
    print("CANONICAL leaked non-wrap terms: length-one=%d length-two=%d"
          % (len(one_leaked), len(two_leaked)), flush=True)

# 観測（2026-09-05 実行）を固定する。
assert len(one_non_wrap) == 496
assert len(two_non_wrap) == 780
assert joint_matrix.nrows() == 10176
assert shape_matrix.nrows() == 11554
assert shape_solvable
assert shape_matrix.rank() == 11194
assert (kernel_dimension, projected_dimension, len(forced)) \
    == (1492, 784, 1378)
# 強制された係数座標は 0 に固定した拘束座標にちょうど一致する
# （拘束の外に新たな強制は生じない）。
assert forced == {column - len(all_types) for column in shape_columns}
assert (ZZ(one_constant), len(one_linear), len(one_quadratic)) == (0, 0, 16)
assert (ZZ(two_constant), len(two_linear), len(two_quadratic)) == (0, 0, 184)
assert len(one_leaked) == 0
assert len(two_leaked) == 0
# 語長 2 の正準代表には step0 を含む項が現れる（単独の localized 正準代表では
# step0 を含む項が 0 個だったのと違い、語長 1 の拘束を同時に課すと核が縮み、
# 消去できる方向が減る）。

print("PASS: 語長 1 と語長 2 の切断旗局在の拘束を同時に課しても連立系は"
      "可解であり、両語長の弧型の値が同時に「切断旗を含む二次単項式だけの和」"
      "で書ける単一の解が存在する。")
