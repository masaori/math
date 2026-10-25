# 対象ラベル: claim_vertex_local_pairing_product
from itertools import product


def pairings(points):
    if not points:
        yield ()
        return
    first, tail = points[0], points[1:]
    for j, other in enumerate(tail):
        for rest in pairings(tail[:j] + tail[j + 1:]):
            yield ((first, other),) + rest


for length in (1, 2):
    vertices = list(product(range(length), repeat=2))
    edges = list(product((0, 1), range(length), range(length)))
    for mask in range(1 << len(edges)):
        selected = {e for n, e in enumerate(edges) if mask & (1 << n)}
        local = []
        for i, j in vertices:
            ports = []
            for axis, a, b in edges:
                for endpoint in (0, 1):
                    source = (a, (b + endpoint) % length) if axis == 0 else ((a + endpoint) % length, b)
                    if source == (i, j) and (axis, a, b) in selected:
                        ports.append((axis, a, b, endpoint))
            if len(ports) % 2:
                break
            local.append(list(pairings(ports)))
        else:
            count = sum(1 for _ in product(*local))
            expected = prod(len(choices) for choices in local)
            assert count == expected
            assert all(len(choices) == (3 if len(choices[0]) == 2 else 1)
                       for choices in local)

print("RESULT: PASS; independent vertex pairings for even subgraphs at L=1,2")
