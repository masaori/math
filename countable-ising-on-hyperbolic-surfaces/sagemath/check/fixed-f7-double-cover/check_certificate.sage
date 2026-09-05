# 有限入力判定。対象ラベル: def_oriented_closed_surface_cellulation
# コサイクルと余境界は本文の def_primal_first_cocycle_space_over_f2,
# def_primal_first_coboundary_space の行列規約に従う。
import hashlib
import json
from pathlib import Path

root = Path('countable-ising-on-hyperbolic-surfaces/sagemath/check')
base_path = root / 'fixed-f7-matrix-cellulation/certificate.json'
base_bytes = base_path.read_bytes()
base = json.loads(base_bytes)
ends = base['edge_endpoints']
words = base['face_boundary_words']
nv, ne, nf = (base['counts'][key] for key in ('vertices', 'edges', 'faces'))
assert (nv, ne, nf) == (24, 84, 56)
field = GF(2)
first = {'forward': 0, 'reverse': 1}
last = {'forward': 1, 'reverse': 0}
sign = {'forward': ZZ(1), 'reverse': ZZ(-1)}

def boundaries(vertex_count, endpoints, face_words):
    d1 = matrix(ZZ, vertex_count, len(endpoints))
    d2 = matrix(ZZ, len(endpoints), len(face_words))
    for edge, (source, target) in enumerate(endpoints):
        d1[source, edge] -= 1
        d1[target, edge] += 1
    for face, word in enumerate(face_words):
        for edge, orientation in word:
            d2[edge, face] += sign[orientation]
    assert d1*d2 == 0
    assert d1.change_ring(field)*d2.change_ring(field) == 0
    return d1, d2

d1, d2 = boundaries(nv, ends, words)
equations = d2.change_ring(field).transpose()
cocycles = equations.right_kernel()
coboundaries = d1.change_ring(field).row_space()
assert coboundaries.is_subspace(cocycles)
assert (cocycles.dimension(), coboundaries.dimension()) == (29, 23)

# 接頭辞を固定したアフィン解空間が余境界の外に元を持つかを厳密判定する。
# 全解 a+K が余境界内 ⇔ a と K の全基底が余境界内。
def completions(prefix):
    coords = identity_matrix(field, ne)[:len(prefix), :]
    system = equations.stack(coords)
    rhs = vector(field, [0]*nf + list(prefix))
    rank = system.rank()
    augmented_rank = system.augment(matrix(field, len(rhs), 1, list(rhs))).rank()
    record = {'rank': rank, 'augmented_rank': augmented_rank}
    if rank != augmented_rank:
        record['outside_coboundaries'] = False
        return record
    solution = system.solve_right(rhs)
    kernel = system.right_kernel()
    assert system*solution == rhs
    contained = solution in coboundaries and kernel.is_subspace(coboundaries)
    record.update({'solution': list(solution), 'kernel_basis': [list(v) for v in kernel.basis()],
                   'outside_coboundaries': not contained})
    return record

prefix, rejected_zero_prefixes = [], []
for coordinate in range(ne):
    zero_branch = completions(prefix + [0])
    if zero_branch['outside_coboundaries']:
        prefix.append(0)
    else:
        rejected_zero_prefixes.append({'prefix': prefix + [0], 'decision': zero_branch})
        prefix.append(1)
        assert completions(prefix)['outside_coboundaries']
c = vector(field, prefix)
assert c in cocycles and c not in coboundaries
assert equations*c == 0
# 非余境界性は、一次サイクルとの奇数ペアリングでも別途確認する。
cycle = next(z for z in d1.change_ring(field).right_kernel().basis() if c.dot_product(z) == 1)
assert d1.change_ring(field)*cycle == 0
assert c.dot_product(cycle) == 1

# 頂点・辺・面はそれぞれ別の役割の (base index, sheet) を 2*i+s へ符号化する。
# 辺の sheet は固定向きの始点での値。面の sheet は境界語の初期頂点での値。
lift_ends = [[2*u+s, 2*v+((s+prefix[edge]) % 2)]
             for edge, (u, v) in enumerate(ends) for s in range(2)]
lift_words = []
for face, word in enumerate(words):
    assert sum(c[edge] for edge, orientation in word) == 0
    for sheet in range(2):
        current = sheet
        lifted = []
        for edge, orientation in word:
            edge_sheet = current if orientation == 'forward' else (current+prefix[edge]) % 2
            lifted.append([2*edge+edge_sheet, orientation])
            current = (current+prefix[edge]) % 2
        assert current == sheet
        lift_words.append(lifted)

