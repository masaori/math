# 対象ラベル: claim_pfaffian_signed_even_subgraph
# 非零標識付き項を補辺ごとに集める有限和を ZZ[x] で照合する。
from itertools import combinations, product

R = PolynomialRing(ZZ, 'x')
x = R.gen()


def pairings(points):
    if not points:
        yield ()
        return
    first, rest = points[0], points[1:]
    for index, second in enumerate(rest):
        for tail in pairings(rest[:index] + rest[index + 1:]):
            yield ((first, second),) + tail


crossing = {frozenset((frozenset((0, 2)), frozenset((1, 3))))}
checked = 0
for length in (1, 2):
    vertices = list(product(range(length), repeat=2))
    edges = list(product((0, 1), range(length), range(length)))
    for a, b in product((0, 1), repeat=2):
        grouped = R.zero()
        signed_even = R.zero()
        for mask in range(1 << len(edges)):
            selected = {edge for index, edge in enumerate(edges) if mask & (1 << index)}
            local_choices = []
            for vertex in vertices:
                ports = []
                for axis, row, col in selected:
                    for endpoint in (0, 1):
                        source = (row, (col + endpoint) % length) if axis == 0 else ((row + endpoint) % length, col)
                        if source == vertex:
                            ports.append(axis + 2 * endpoint)
                if len(ports) % 2:
                    break
                local_choices.append(tuple(pairings(tuple(sorted(ports)))))
            else:
                h = sum(col == length - 1 for axis, row, col in selected if axis == 0) % 2
                v = sum(row == length - 1 for axis, row, col in selected if axis == 1) % 2
                chi = ZZ(-1) ** (h*v + (1-a)*h + (1-b)*v)
                inner = sum(ZZ(-1) ** sum(frozenset(map(frozenset, choice)) in crossing for choice in family)
                            for family in product(*local_choices))
                assert inner == 1
                grouped += R(chi * inner) * x ** len(selected)
                signed_even += R(chi) * x ** len(selected)
                checked += 1
        assert grouped == signed_even

print('RESULT: PASS; %d even-subgraph/twist cases in ZZ[x]' % checked)
