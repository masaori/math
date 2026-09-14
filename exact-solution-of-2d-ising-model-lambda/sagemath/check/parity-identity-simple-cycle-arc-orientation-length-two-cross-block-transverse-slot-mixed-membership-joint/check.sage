"""既存 7,085 鍵で、異なる軸のスロットを結ぶ残りの両所属混合積を加える有限判定。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。
"""
print("LOAD: constructing finite key data", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-cross-block-transverse-slot-mixed-membership-joint/construction.sage")

print("LOAD: finite key data ready", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
entries, all_types, column_index, rhs = build_orient_d_congruence_system(compressor)
assert len(joint_keys) == len(rhs) == 7085
assert len(all_types) == 10098
system, system_rhs, blocks = length_two_cross_block_transverse_slot_mixed_membership_joint_system(
    entries, rhs, all_types, column_index)
assert system.dimensions() == (12220, 13450)
assert tuple(len(blocks[n][0]) for n in (1, 2, 3)) == (1249, 1842, 2044)
assert tuple(len(blocks[n][2]) for n in (1, 2, 3)) == (946, 1256, 1150)
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
    expected_transverse = {(min(i, j), max(i, j)) for i in single for j in doubled
                           if cross_block_transverse_slot_mixed_membership(
                               names[i], names[j])}
    assert pairs == tuple((i, j) for i in range(len(names)) for j in range(i + 1, len(names))
                          if length == 1 or i in wrap or j in wrap
                          or (length == 2 and ((i in single and j in single)
                                             or (i in single and j in doubled)
                                             or (i in doubled and j in single)
                                             or (i in doubled and j in doubled))))
    if length == 2:
        assert tuple(map(len, (expected_position, expected_same, expected_opposite,
                               expected_transverse))) == (64, 48, 48, 96)
        families = (expected_position, expected_same, expected_opposite, expected_transverse)
        assert all(families[i].isdisjoint(families[j])
                   for i in range(len(families)) for j in range(i + 1, len(families)))
        assert len(set().union(*families)) == 256
        assert sum(i not in wrap and j not in wrap for i, j in pairs) == 496
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

# この候補は、単一辺所属・二重辺所属だけからなる全 256 混合積を許す既存系と
# 列集合・列順とも一致する。保存済みの厳密解をこの構成へ掛け直して独立に照合する。
import json
from pathlib import Path

certificate_path = Path("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-two-unselected-membership-joint/certificate.json")
saved = json.loads(certificate_path.read_text())
assert (saved["rank"], saved["augmented_rank"], saved["solvable"]) == (11836, 11836, True)
solution = vector(GF(2), saved["solution"])
assert len(solution) == system.ncols()
assert system * solution == system_rhs
print("RESULT: rank=11836 augmented_rank=11836 solvable=True", flush=True)

values = {}
for length, (types, names, pairs, start) in blocks.items():
    active = tuple(pair for index, pair in enumerate(pairs) if solution[start + index])
    for arc_type in types:
        bits = arc_feature_bits(arc_type)
        value = GF(2)((sum(bits[12 * k] * bits[12 * k + 2] for k in range(length))
                       if length == 3 else 0)
                      + sum(bits[i] * bits[j] for i, j in active))
        assert value == solution[column_index[arc_type]]
        values[arc_type] = value
    wrap_count = sum("wrap" in names[i] or "wrap" in names[j] for i, j in active)
    print("WITNESS: length=%d terms=%d wrap_terms=%d nonwrap_terms=%d" %
          (length, len(active), wrap_count, len(active) - wrap_count), flush=True)
for side, doubled, single, target in joint_keys:
    value = GF(2)(0)
    for arc_type in compressed_arc_types(side, doubled, single, compressor):
        if arc_type[0] == "arc" and len(arc_type[1]) in blocks:
            value += values[arc_type]
        else:
            value += solution[column_index[arc_type]]
    assert value == target
print("WITNESS: all 7085 keys reconstructed", flush=True)
print("PASS: length-two cross-block transverse-slot mixed-membership joint decision", flush=True)
