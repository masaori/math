# 対象ラベル: claim_vertex_port_bijection
from itertools import combinations


for length in (1, 2, 3):
    vertices = [(i, j) for i in range(length) for j in range(length)]
    edges = [(axis, i, j) for axis in (0, 1)
             for i, j in vertices]
    ports = []
    for axis, i, j in edges:
        for endpoint in (0, 1):
            if axis == 0:
                source = (i, (j + endpoint) % length)
            else:
                source = ((i + endpoint) % length, j)
            direction = axis + 2 * endpoint
            ports.append(((axis, i, j), endpoint, source, direction))
    for vertex in vertices:
        at_vertex = [port for port in ports if port[2] == vertex]
        assert len(at_vertex) == 4
        assert {port[3] for port in at_vertex} == {0, 1, 2, 3}
        for count in range(5):
            for subset in combinations(at_vertex, count):
                selected_edges = {port[0] for port in subset}
                selected = [port for port in at_vertex if port[0] in selected_edges]
                selected_directions = {port[3] for port in selected}
                assert len(selected_directions) == len(selected)
                assert all(any(port[3] == d for port in selected)
                           for d in selected_directions)
    if length == 1:
        assert len({port[0] for port in ports}) == 2
        assert len(ports) == 4

print("RESULT: PASS; vertex ports and selected restrictions for L=1,2,3")
