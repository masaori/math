# 対象ラベル: claim_local_pairing_four_ports_count
from itertools import combinations


def pairings(points):
    if not points:
        yield ()
        return
    first, rest = points[0], points[1:]
    for j, second in enumerate(rest):
        for tail in pairings(rest[:j] + rest[j + 1:]):
            yield ((first, second),) + tail


ports = (0, 1, 2, 3)
checked = 0
for degree, expected in ((0, 1), (2, 1), (4, 3)):
    for selected in combinations(ports, degree):
        matchings = list(pairings(selected))
        assert len(matchings) == expected
        maps = []
        for matching in matchings:
            mate = {i: i for i in ports}
            for a, b in matching:
                mate[a], mate[b] = b, a
            assert all(mate[mate[i]] == i for i in ports)
            assert all(mate[i] != i and mate[i] in selected for i in selected)
            assert all(mate[i] == i for i in ports if i not in selected)
            maps.append(tuple(mate[i] for i in ports))
        assert len(set(maps)) == expected
        checked += 1

assert set(pairings(ports)) == {
    ((0, 1), (2, 3)),
    ((0, 2), (1, 3)),
    ((0, 3), (1, 2)),
}
print("RESULT: PASS; %d selected port sets" % checked)
