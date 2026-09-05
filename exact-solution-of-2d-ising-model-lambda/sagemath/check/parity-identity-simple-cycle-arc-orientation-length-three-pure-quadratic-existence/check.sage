"""語長三の値を相異なる二成分の積だけで書けるかの有限存在判定。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一辺二・三の既存鍵に限る。他の語長と閉路型の値は自由未知数。
定数項・一次項を零に固定し、平方も一次項と同じなので含めない。
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
start = len(all_types)
combined = dict(entries)
for offset, arc_type in enumerate(types):
    bits = arc_feature_bits(arc_type)
    assert len(bits) == len(names)
    row_index = len(rhs) + offset
    combined[(row_index, column_index[arc_type])] = GF(2)(1)
    for index, (i, j) in enumerate(pairs):
        if bits[i] * bits[j]:
            combined[(row_index, start + index)] = GF(2)(1)
system_matrix = matrix(GF(2), len(rhs) + len(types), start + len(pairs), combined)
system_rhs = vector(GF(2), list(rhs) + [0] * len(types))
assert system_matrix.dimensions() == (9129, 12376)
assert system_matrix[:len(rhs), :start] == matrix(GF(2), len(rhs), start, entries)
assert system_matrix[:len(rhs), start:].is_zero()
assert system_rhs[:len(rhs)] == rhs
assert system_rhs[len(rhs):].is_zero()
for offset, arc_type in enumerate(types):
    row = system_matrix.row(len(rhs) + offset)
    assert row[:start].nonzero_positions() == [column_index[arc_type]]
    bits = arc_feature_bits(arc_type)
    # 前回の全二次式から定数項と一次項の列だけを除いたことを照合する。
    previous_features = degree_two_features(bits)
    assert row[start:] == vector(GF(2), previous_features[len(names):])

print("SYSTEM: rows=%d columns=%d" % system_matrix.dimensions(), flush=True)
rank = system_matrix.rank()
augmented_rank = system_matrix.augment(system_rhs.column()).rank()
solvable = rank == augmented_rank
print("RESULT: rank=%d augmented_rank=%d solvable=%s"
      % (rank, augmented_rank, solvable), flush=True)
assert (rank, augmented_rank, solvable) == (8828, 8828, True)

if solvable:
    solution = system_matrix.solve_right(system_rhs)
    assert system_matrix * solution == system_rhs
    active_pairs = tuple(pairs[index] for index in range(len(pairs))
                         if solution[start + index] == 1)
    values = {}
    # 各弧型を式で評価する。行列の行を読み戻して値を決めない。
    for arc_type in types:
        bits = arc_feature_bits(arc_type)
        value = GF(2)(sum(bits[i] * bits[j] for i, j in active_pairs))
        assert value == solution[column_index[arc_type]]
        values[arc_type] = value
    for side, doubled, single, term in joint_keys:
        total = GF(2)(0)
        for arc_type in compressed_arc_types(side, doubled, single, compressor):
            if arc_type[0] == "arc" and len(arc_type[1]) == 3:
                value = values[arc_type]
            else:
                value = solution[column_index[arc_type]]
            total += value
        assert total == term
    wrap_count = sum("wrap" in names[i] or "wrap" in names[j] for i, j in active_pairs)
    # 前回の局在系は非可解なので、得た解にも非局在の項が必要である。
    assert wrap_count < len(active_pairs)
    print("WITNESS: all 7085 key values reconstructed; quadratic_terms=%d wrap_terms=%d"
          % (len(active_pairs), wrap_count), flush=True)
else:
    left_kernel = system_matrix.left_kernel_matrix()
    obstruction = next(row for row in left_kernel.rows() if row * system_rhs == 1)
    assert (obstruction * system_matrix).is_zero()
    assert obstruction * system_rhs == 1
    print("OBSTRUCTION: left-kernel certificate verified; key_indices=%s arc_indices=%s"
          % (obstruction[:len(rhs)].nonzero_positions(),
             obstruction[len(rhs):].nonzero_positions()), flush=True)

print("PASS: finite length-three pure quadratic determination checked", flush=True)
