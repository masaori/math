# 有限入力判定。対象ラベル: def_oriented_closed_surface_cellulation
# 行列の符号同値類は辞書式最小代表、セルは役割付き剰余類で符号化する。
import json
from pathlib import Path

field = GF(7)
A = matrix(field, [[0, -1], [1, 0]])
B = matrix(field, [[0, -1], [1, 1]])
I2 = identity_matrix(field, 2)

def key(M):
    return tuple(int(x) for x in M.list())

def canonical(M):
    return min(key(M), key(-M))

def product(g, h):
    return canonical(matrix(field, 2, 2, g) * matrix(field, 2, 2, h))

identity = canonical(I2)
a, b = canonical(A), canonical(B)
assert A.det() == B.det() == 1
assert A**2 == B**3 == -I2
# 閉包を実際に生成し、中心 ±I の各二元軌道と照合する。
raw = {key(I2)}
frontier = [key(I2)]
while frontier:
    g = frontier.pop()
    for M in (A, B):
        h = key(matrix(field, 2, 2, g) * M)
        if h not in raw:
            raw.add(h)
            frontier.append(h)
assert len(raw) == 336
assert key(-I2) in raw
assert all(key(-matrix(field, 2, 2, g)) in raw for g in raw)
group = sorted({canonical(matrix(field, 2, 2, g)) for g in raw})
assert len(group) == 168
indices = {g: i for i, g in enumerate(group)}
for g in group:
    for h in (a, b):
        M, N = matrix(field, 2, 2, g), matrix(field, 2, 2, h)
        assert canonical(M*N) == canonical((-M)*N) == canonical(M*(-N))

inverse = {g: canonical(matrix(field, 2, 2, g).inverse()) for g in group}
# R_h(g)=gh。本文の右側からの写像合成へは rho(h)=R_(h^-1) で移す。
right_actions = {name: [indices[product(g, h)] for g in group]
                 for name, h in (("A", a), ("B", b))}
for action in right_actions.values():
    assert sorted(action) == list(range(168))
f, v, e = b, product(inverse[b], a), a
rotations = {"face": f, "vertex": v, "edge": e}
rho = {name: [indices[product(g, inverse[h])] for g in group]
       for name, h in rotations.items()}
assert product(product(f, v), e) == identity
assert all(rho["face"][rho["vertex"][rho["edge"][i]]] == i for i in range(168))
for g in group:
    for h in rotations.values():
        for point in group:
            assert product(point, inverse[product(g, h)]) == product(product(point, inverse[h]), inverse[g])

def cyclic(h):
    result = [identity]
    current = h
    while current != identity:
        assert current not in result
        result.append(current)
        current = product(current, h)
    return result

stabilizers = {name: cyclic(h) for name, h in rotations.items()}
assert {name: len(H) for name, H in stabilizers.items()} == {"face": 3, "vertex": 7, "edge": 2}

def coset(g, role):
    return frozenset(product(g, h) for h in stabilizers[role])

cosets = {role: sorted({coset(g, role) for g in group}, key=lambda C: tuple(sorted(C)))
          for role in rotations}
cell_index = {role: {C: i for i, C in enumerate(cells)} for role, cells in cosets.items()}
lookup = {role: {g: cell_index[role][coset(g, role)] for g in group} for role in rotations}
vertices, edges, faces = (cosets[role] for role in ("vertex", "edge", "face"))
assert (len(vertices), len(edges), len(faces)) == (24, 84, 56)
endpoints = []
for C in edges:
    selected = min(C)
    endpoints.append([lookup["vertex"][selected], lookup["vertex"][product(selected, e)]])
assert all(source != target for source, target in endpoints)

words, positions = [], []
for C in faces:
    current = min(C)
    darts = []
    word = []
    for unused in range(3):
        darts.append(current)
        edge_index = lookup["edge"][current]
        selected = min(edges[edge_index])
        orientation = "forward" if selected == current else "reverse"
        assert selected in (current, product(current, e))
        word.append([edge_index, orientation])
        current = product(current, f)
    assert current == min(C) and set(darts) == set(C)
    words.append(word)
    positions.append([indices[g] for g in darts])

