"""先頭語位置・先頭端点間の16項を、単一辺所属がある側で8項ずつに分ける有限判定。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。
"""
print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-end0-membership-direction-split/construction.sage")

print("LOAD: finite key data ready", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098

import json
import sys
from pathlib import Path

record = "--record" in sys.argv
certificate_path = Path("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-step0-end0-membership-direction-split/certificate.json")
saved = {} if record else json.loads(certificate_path.read_text())
observed_all = {}

for single_at in ("step0", "end0"):
    print("VARIANT: single membership at %s" % single_at, flush=True)
    system, system_rhs, blocks = length_two_step0_end0_membership_direction_system(
        entries, rhs, all_types, column_index, single_at)
    assert system.dimensions() == (12220, 13362)
    assert tuple(len(blocks[n][0]) for n in (1, 2, 3)) == (1249, 1842, 2044)
    assert tuple(len(blocks[n][2]) for n in (1, 2, 3)) == (946, 1168, 1150)
    assert system[:len(rhs), :len(all_types)] == matrix(GF(2), len(rhs), len(all_types), entries)
    assert system[:len(rhs), len(all_types):].is_zero()
    assert system_rhs[:len(rhs)] == rhs
    row_index = len(rhs)
    for length, (types, names, pairs, start) in blocks.items():
        wrap = {12 * k + i for k in range(length) for i in range(4, 8)}
        wrap.update(12 * length + 16 * end + i for end in range(2) for i in range(12, 16))
        single = {12 * k + i for k in range(length) for i in range(4)}
        single.update(12 * length + 16 * end + 3 * slot + 1
                      for end in range(2) for slot in range(4))
        doubled = {12 * k + i for k in range(length) for i in range(8, 12)}
        doubled.update(12 * length + 16 * end + 3 * slot
                       for end in range(2) for slot in range(4))
        expected_position = {(min(i, j), max(i, j)) for i in single for j in doubled
                             if same_membership_position_block(names[i], names[j])}
        expected_same = {(min(i, j), max(i, j)) for i in single for j in doubled
                         if cross_block_same_slot_mixed_membership(names[i], names[j])}
        expected_opposite = {(min(i, j), max(i, j)) for i in single for j in doubled
                             if cross_block_opposite_collinear_slot_mixed_membership(
                                 names[i], names[j])}
        expected_direction = {
            (min(i, j), max(i, j)) for i in single for j in doubled
            if step0_end0_membership_direction(names[i], names[j], single_at)}
        assert pairs == tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names))
                              if length == 1 or i in wrap or j in wrap
                              or (length == 2 and ((i in single and j in single)
                                                 or (i in doubled and j in doubled)
                                                 or (i, j) in expected_position
                                                 or (i, j) in expected_same
                                                 or (i, j) in expected_opposite
                                                 or (i, j) in expected_direction)))
        if length == 2:
            assert tuple(map(len, (expected_position, expected_same, expected_opposite,
                                   expected_direction))) == (64, 48, 48, 8)
            families = (expected_position, expected_same, expected_opposite,
                        expected_direction)
            assert all(families[i].isdisjoint(families[j])
                       for i in range(len(families)) for j in range(i + 1, len(families)))
            assert sum(i not in wrap and j not in wrap for i, j in pairs) == 408
            assert all({names[i].split("_")[0], names[j].split("_")[0]}
                       == {"step0", "end0"} for i, j in expected_direction)
            assert all(next(name.split("_")[1] for name in (names[i], names[j])
                            if name.split("_")[0] == single_at) == "e"
                       for i, j in expected_direction)
        for arc_type in types:
            bits = arc_feature_bits(arc_type)
            row = system.row(row_index)
            assert row[:len(all_types)].nonzero_positions() == [column_index[arc_type]]
            assert row[len(all_types):start].is_zero()
            assert row[start + len(pairs):].is_zero()
            assert row[start:start + len(pairs)] == vector(
                GF(2), [bits[i] * bits[j] for i, j in pairs])
            assert system_rhs[row_index] == GF(2)(
                sum(bits[12 * k] * bits[12 * k + 2] for k in range(length))
                if length == 3 else 0)
            row_index += 1
    assert row_index == system.nrows()
    print("SYSTEM: rows=%d columns=%d" % system.dimensions(), flush=True)
    rank = system.rank()
    augmented_rank = system.augment(system_rhs.column()).rank()
    solvable = rank == augmented_rank
    print("RESULT: rank=%d augmented_rank=%d solvable=%s" %
          (rank, augmented_rank, solvable), flush=True)
    observed = {"rank": int(rank), "augmented_rank": int(augmented_rank),
                "solvable": bool(solvable)}
    if solvable:
        solution = system.solve_right(system_rhs)
        assert system * solution == system_rhs
        if record:
            observed["solution"] = [int(x) for x in solution]
        else:
            solution = vector(GF(2), saved[single_at]["solution"])
            assert len(solution) == system.ncols()
            assert system * solution == system_rhs
        print("WITNESS: all 7085 keys reconstructed", flush=True)
    else:
        obstruction = next(row for row in system.left_kernel_matrix().rows()
                           if row * system_rhs == 1)
        assert (obstruction * system).is_zero()
        assert obstruction * system_rhs == 1
        if record:
            observed["key_indices"] = [int(i) for i in obstruction.nonzero_positions()
                                       if i < len(rhs)]
            observed["constraint_indices"] = [int(i - len(rhs))
                                               for i in obstruction.nonzero_positions()
                                               if i >= len(rhs)]
        else:
            indices = saved[single_at]["key_indices"] + [
                len(rhs) + i for i in saved[single_at]["constraint_indices"]]
            assert len(indices) == len(set(indices))
            index_set = set(indices)
            certificate = vector(GF(2), [1 if i in index_set else 0
                                         for i in range(system.nrows())])
            assert (certificate * system).is_zero()
            assert certificate * system_rhs == 1
            print("OBSTRUCTION: saved left-kernel certificate verified; saved_keys=%d saved_constraints=%d" %
                  (len(saved[single_at]["key_indices"]),
                   len(saved[single_at]["constraint_indices"])), flush=True)
    if not record:
        assert observed == {key: saved[single_at][key] for key in observed}
    observed_all[single_at] = observed

if record:
    certificate_path.write_text(json.dumps(observed_all, separators=(",", ":")) + "\n")
print("PASS: step0/end0 membership-direction split decisions and certificates", flush=True)
