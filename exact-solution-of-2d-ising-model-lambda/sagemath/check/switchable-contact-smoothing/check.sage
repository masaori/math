"""切り替え可能な接触の平滑化が非後退置換の同じファイバーに留まることを厳密検査する。

対象: claim_switchable_contact_smoothing_preserves_fiber。

一辺 L=2 のトーラスの全非後退置換について、動く二辺の終点が一致し、像の交換後も
非後退かつ二辺が動く接触対を全列挙する。像を交換した写像が置換かつ非後退であり、
動く辺集合・反転対の辺集合・単純通過の辺集合を保つことを有限集合の等号で検査する。
浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def moved_edges(phi):
    return {edge for edge in oriented if phi[edge] != edge}


def doubled_and_single_sets(phi):
    moved = moved_edges(phi)
    support = {(kind, i, j) for kind, i, j, unused_direction in moved}
    doubled = {base for base in support
               if (base[0], base[1], base[2], 0) in moved
               and (base[0], base[1], base[2], 1) in moved}
    return doubled, support.difference(doubled)


def switchable_contact_pairs(phi):
    moved = [edge for edge in oriented if phi[edge] != edge]
    pairs = []
    for i in range(len(moved)):
        for j in range(i + 1, len(moved)):
            edge = moved[i]
            other = moved[j]
            if endpoints(L, edge)[1] != endpoints(L, other)[1]:
                continue
            if phi[other] not in successor_lists[edge] or phi[edge] not in successor_lists[other]:
                continue
            if phi[other] == edge or phi[edge] == other:
                continue
            pairs.append((edge, other))
    return pairs


def smooth(phi, edge, other):
    result = dict(phi)
    result[edge] = phi[other]
    result[other] = phi[edge]
    return result


checked = 0
permutations_with_pair = 0
for phi in nonbacktracking_permutations:
    pairs = switchable_contact_pairs(phi)
    if pairs:
        permutations_with_pair += 1
    for edge, other in pairs:
        psi = smooth(phi, edge, other)

        assert set(psi.keys()) == set(oriented)
        assert set(psi.values()) == set(oriented)
        assert len(set(psi.values())) == len(oriented)
        assert all(psi[current] == current or psi[current] in successor_lists[current]
                   for current in oriented)
        assert moved_edges(psi) == moved_edges(phi)
        assert doubled_and_single_sets(psi) == doubled_and_single_sets(phi)
        assert smooth(psi, edge, other) == phi
        checked += 1

assert permutations_with_pair > 0
assert checked > 0
print("PASS: L=%d 非後退置換 %d 個中、切り替え可能な接触対を持つ置換 %d 個、接触対 %d 件"
      % (L, len(nonbacktracking_permutations), permutations_with_pair, checked))