initial = {"forward": 0, "reverse": 1}
terminal = {"forward": 1, "reverse": 0}
occurrences = [[] for C in edges]
links = [[] for C in vertices]
for face_index, (word, darts) in enumerate(zip(words, positions)):
    boundary_vertices = []
    for position, (edge_index, orientation) in enumerate(word):
        g = group[darts[position]]
        start, end = endpoints[edge_index][initial[orientation]], endpoints[edge_index][terminal[orientation]]
        assert start == lookup["vertex"][g]
        assert end == lookup["vertex"][product(g, e)]
        next_edge, next_orientation = word[(position + 1) % 3]
        assert end == endpoints[next_edge][initial[next_orientation]]
        occurrences[edge_index].append([face_index, position, orientation])
        links[end].append([[edge_index, terminal[orientation]], [next_edge, initial[next_orientation]]])
        boundary_vertices.append(start)
    assert len(set(boundary_vertices)) == 3
    assert len({edge_index for edge_index, orientation in word}) == 3

for occurrence in occurrences:
    assert len(occurrence) == 2
    assert occurrence[0][0] != occurrence[1][0]
    assert sorted(item[2] for item in occurrence) == ["forward", "reverse"]

link_cycles = []
for vertex, corners in enumerate(links):
    incident = {(edge_index, side) for edge_index, ends in enumerate(endpoints)
                for side in range(2) if ends[side] == vertex}
    assert len(incident) == len(corners) == 7
    adjacency = {end: [] for end in incident}
    for left, right in corners:
        left, right = tuple(left), tuple(right)
        assert left != right
        adjacency[left].append(right)
        adjacency[right].append(left)
    assert all(len(neighbors) == 2 and len(set(neighbors)) == 2 for neighbors in adjacency.values())
    cycle = [min(incident)]
    previous, current = cycle[0], min(adjacency[cycle[0]])
    while current != cycle[0]:
        assert current not in cycle
        cycle.append(current)
        following = [end for end in adjacency[current] if end != previous]
        assert len(following) == 1
        previous, current = current, following[0]
    assert set(cycle) == incident
    link_cycles.append(cycle)

reached, frontier, spanning_tree = {0}, [0], []
while frontier:
    source = frontier.pop()
    for edge_index, ends in enumerate(endpoints):
        if source in ends:
            target = ends[1] if ends[0] == source else ends[0]
            if target not in reached:
                reached.add(target)
                frontier.append(target)
                spanning_tree.append([source, edge_index, target])
assert reached == set(range(24))
# 整数境界行列を作り、F_2 への還元後も別途照合する。
d1 = matrix(ZZ, 24, 84)
d2 = matrix(ZZ, 84, 56)
for edge_index, (source, target) in enumerate(endpoints):
    d1[source, edge_index] -= 1
    d1[target, edge_index] += 1
orientation_sign = {"forward": ZZ(1), "reverse": ZZ(-1)}
for face_index, word in enumerate(words):
    for edge_index, orientation in word:
        d2[edge_index, face_index] += orientation_sign[orientation]
assert d1*d2 == zero_matrix(ZZ, 24, 56)
assert d1.change_ring(GF(2))*d2.change_ring(GF(2)) == zero_matrix(GF(2), 24, 56)
assert 2*(3+7) < 3*7
assert ZZ(24)-ZZ(84)+ZZ(56) == -4
certificate = {
    "input": {"field": 7, "A": key(A), "B": key(B)},
    "matrix_group_order": len(raw), "quotient_representatives": group,
    "right_actions": right_actions, "rho_rotations": rho,
    "cell_cosets": {role: [[indices[g] for g in sorted(C)] for C in cells] for role, cells in cosets.items()},
    "edge_endpoints": endpoints, "face_positions": positions, "face_boundary_words": words,
    "edge_occurrences": occurrences, "vertex_link_cycles": link_cycles,
    "spanning_tree": spanning_tree,
    "counts": {"vertices": 24, "edges": 84, "faces": 56},
    "euler_characteristic": -4, "regular_type": [3, 7],
    "integer_boundary_squared_zero": True, "mod_two_boundary_squared_zero": True,
}
def encode_integer(value):
    if isinstance(value, Integer):
        return int(value)
    raise TypeError("unsupported certificate type: " + type(value).__name__)

serialized = json.dumps(certificate, ensure_ascii=False, indent=2, default=encode_integer) + "\n"
output = Path("countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-f7-matrix-cellulation/certificate.json")
if output.exists():
    assert output.read_text() == serialized, "stored certificate differs from recomputation"
else:
    output.write_text(serialized)
print("RESULT: PASS — fixed F7 matrices: quotient order 168; 24 vertices, 84 edges, 56 faces; oriented closed regular type {3,7}; integer and F2 boundary squared zero; certificate reproduced")
