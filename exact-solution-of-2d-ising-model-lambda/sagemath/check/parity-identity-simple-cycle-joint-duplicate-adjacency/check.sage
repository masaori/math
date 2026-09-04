"""重複隣接旗を加えた局所署名で一辺二・一辺三を同時に解く。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-joint-local-sign-formula では、上下左右の
各スロットの D/E 所属と切断隣接旗だけでは、一辺二と一辺三の頂点項を
同時に書けなかった。一辺二では上下または左右の対向スロットの基底辺が
同じ無向端点対を持つ。この重複隣接を縦・横の二旗として署名へ加え、
署名の任意関数の頂点和で全 7,085 鍵を同時に書けるかを F_2 上で判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-joint-local-sign-formula/check.sage")


def unordered_endpoints(side, base):
    return frozenset(base_endpoints(side, base))


def duplicate_adjacency_flags(side, vertex):
    slots = dict(incident_base_slots(side, vertex))
    return (
        ZZ(unordered_endpoints(side, slots["up"])
           == unordered_endpoints(side, slots["down"])),
        ZZ(unordered_endpoints(side, slots["left"])
           == unordered_endpoints(side, slots["right"])),
    )


def augmented_vertex_signature(side, vertex, doubled, single):
    return (
        relative_vertex_signature(side, vertex, doubled, single),
        duplicate_adjacency_flags(side, vertex),
    )


def augmented_odd_signature_row(side, doubled, single):
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    counts = {}
    for vertex in vertices:
        signature = augmented_vertex_signature(
            side, vertex, doubled, single)
        counts[signature] = counts.get(signature, ZZ(0)) + 1
    return frozenset(signature for signature, count in counts.items()
                     if count % 2 == 1)


assert duplicate_adjacency_flags(ZZ(2), (ZZ(0), ZZ(0))) == (1, 1)
assert duplicate_adjacency_flags(ZZ(3), (ZZ(0), ZZ(0))) == (0, 0)

row_records = {}
conflict_pairs = []
for side, doubled, single, term in joint_keys:
    row = augmented_odd_signature_row(side, doubled, single)
    if row in row_records:
        previous_term, previous_key = row_records[row]
        if previous_term != term:
            conflict_pairs.append(
                (previous_key, (side, doubled, single), row))
    else:
        row_records[row] = (term, (side, doubled, single))

print("AUGMENTED: keys=%d distinct-odd-signature-rows=%d direct-conflicts=%d"
      % (len(joint_keys), len(row_records), len(conflict_pairs)))
assert len(joint_keys) == 7085
assert len(conflict_pairs) == 0

row_list = sorted(
    row_records.items(),
    key=lambda item: tuple(sorted(item[0])))
augmented_signatures = sorted({
    signature for row, _ in row_list for signature in row})
membership_matrix = matrix(GF(2), [
    [GF(2)(1) if signature in row else GF(2)(0)
     for signature in augmented_signatures]
    for row, _ in row_list
])
term_vector = vector(GF(2), [record[0] for _, record in row_list])
try:
    solution = membership_matrix.solve_right(term_vector)
    solvable = True
except ValueError:
    solution = None
    solvable = False

print("FREE-VALUES: signatures=%d rank=%d solvable=%s"
      % (len(augmented_signatures), membership_matrix.rank(), solvable))
assert len(augmented_signatures) == 394
assert membership_matrix.rank() == 323
assert not solvable

for selected_side, expected_keys, expected_signatures, expected_rank, expected_solvable in (
        (ZZ(2), 320, 124, 89, True),
        (ZZ(3), 6765, 270, 234, False)):
    selected = [
        (augmented_odd_signature_row(side, doubled, single), term)
        for side, doubled, single, term in joint_keys
        if side == selected_side
    ]
    selected_signature_list = sorted({
        signature for row, _ in selected for signature in row})
    selected_matrix = matrix(GF(2), [
        [GF(2)(1) if signature in row else GF(2)(0)
         for signature in selected_signature_list]
        for row, _ in selected
    ])
    selected_terms = vector(GF(2), [term for _, term in selected])
    try:
        selected_matrix.solve_right(selected_terms)
        selected_solvable = True
    except ValueError:
        selected_solvable = False
    print("L=%d: keys=%d signatures=%d rank=%d solvable=%s"
          % (selected_side, len(selected), len(selected_signature_list),
             selected_matrix.rank(), selected_solvable))
    assert len(selected) == expected_keys
    assert len(selected_signature_list) == expected_signatures
    assert selected_matrix.rank() == expected_rank
    assert selected_solvable == expected_solvable

print("PASS: 重複隣接旗を加えても、署名ごとの値を自由に選ぶ頂点和の"
      "線型系に解が無く、一辺二の全 320 鍵と一辺三の全 6,765 鍵の"
      "頂点項を同時に書けない。不足は一辺三の対象だけでも残る")
