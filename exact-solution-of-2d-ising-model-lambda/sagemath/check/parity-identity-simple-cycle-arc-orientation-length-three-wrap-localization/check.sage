"""語長三だけの切断旗局在を、既存の一辺二・三の有限データで判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
語長一・二を含む他の弧型と閉路型の値は自由未知数のまま残す。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
system_matrix, system_rhs, blocks = joint_localized_system(
    entries, rhs, all_types, column_index, (3,))
assert set(blocks) == {3}
types, names, pairs, start = blocks[3]
assert (len(types), len(names), len(pairs), start) == (2044, 68, 1150, 10098)
assert system_matrix.dimensions() == (9129, 11248)
# 上流の合同系の行・右辺は変えず、語長三の値＝局在式だけを追加したことを確かめる。
assert system_matrix[:len(rhs), :len(all_types)] == matrix(
    GF(2), len(rhs), len(all_types), entries)
assert system_matrix[:len(rhs), len(all_types):].is_zero()
assert system_rhs[:len(rhs)] == rhs
assert system_rhs[len(rhs):].is_zero()
for offset, arc_type in enumerate(types):
    row = system_matrix.row(len(rhs) + offset)
    assert row[:len(all_types)].nonzero_positions() == [column_index[arc_type]]
    bits = arc_feature_bits(arc_type)
    assert row[start:] == vector(GF(2), [bits[i] * bits[j] for i, j in pairs])

print("SYSTEM: rows=%d columns=%d" % system_matrix.dimensions(), flush=True)
rank = system_matrix.rank()
augmented_rank = system_matrix.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
print("RESULT: rank=%d augmented_rank=%d solvable=%s"
      % (rank, augmented_rank, solvable), flush=True)
# 2026-09-05 の有限探索の結論を固定する。非可解性は下の矛盾証拠でも照合する。
assert (rank, augmented_rank, solvable) == (8816, 8817, False)

if solvable:
    solution = system_matrix.solve_right(system_rhs)
    assert system_matrix * solution == system_rhs
    # 行列の残差とは別に、各鍵の弧を再生成して局在式と自由な値の和を照合する。
    for side, doubled, single, term in joint_keys:
        total = GF(2)(0)
        for arc_type in compressed_arc_types(side, doubled, single, compressor):
            if arc_type[0] == "arc" and len(arc_type[1]) == 3:
                bits = arc_feature_bits(arc_type)
                value = sum((solution[start + offset] * bits[i] * bits[j]
                             for offset, (i, j) in enumerate(pairs)), GF(2)(0))
                assert value == solution[column_index[arc_type]]
            else:
                value = solution[column_index[arc_type]]
            total += value
        assert total == term
    print("WITNESS: all 7085 key values reconstructed", flush=True)
else:
    left_kernel = system_matrix.left_kernel_matrix()
    obstruction = next(row for row in left_kernel.rows() if row * system_rhs == 1)
    assert (obstruction * system_matrix).is_zero()
    assert obstruction * system_rhs == 1
    print("OBSTRUCTION: left-kernel certificate verified; key_rows=%d arc_rows=%d"
          % (len(obstruction[:len(rhs)].nonzero_positions()),
             len(obstruction[len(rhs):].nonzero_positions())), flush=True)
    print("CERTIFICATE: key_indices=%s arc_indices=%s"
          % (obstruction[:len(rhs)].nonzero_positions(),
             obstruction[len(rhs):].nonzero_positions()), flush=True)

print("PASS: finite length-three-only localization determination checked", flush=True)
