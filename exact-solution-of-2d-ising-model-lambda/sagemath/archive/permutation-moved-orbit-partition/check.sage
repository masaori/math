"""動く辺の相異なる軌道が動く辺集合を分割することを厳密検査する。

対象: def_moved_edge_set / def_permutation_orbit_set /
def_moved_orbit_family / claim_moved_orbit_partition。
一辺 L=2 のトーラスの向き付き辺のうち先頭六辺の全置換 6! 個を取り、
残りを固定する。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


L = 2
oriented = edges(L)
N = len(oriented)
checked_moved = 0

for image in Permutations(range(6)):
    sigma = list(image) + list(range(6, N))
    moved = {i for i in range(N) if sigma[i] != i}

    def orbit(start):
        result = []
        current = start
        while current not in result:
            result.append(current)
            current = sigma[current]
        assert current == start
        return frozenset(result)

    # ~ は動く辺上の同値関係である。
    for e in moved:
        assert e in orbit(e)
    for e in moved:
        for f in moved:
            same_ef = f in orbit(e)
            assert same_ef == (e in orbit(f))
            for g in moved:
                if same_ef and g in orbit(f):
                    assert g in orbit(e)

    # 集合に入れることで同じ軌道を重複排除する。
    family = {orbit(e) for e in moved}
    assert all(len(component) > 0 for component in family)
    components = list(family)
    for i in range(len(components)):
        for j in range(i + 1, len(components)):
            assert components[i].isdisjoint(components[j])
    union = set().union(*family) if family else set()
    assert union == moved
    assert all(component <= moved for component in family)
    checked_moved += len(moved)

assert checked_moved > 0
print("PASS: distinct moved orbits partition the moved set "
      f"({checked_moved} moved-edge instances)")
