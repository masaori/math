"""語長三の弧型の値を、局在を要求しない二次式で書けるか判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一辺二・三の既存鍵だけの有限探索。他の語長と閉路型の値は自由未知数。
"""

print("LOAD: constructing the existing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")

compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
types = tuple(t for t in all_types if t[0] == "arc" and len(t[1]) == 3)
names = arc_feature_names(3)
pairs = tuple((i, j) for i in range(len(names))
              for j in range(i + 1, len(names)))
assert (len(types), len(names), len(pairs)) == (2044, 68, 2278)
bits_by_type = [arc_feature_bits(t) for t in types]
features = [degree_two_features(bits) for bits in bits_by_type]
assert all(len(bits) == 68 for bits in bits_by_type)
assert all(len(row) == 2346 for row in features)
start = len(all_types)
system_matrix, system_rhs = augmented_low_degree_system(
    entries, len(rhs), start, rhs,
    [column_index[t] for t in types], features)
assert system_matrix.dimensions() == (9129, 12445)
assert system_matrix[:len(rhs), :start] == matrix(GF(2), len(rhs), start, entries)
assert system_matrix[:len(rhs), start:].is_zero()
assert system_rhs[:len(rhs)] == rhs
assert system_rhs[len(rhs):].is_zero()
for offset, arc_type in enumerate(types):
    row = system_matrix.row(len(rhs) + offset)
    assert row[:start].nonzero_positions() == [column_index[arc_type]]
    bits = bits_by_type[offset]
    expected = (1,) + bits + tuple(bits[i] * bits[j] for i, j in pairs)
    assert row[start:] == vector(GF(2), expected)

print("SYSTEM: rows=%d columns=%d" % system_matrix.dimensions(), flush=True)
rank = system_matrix.rank()
augmented_rank = system_matrix.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
print("RESULT: rank=%d augmented_rank=%d solvable=%s"
      % (rank, augmented_rank, solvable), flush=True)
# 初回の厳密計算で得た存在判定を固定する。
assert (rank, augmented_rank, solvable) == (8828, 8828, True)

if solvable:
    solution = system_matrix.solve_right(system_rhs)
    assert system_matrix * solution == system_rhs
    # 行列構成とは別に、各鍵の弧を再生成し、係数から値の和を復元する。
    for side, doubled, single, term in joint_keys:
        total = GF(2)(0)
        for arc_type in compressed_arc_types(side, doubled, single, compressor):
            if arc_type[0] == "arc" and len(arc_type[1]) == 3:
                bits = arc_feature_bits(arc_type)
                value = solution[start]
                value += sum((solution[start + 1 + i] * bit
                              for i, bit in enumerate(bits)), GF(2)(0))
                value += sum((solution[start + 1 + len(bits) + offset] * bits[i] * bits[j]
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

print("PASS: finite length-three unrestricted quadratic determination checked", flush=True)
