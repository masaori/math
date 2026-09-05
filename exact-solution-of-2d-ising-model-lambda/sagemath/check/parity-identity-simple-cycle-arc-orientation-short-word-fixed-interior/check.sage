"""既存 7,085 鍵の短い三語長へ同時に非切断項を固定する有限判定。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。
"""
print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-short-word-fixed-interior/construction.sage")

print("LOAD: finite key data ready", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
system, system_rhs, blocks = short_word_fixed_interior_system(entries, rhs, all_types, column_index)
assert system.dimensions() == (12220, 12458)
assert tuple(len(blocks[n][0]) for n in (1, 2, 3)) == (1249, 1842, 2044)
assert tuple(len(blocks[n][2]) for n in (1, 2, 3)) == (450, 760, 1150)
assert system[:len(rhs), :len(all_types)] == matrix(GF(2), len(rhs), len(all_types), entries)
assert system[:len(rhs), len(all_types):].is_zero()
assert system_rhs[:len(rhs)] == rhs
row_index = len(rhs)
for length, (types, names, pairs, start) in blocks.items():
    # 名前で作った列を、署名の固定ビット位置から独立に照合する。
    wrap = {12 * k + i for k in range(length) for i in range(4, 8)}
    wrap.update(12 * length + 16 * end + i for end in range(2) for i in range(12, 16))
    assert pairs == tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names))
                          if i in wrap or j in wrap)
    for arc_type in types:
        bits = arc_feature_bits(arc_type)
        row = system.row(row_index)
        assert row[:len(all_types)].nonzero_positions() == [column_index[arc_type]]
        assert row[len(all_types):start].is_zero()
        assert row[start + len(pairs):].is_zero()
        assert row[start:start + len(pairs)] == vector(GF(2), [bits[i] * bits[j] for i, j in pairs])
        assert system_rhs[row_index] == GF(2)(sum(bits[12 * k] * bits[12 * k + 2] for k in range(length)))
        row_index += 1
assert row_index == system.nrows()
print("SYSTEM: rows=%d columns=%d" % system.dimensions(), flush=True)
rank = system.rank()
augmented_rank = system.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
print("RESULT: rank=%d augmented_rank=%d solvable=%s" % (rank, augmented_rank, solvable), flush=True)
assert (rank, augmented_rank, solvable) == (11612, 11613, False)
if solvable:
    solution = system.solve_right(system_rhs)
    assert system * solution == system_rhs
    values = {}
    for length, (types, names, pairs, start) in blocks.items():
        active = tuple(pair for index, pair in enumerate(pairs) if solution[start + index])
        for arc_type in types:
            bits = arc_feature_bits(arc_type)
            value = GF(2)(sum(bits[12 * k] * bits[12 * k + 2] for k in range(length))
                          + sum(bits[i] * bits[j] for i, j in active))
            assert value == solution[column_index[arc_type]]
            values[arc_type] = value
        print("WITNESS: length=%d wrap_terms=%d" % (length, len(active)), flush=True)
        print("COEFFICIENTS: length=%d pairs=%s" % (length, [(names[i], names[j]) for i, j in active]), flush=True)
    for side, doubled, single, target in joint_keys:
        value = GF(2)(0)
        for arc_type in compressed_arc_types(side, doubled, single, compressor):
            if arc_type[0] == "arc" and len(arc_type[1]) in blocks:
                value += values[arc_type]
            else:
                value += solution[column_index[arc_type]]
        assert value == target
    print("WITNESS: all 7085 keys reconstructed", flush=True)
else:
    obstruction = next(row for row in system.left_kernel_matrix().rows() if row * system_rhs == 1)
    assert (obstruction * system).is_zero()
    assert obstruction * system_rhs == 1
    import json
    with open("sagemath/check/parity-identity-simple-cycle-arc-orientation-short-word-fixed-interior/obstruction.json") as handle:
        saved = json.load(handle)
    indices = saved["key_indices"] + [len(rhs) + i for i in saved["constraint_indices"]]
    assert len(indices) == len(set(indices))
    assert all(0 <= i < system.nrows() for i in indices)
    certificate = vector(GF(2), [1 if i in set(indices) else 0 for i in range(system.nrows())])
    assert (certificate * system).is_zero()
    assert certificate * system_rhs == 1
    print("OBSTRUCTION: computed and saved left-kernel certificates verified; saved_keys=%d saved_constraints=%d" %
          (len(saved["key_indices"]), len(saved["constraint_indices"])), flush=True)
print("PASS: short-word fixed interior decision and certificate", flush=True)
