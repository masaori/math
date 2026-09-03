"""奇数辺長の全辺鍵で、対角固定置換の位相対消滅の必要条件を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L の対角平行移動 (1,1)（位数 L）で固定され選択文字が非自明なファイバー鍵は、
奇数辺長では全辺鍵 (D,E)=(空集合, E_L) だけだった
（translation-diagonal-fixed-nontrivial-character）。この鍵のファイバー上に
対角部分群と可換な符号反転完全マッチングが存在するための必要条件を検査する。

群の元 g が置換 u を固定し、不変なマッチング M が対 {u,v} を含むなら、
{g u, g v} = {u, g v} も M に属し、u の属する対は一つなので g v = v である。
従って固定置換は固定置換同士で対にされる。候補辺は四つのスピン構造すべてで
位相寄与を反転するから、固定置換の位相ベクトル（四つのスピン構造の位相寄与の組）の
多重集合は符号反転で不変でなければならない。これは必要条件であり、
固定置換同士を結ぶ候補辺が実在するかは別途の検査である。

全辺鍵のファイバーは「各基底辺の向きを一つ選ぶ割当で全頂点の入次数と出次数が
2 になるもの（氷型配向）」と「各頂点での入辺 2 本から出辺 2 本への全単射」の組と
一対一に対応する。動く辺の逆向き辺は動かないので、非後退条件は自動で満たされる。
対角固定置換は、配向が対角辺軌道上で一定で、対応が頂点軌道の代表から対角平行移動で
運ばれるものに限る。一辺二では全辺鍵のファイバー 288 個を直接列挙して固定置換を
両側から数え、構成法そのものを検証する。
計算は有限集合・有限写像と Q(zeta8) の等号だけで行う。浮動小数点は使わない。
"""

from itertools import product

K8 = CyclotomicField(8)
zeta8 = K8.gen()


