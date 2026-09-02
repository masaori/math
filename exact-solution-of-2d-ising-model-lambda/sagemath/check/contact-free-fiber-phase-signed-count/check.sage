"""接触の無い部分の位相和が整数の符号付き数え上げになることを厳密検査する。

対象: claim_contact_free_fiber_phase_signed_count。

一辺 L=2 の全非後退置換をファイバー (D,E) に分け、接触の無い置換の位相寄与が
全て {-1,1} に属することと、その和が正符号の個数と負符号の個数の差に等しいことを、
四つのスピン構造ごとに Q(zeta8) と ZZ の厳密演算で検査する。浮動小数点は使わない。
"""

load("sagemath/check/contact-free-permutation-phase-product/check.sage")


def doubled_and_single_sets(phi):
    moved = set(edge for edge in oriented if phi[edge] != edge)
    support = {(kind, i, j) for kind, i, j, unused_direction in moved}
    doubled = {base for base in support
               if (base[0], base[1], base[2], 0) in moved
               and (base[0], base[1], base[2], 1) in moved}
    return frozenset(doubled), frozenset(support.difference(doubled))


signed_counts = {}
for index, phi in enumerate(nonbacktracking_permutations):
    if permutation_contact_pair_count(phi) != 0:
        continue
    fiber = doubled_and_single_sets(phi)
    for a in (0, 1):
        for b in (0, 1):
            value = K8(1)
            for orbit in orbits_of[index]:
                orbit_value = K8(-1)
                for edge in orbit:
                    orbit_value *= K8(transition_entry(L, a, b, edge, phi[edge]))
                value *= orbit_value
            assert value in (K8(1), K8(-1))
            key = (fiber, a, b)
            positive, negative, total = signed_counts.get(key, (ZZ(0), ZZ(0), K8(0)))
            if value == K8(1):
                positive += 1
            else:
                negative += 1
            signed_counts[key] = (positive, negative, total + value)

checked = 0
for positive, negative, total in signed_counts.values():
    assert total == K8(positive - negative)
    assert positive - negative in ZZ
    checked += 1

assert checked > 0
print("PASS: L=%d の接触の無い置換を含むファイバー×四スピン構造 %d 組で、"
      "位相和が正符号数と負符号数の差に等しいことを検査"
      % (L, checked))