def surface_certificate(vertex_count, endpoints, face_words):
    occurrences = [[] for edge in endpoints]
    corners = [[] for vertex in range(vertex_count)]
    for face, word in enumerate(face_words):
        assert len(word) == 3
        boundary_vertices = []
        for position, (edge, orientation) in enumerate(word):
            source = endpoints[edge][first[orientation]]
            target = endpoints[edge][last[orientation]]
            next_edge, next_orientation = word[(position+1) % len(word)]
            assert source != target
            assert target == endpoints[next_edge][first[next_orientation]]
            occurrences[edge].append([face, position, orientation])
            corners[target].append([[edge, last[orientation]], [next_edge, first[next_orientation]]])
            boundary_vertices.append(source)
        assert len(set(boundary_vertices)) == 3
        assert len({edge for edge, orientation in word}) == 3
    for occurrence in occurrences:
        assert len(occurrence) == 2
        assert occurrence[0][0] != occurrence[1][0]
        assert sorted(item[2] for item in occurrence) == ['forward', 'reverse']
    cycles = []
    for vertex, pairs in enumerate(corners):
        incident = {(edge, side) for edge, pair in enumerate(endpoints)
                    for side in range(2) if pair[side] == vertex}
        assert len(incident) == len(pairs) == 7
        neighbors = {end: [] for end in incident}
        for left, right in pairs:
            left, right = tuple(left), tuple(right)
            assert left != right
            neighbors[left].append(right)
            neighbors[right].append(left)
        assert all(len(items) == len(set(items)) == 2 for items in neighbors.values())
        circuit = [min(incident)]
        previous, current = circuit[0], min(neighbors[circuit[0]])
        while current != circuit[0]:
            assert current not in circuit
            circuit.append(current)
            following = [end for end in neighbors[current] if end != previous]
            assert len(following) == 1
            previous, current = current, following[0]
        assert set(circuit) == incident
        cycles.append(circuit)
    reached, frontier, tree = {0}, [0], []
    while frontier:
        source = frontier.pop()
        for edge, pair in enumerate(endpoints):
            if source in pair:
                target = pair[1] if pair[0] == source else pair[0]
                if target not in reached:
                    reached.add(target)
                    frontier.append(target)
                    tree.append([source, edge, target])
    assert reached == set(range(vertex_count))
    return {'edge_occurrences': occurrences, 'vertex_link_cycles': cycles,
            'vertex_corners': corners, 'spanning_tree': tree}

base_surface = surface_certificate(nv, ends, words)
cover_surface = surface_certificate(2*nv, lift_ends, lift_words)
assert base_surface['edge_occurrences'] == base['edge_occurrences']
assert base_surface['vertex_link_cycles'] == [list(map(tuple, circuit)) for circuit in base['vertex_link_cycles']]
assert base_surface['spanning_tree'] == base['spanning_tree']
projections = {role: [i//2 for i in range(2*count)]
               for role, count in (('vertex', nv), ('edge', ne), ('face', nf))}
for role, projection in projections.items():
    assert all(projection.count(i) == 2 for i in set(projection))
# 端点・面の各位置・辺の二面接続・頂点の全リンクを射影で照合する。
for edge, pair in enumerate(lift_ends):
    assert [v//2 for v in pair] == ends[edge//2]
    projected = [[face//2, pos, ori] for face, pos, ori in cover_surface['edge_occurrences'][edge]]
    assert sorted(projected) == sorted(base_surface['edge_occurrences'][edge//2])
for face, word in enumerate(lift_words):
    assert [[edge//2, ori] for edge, ori in word] == words[face//2]
for vertex, circuit in enumerate(cover_surface['vertex_link_cycles']):
    projected = [(edge//2, side) for edge, side in circuit]
    assert len(set(projected)) == 7
    assert set(projected) == set(base_surface['vertex_link_cycles'][vertex//2])
    projected_corners = sorted([[[edge//2, side] for edge, side in pair]
                                for pair in cover_surface['vertex_corners'][vertex]])
    assert projected_corners == sorted(base_surface['vertex_corners'][vertex//2])

lift_d1, lift_d2 = boundaries(2*nv, lift_ends, lift_words)
def projection_matrix(count):
    return matrix(ZZ, count, 2*count, lambda i, j: ZZ(i == j//2))
p0, p1, p2 = (projection_matrix(count) for count in (nv, ne, nf))
assert p0*lift_d1 == d1*p1
assert p1*lift_d2 == d2*p2
assert p0.change_ring(field)*lift_d1.change_ring(field) == d1.change_ring(field)*p1.change_ring(field)
assert p1.change_ring(field)*lift_d2.change_ring(field) == d2.change_ring(field)*p2.change_ring(field)
# sheet 反転はセル射影上の不動点のない対合で、端点と境界語を保つ。
def swap(index):
    return 2*(index//2)+(1-index % 2)
for edge, pair in enumerate(lift_ends):
    assert [swap(v) for v in pair] == lift_ends[swap(edge)]
for face, word in enumerate(lift_words):
    assert [[swap(edge), ori] for edge, ori in word] == lift_words[swap(face)]
for projection in projections.values():
    for index in range(len(projection)):
        assert swap(index) != index and swap(swap(index)) == index
        assert projection[swap(index)] == projection[index]
assert (len(lift_ends), len(lift_words)) == (168, 112)
assert ZZ(2*nv)-ZZ(len(lift_ends))+ZZ(len(lift_words)) == -8

certificate = {
    'base_certificate_sha256': hashlib.sha256(base_bytes).hexdigest(),
    'cohomology': {'cocycle_dimension': cocycles.dimension(), 'coboundary_dimension': coboundaries.dimension(),
                   'representative': prefix, 'rejected_zero_prefixes': rejected_zero_prefixes,
                   'odd_pairing_cycle': list(cycle)},
    'counts': {'vertices': 2*nv, 'edges': len(lift_ends), 'faces': len(lift_words)},
    'edge_endpoints': lift_ends, 'face_boundary_words': lift_words,
    'cell_projections': projections, 'surface': cover_surface,
    'regular_type': [3, 7], 'euler_characteristic': -8,
    'integer_chain_map': True, 'mod_two_chain_map': True,
    'locally_bijective': True, 'connected': True, 'cover_degree': 2,
}
def encode(value):
    if isinstance(value, (Integer, type(field(0)))):
        return int(value)
    raise TypeError('unsupported certificate type: ' + type(value).__name__)
serialized = json.dumps(certificate, ensure_ascii=False, indent=2, default=encode) + '\n'
output = root / 'fixed-f7-double-cover/certificate.json'
if output.exists():
    assert output.read_text() == serialized, 'stored certificate differs from recomputation'
else:
    output.write_text(serialized)
print('RESULT: PASS — lexicographically least non-coboundary cocycle; connected degree-two cover; 48 vertices, 168 edges, 112 faces; local bijections; integer and F2 chain maps; certificate reproduced')
