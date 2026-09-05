"""一辺二・三の既存 7,085 鍵で、語長一・二・三の同時局在を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長や語長についての主張ではない。有限集合と F_2 の厳密演算を用いる。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
# 語長一・二では、拡張した特徴抽出が従来の抽出と各弧型で完全に一致する。
for arc_type in all_types:
    if arc_type[0] == "arc" and len(arc_type[1]) == 1:
        assert arc_feature_bits(arc_type) == length_one_feature_bits(arc_type)
    if arc_type[0] == "arc" and len(arc_type[1]) == 2:
        assert arc_feature_bits(arc_type) == length_two_feature_bits(arc_type)
assert arc_feature_names(2) == length_two_feature_names()
assert arc_feature_names(1) == tuple(
    name.replace("step_", "step0_") for name in length_one_feature_names())

system_matrix, system_rhs, blocks = joint_localized_system(
    entries, rhs, all_types, column_index, (1, 2, 3))
assert len(blocks[1][0]) == 1249
assert len(blocks[2][0]) == 1842
assert tuple(len(blocks[length][1]) for length in (1, 2, 3)) == (44, 56, 68)
assert tuple(len(blocks[length][2]) for length in (1, 2, 3)) == (450, 760, 1150)
for length, (types, names, pairs, start) in blocks.items():
    print("BLOCK: length=%d types=%d bits=%d localized_pairs=%d"
          % (length, len(types), len(names), len(pairs)), flush=True)
print("SYSTEM: rows=%d columns=%d" % system_matrix.dimensions(), flush=True)
rank = system_matrix.rank()
augmented_rank = system_matrix.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
print("RESULT: rank=%d augmented_rank=%d solvable=%s"
      % (rank, augmented_rank, solvable), flush=True)

if solvable:
    solution = system_matrix.solve_right(system_rhs)
    assert system_matrix * solution == system_rhs
    # 行列を再利用せず、得た式と自由な弧型の値から全鍵の頂点項を再構成する。
    reconstructed = []
    for side, doubled, single, term in joint_keys:
        total = GF(2)(0)
        for arc_type in compressed_arc_types(side, doubled, single, compressor):
            if arc_type[0] == "arc" and len(arc_type[1]) in blocks:
                _, _, pairs, start = blocks[len(arc_type[1])]
                bits = arc_feature_bits(arc_type)
                value = sum((solution[start + offset] * bits[first] * bits[second]
                             for offset, (first, second) in enumerate(pairs)), GF(2)(0))
                assert value == solution[column_index[arc_type]]
            else:
                value = solution[column_index[arc_type]]
            total += value
        assert total == term
        reconstructed.append(total)
    assert vector(GF(2), reconstructed) == rhs
    print("WITNESS: all %d key values reconstructed" % len(reconstructed), flush=True)
else:
    # 不存在の場合も、右辺と非直交な左核ベクトルを証拠として確かめる。
    left_kernel = system_matrix.left_kernel_matrix()
    obstruction = next(row for row in left_kernel.rows() if row * system_rhs != 0)
    assert (obstruction * system_matrix).is_zero()
    assert obstruction * system_rhs == 1
    print("OBSTRUCTION: left-kernel certificate verified", flush=True)

# 2026-09-05 の観測を固定する。非可解性は上の左核の証拠でも確認する。
assert len(blocks[3][0]) == 2044
assert system_matrix.dimensions() == (12220, 12458)
assert (rank, augmented_rank, solvable) == (11612, 11613, False)

print("PASS: finite joint localization determination checked", flush=True)
