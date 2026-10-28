# 対象ラベル: claim_local_pairing_signed_sum
# 各式の住処: ZZ。四方向は端点番号付き半辺の方向番号。
from itertools import combinations, product


def pairings(points):
    if not points:
        yield ()
        return
    first, rest = points[0], points[1:]
    for index, second in enumerate(rest):
        for tail in pairings(rest[:index] + rest[index + 1:]):
            yield ((first, second),) + tail


ports = (0, 1, 2, 3)
local_cases = 0
for degree in (0, 2, 4):
    for selected in combinations(ports, degree):
        choices = list(pairings(selected))
        crossing = lambda pairs: int(set(map(frozenset, pairs)) == {frozenset((0, 2)), frozenset((1, 3))})
        local_sum = sum(ZZ(-1) ** crossing(choice) for choice in choices)
        assert local_sum == 1
        if degree == 4:
            assert sorted(crossing(choice) for choice in choices) == [0, 0, 1]
        local_cases += 1


global_cases = 0
for length in (1, 2):
    vertices = list(product(range(length), repeat=2))
    edges = list(product((0, 1), range(length), range(length)))
    for mask in range(1 << len(edges)):
        selected = {edge for index, edge in enumerate(edges) if mask & (1 << index)}
        families = []
        for vertex in vertices:
            directions = []
            for axis, row, col in selected:
                for endpoint in (0, 1):
                    source = (row, (col + endpoint) % length) if axis == 0 else ((row + endpoint) % length, col)
                    if source == vertex:
                        directions.append(axis + 2 * endpoint)
            if len(directions) % 2:
                break
            families.append(list(pairings(tuple(sorted(directions)))))
        else:
            direct = sum(ZZ(-1) ** sum(int(set(map(frozenset, choice)) == {frozenset((0, 2)), frozenset((1, 3))}) for choice in family)
                         for family in product(*families))
            factored = prod(sum(ZZ(-1) ** int(set(map(frozenset, choice)) == {frozenset((0, 2)), frozenset((1, 3))})
                               for choice in family) for family in families)
            assert direct == factored == 1
            global_cases += 1

print("RESULT: PASS; %d local sets, %d even subgraphs" % (local_cases, global_cases))