def base_edge_list(side):
    return [(kind, i, j) for kind in ("h", "v")
            for i in range(side) for j in range(side)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def endpoints(side, edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % side) if kind == "h" else ((i + 1) % side, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def direction(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


def seam_parities(side, edge):
    kind, i, j = edge[0], edge[1], edge[2]
    return (ZZ(kind == "h" and j == side - 1), ZZ(kind == "v" and i == side - 1))


def rotation_phase(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: K8(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


def transition_entry(side, a, b, edge, successor):
    assert endpoints(side, edge)[1] == endpoints(side, successor)[0]
    assert successor != reversal(edge)
    ch, cv = seam_parities(side, successor)
    twist = K8(ZZ(-1) ** (a * ch + b * cv))
    return twist * rotation_phase(edge, successor)


def translate_oriented(side, edge, times):
    kind, i, j, d = edge
    return (kind, (i + times) % side, (j + times) % side, d)


def diagonal_edge_orbits(side):
    unseen = set(base_edge_list(side))
    orbits = []
    while unseen:
        first = min(unseen)
        orbit = []
        kind, i, j = first
        for times in range(side):
            orbit.append((kind, (i + times) % side, (j + times) % side))
        assert len(set(orbit)) == side
        orbits.append(orbit)
        unseen -= set(orbit)
    assert len(orbits) == 2 * side
    return orbits


def diagonal_vertex_orbits(side):
    unseen = {(i, j) for i in range(side) for j in range(side)}
    orbits = []
    while unseen:
        first = min(unseen)
        orbit = [((first[0] + times) % side, (first[1] + times) % side)
                 for times in range(side)]
        assert len(set(orbit)) == side
        orbits.append(orbit)
        unseen -= set(orbit)
    assert len(orbits) == side
    return orbits


def in_out_lists(side, moved):
    incoming = {}
    outgoing = {}
    for edge in moved:
        start, end = endpoints(side, edge)
        outgoing.setdefault(start, []).append(edge)
        incoming.setdefault(end, []).append(edge)
    return incoming, outgoing


def is_ice_moved_set(side, moved):
    incoming, outgoing = in_out_lists(side, moved)
    vertices = [(i, j) for i in range(side) for j in range(side)]
    return all(
        len(incoming.get(vertex, [])) == 2 and len(outgoing.get(vertex, [])) == 2
        for vertex in vertices
    )


def ice_orientation_count(side):
    """全基底辺の向きの割当のうち氷型（各頂点で入 2 出 2）のものを数える。"""
    bases = base_edge_list(side)
    count = ZZ(0)
    for bits in product((0, 1), repeat=len(bases)):
        moved = [base + (bit,) for base, bit in zip(bases, bits)]
        if is_ice_moved_set(side, moved):
            count += 1
    return count


def assert_full_key_permutation(side, phi, moved):
    assert set(phi) == moved
    assert set(phi.values()) == moved
    for edge, image in phi.items():
        assert endpoints(side, edge)[1] == endpoints(side, image)[0]
        assert image != reversal(edge)
        assert reversal(edge) not in moved
    support = {(kind, i, j) for kind, i, j, d in moved}
    assert support == set(base_edge_list(side))


def invariant_fixed_permutations(side):
    """対角平行移動で固定される全辺鍵の置換を、軌道上の代表の選択から全構成する。"""
    edge_orbits = diagonal_edge_orbits(side)
    vertex_orbits = diagonal_vertex_orbits(side)
    invariant_ice = ZZ(0)
    permutations = []
    for bits in product((0, 1), repeat=len(edge_orbits)):
        moved = set()
        for bit, orbit in zip(bits, edge_orbits):
            for base in orbit:
                moved.add(base + (bit,))
        if not is_ice_moved_set(side, moved):
            continue
        invariant_ice += 1
        incoming, outgoing = in_out_lists(side, moved)
        for pairing_bits in product((0, 1), repeat=len(vertex_orbits)):
            phi = {}
            for bit, orbit in zip(pairing_bits, vertex_orbits):
                representative = orbit[0]
                ins = sorted(incoming[representative])
                outs = sorted(outgoing[representative])
                pairs = [(ins[0], outs[bit]), (ins[1], outs[1 - bit])]
                for times in range(side):
                    for source, target in pairs:
                        phi[translate_oriented(side, source, times)] = (
                            translate_oriented(side, target, times)
                        )
            assert_full_key_permutation(side, phi, moved)
            for edge, image in phi.items():
                assert phi[translate_oriented(side, edge, 1)] == (
                    translate_oriented(side, image, 1)
                )
            permutations.append(phi)
    assert len(permutations) == invariant_ice * ZZ(2) ** side
    return invariant_ice, permutations


def all_full_key_permutations(side):
    """全辺鍵のファイバーを直接列挙する（小さい辺長の検証用）。"""
    bases = base_edge_list(side)
    vertices = [(i, j) for i in range(side) for j in range(side)]
    permutations = []
    for bits in product((0, 1), repeat=len(bases)):
        moved = {base + (bit,) for base, bit in zip(bases, bits)}
        if not is_ice_moved_set(side, moved):
            continue
        incoming, outgoing = in_out_lists(side, moved)
        for pairing_bits in product((0, 1), repeat=len(vertices)):
            phi = {}
            for bit, vertex in zip(pairing_bits, vertices):
                ins = sorted(incoming[vertex])
                outs = sorted(outgoing[vertex])
                phi[ins[0]] = outs[bit]
                phi[ins[1]] = outs[1 - bit]
            assert_full_key_permutation(side, phi, moved)
            permutations.append(phi)
    return permutations


def moved_orbits(phi):
    seen = set()
    orbits = []
    for edge in sorted(phi):
        if edge in seen:
            continue
        walk = []
        current = edge
        while current not in seen:
            seen.add(current)
            walk.append(current)
            current = phi[current]
        assert current == edge
        orbits.append(walk)
    return orbits


def phase_vector(side, phi):
    orbits = moved_orbits(phi)
    values = []
    for a in (0, 1):
        for b in (0, 1):
            value = K8(1)
            for walk in orbits:
                orbit_product = K8(1)
                for edge in walk:
                    orbit_product *= transition_entry(side, a, b, edge, phi[edge])
                value *= -orbit_product
            values.append(value)
    return tuple(values)


# 一辺二で構成法を直接列挙と突き合わせる（対角平行移動の位数は 2）。
side2_fiber = all_full_key_permutations(2)
assert len(side2_fiber) == 288
assert ice_orientation_count(2) == 18
side2_direct_fixed = [
    phi for phi in side2_fiber
    if all(
        phi.get(translate_oriented(2, edge, 1))
        == translate_oriented(2, phi[edge], 1)
        for edge in phi
    )
]
side2_invariant_ice, side2_constructed = invariant_fixed_permutations(2)
as_sets = lambda items: {frozenset(phi.items()) for phi in items}
assert as_sets(side2_direct_fixed) == as_sets(side2_constructed)
print(f"L=2: full-key fiber {len(side2_fiber)}, "
      f"diagonal-fixed permutations {len(side2_constructed)} "
      f"(invariant ice orientations {side2_invariant_ice})")
assert (side2_invariant_ice, len(side2_constructed)) == (6, 24)

# 一辺三は全辺鍵のファイバーの大きさも確定しておく（氷型配向数 × 2^頂点数）。
side3_ice = ice_orientation_count(3)
side3_fiber_size = side3_ice * ZZ(2) ** 9
print(f"L=3: ice orientations {side3_ice}, full-key fiber size {side3_fiber_size}")
assert side3_ice == 148
assert side3_fiber_size == 75776

# 奇数辺長の固定置換の位相ベクトルの多重集合が符号反転で不変かを検査する。
expected = {
    3: {"invariant_ice": 10, "fixed_count": 80,
        "negation_invariant": True,
        "phase_sums": (0, 0, 0, 0)},
    5: {"invariant_ice": 34, "fixed_count": 1088,
        "negation_invariant": True,
        "phase_sums": (0, 0, 0, 0)},
    7: {"invariant_ice": 130, "fixed_count": 16640,
        "negation_invariant": True,
        "phase_sums": (0, 0, 0, 0)},
}
for side in (3, 5, 7):
    invariant_ice, fixed_permutations = invariant_fixed_permutations(side)
    vectors = [phase_vector(side, phi) for phi in fixed_permutations]
    counts = {}
    for vector in vectors:
        counts[vector] = counts.get(vector, 0) + 1
    negated = {tuple(-component for component in vector): count
               for vector, count in counts.items()}
    negation_invariant = counts == negated
    phase_sums = tuple(
        sum((vector[index] for vector in vectors), K8(0))
        for index in range(4)
    )
    print(f"L={side}: invariant ice orientations {invariant_ice}, "
          f"diagonal-fixed permutations {len(fixed_permutations)}, "
          f"negation-invariant multiset {negation_invariant}, "
          f"phase sums {phase_sums}")
    assert invariant_ice == expected[side]["invariant_ice"]
    assert len(fixed_permutations) == expected[side]["fixed_count"]
    assert negation_invariant == expected[side]["negation_invariant"]
    assert phase_sums == tuple(
        K8(entry) for entry in expected[side]["phase_sums"]
    )

print("PASS: translation-diagonal-full-key-fixed-permutation-phase")
