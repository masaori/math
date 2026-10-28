"""辺の重複がない閉歩道の横断消去を有限トーラスで厳密検算する。"""
load("sagemath/check/edge-distinct-smoothing-crossing-parity/check.sage")


def turn(e, f):
    direction = 2*e[3] if e[0] == 0 else 1+2*e[3]
    next_direction = 2*f[3] if f[0] == 0 else 1+2*f[3]
    diff = (next_direction - direction) % 4
    assert diff != 2
    return ZZ(0 if diff == 0 else (1 if diff == 1 else -1))


def total_turn(walk):
    return sum(turn(walk[i], walk[(i+1) % len(walk)]) for i in range(len(walk)))


def seam(L, walk):
    return (sum(ZZ(e[0] == 0 and e[2] == L-1) for e in walk) % 2,
            sum(ZZ(e[0] == 1 and e[1] == L-1) for e in walk) % 2)


def eliminate(L, walk):
    for k in range(len(walk)):
        for l in range(k+1, len(walk)):
            if (ends(L, walk[k])[1] == ends(L, walk[l])[1]
                    and straight(walk[k], walk[(k+1) % len(walk)])
                    and straight(walk[l], walk[(l+1) % len(walk)])
                    and axis(walk[k]) != axis(walk[l])):
                A = walk[k+1:l+1]
                B = walk[l+1:] + walk[:k+1]
                assert crossings(L, A) + crossings(L, B) < crossings(L, walk)
                return eliminate(L, A) + eliminate(L, B)
    return [walk]


def verify(L, walk):
    family = eliminate(L, walk)
    supports = [set(e[:3] for e in member) for member in family]
    assert all(crossings(L, member) == 0 for member in family)
    assert len(set.union(*supports)) == sum(len(s) for s in supports) == len(walk)
    assert set.union(*supports) == set(e[:3] for e in walk)
    assert total_turn(walk) == sum(total_turn(member) for member in family)
    assert seam(L, walk) == tuple(
        sum(seam(L, member)[coordinate] for member in family) % 2
        for coordinate in range(2))
    parity = ZZ(len(family)-1)
    for i in range(len(family)):
        for j in range(i+1, len(family)):
            parity += intersection(L, family[i], family[j])
    assert crossings(L, walk) % 2 == parity % 2


checked = 0
for L in (1, 2, 3):
    oriented = edges(L)
    frontier = [(e,) for e in oriented]
    for _ in range(min(8, 2*L*L)):
        next_frontier = []
        for walk in frontier:
            if successor(L, walk[-1], walk[0]):
                verify(L, walk)
                checked += 1
            if len(walk) < min(8, 2*L*L):
                for e in oriented:
                    if e[:3] not in {f[:3] for f in walk} and successor(L, walk[-1], e):
                        next_frontier.append(walk + (e,))
        frontier = next_frontier
assert checked > 0
print(f"PASS: {checked} closed walks, crossing elimination and all invariants")
