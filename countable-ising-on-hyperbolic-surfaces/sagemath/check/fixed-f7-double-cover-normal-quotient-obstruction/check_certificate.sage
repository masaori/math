# 固定被覆の正規商入力への適合判定。対象ラベル: def_two_stage_finite_quotient_tower_input
import hashlib
import json
from pathlib import Path

root = Path('countable-ising-on-hyperbolic-surfaces/sagemath/check')
base_bytes = (root / 'fixed-f7-matrix-cellulation/certificate.json').read_bytes()
cover_bytes = (root / 'fixed-f7-double-cover/certificate.json').read_bytes()
base, cover = json.loads(base_bytes), json.loads(cover_bytes)
assert cover['base_certificate_sha256'] == hashlib.sha256(base_bytes).hexdigest()
field = GF(7)
reps = [tuple(x) for x in base['quotient_representatives']]
index = {x: i for i, x in enumerate(reps)}

def canonical(M):
    return min(tuple(int(x) for x in M.list()), tuple(int(x) for x in (-M).list()))

def product(x, y):
    return canonical(matrix(field, 2, 2, x) * matrix(field, 2, 2, y))

# 指定入力の辺役割元 A の左乗算。右乗算によるセル生成とは役割を分ける。
a = canonical(matrix(field, 2, 2, base['input']['A']))
left = [index[product(a, x)] for x in reps]
assert sorted(left) == list(range(len(reps)))
assert all(left[left[i]] == i for i in range(len(reps)))
for right in base['right_actions'].values():
    assert all(left[right[i]] == right[left[i]] for i in range(len(reps)))
cell_maps = {}
for role, cells in base['cell_cosets'].items():
    lookup = {frozenset(cell): i for i, cell in enumerate(cells)}
    cell_maps[role] = [lookup[frozenset(left[x] for x in cell)] for cell in cells]
    assert sorted(cell_maps[role]) == list(range(len(cells)))
ends, words = base['edge_endpoints'], base['face_boundary_words']
vertex_map, edge_map, face_map = (cell_maps[role] for role in ('vertex', 'edge', 'face'))
reversed_edges = []
for edge, (u, v) in enumerate(ends):
    image = [vertex_map[u], vertex_map[v]]
    assert sorted(image) == sorted(ends[edge_map[edge]])
    reversed_edges.append(image != ends[edge_map[edge]])
opposite = {'forward': 'reverse', 'reverse': 'forward'}
face_shifts = []
for face, word in enumerate(words):
    image = [[edge_map[e], opposite[o] if reversed_edges[e] else o] for e, o in word]
    target = words[face_map[face]]
    shifts = [i for i in range(3) if image == target[i:] + target[:i]]
    assert len(shifts) == 1
    face_shifts.append(shifts[0])

binary = GF(2)
d1 = matrix(binary, len(base['cell_cosets']['vertex']), len(ends))
d2 = matrix(binary, len(ends), len(words))
for edge, (u, v) in enumerate(ends):
    d1[u, edge] += 1
    d1[v, edge] += 1
for face, word in enumerate(words):
    for edge, orientation in word:
        d2[edge, face] += 1
assert d1*d2 == 0
c = vector(binary, cover['cohomology']['representative'])
pulled = vector(binary, [c[edge_map[e]] for e in range(len(ends))])
difference = c + pulled
assert d2.transpose()*c == 0
assert d2.transpose()*pulled == 0
# 頂点シート交換 t が存在するための必要条件 d1^T t = c + a^*c。
system = d1.transpose()
rank = system.rank()
augmented_rank = system.augment(matrix(binary, len(ends), 1, list(difference))).rank()
assert rank == 23 and augmented_rank == 24
assert difference not in d1.row_space()
cycle = next(z for z in d1.right_kernel().basis() if difference.dot_product(z) == 1)
assert d1*cycle == 0
assert c.dot_product(cycle) == 1
assert pulled.dot_product(cycle) == 0
assert difference.dot_product(cycle) == 1
# 方程式の必要性を、端点シートの全二値組と全基底辺で照合する。
for edge, (u, v) in enumerate(ends):
    for sheet in binary:
        for tu in binary:
            for tv in binary:
                endpoint_condition = (sheet + c[edge] + tv == sheet + tu + c[edge_map[edge]])
                assert endpoint_condition == (tu + tv == difference[edge])

certificate = {
    'base_certificate_sha256': hashlib.sha256(base_bytes).hexdigest(),
    'cover_certificate_sha256': hashlib.sha256(cover_bytes).hexdigest(),
    'base_automorphism_matrix': list(a),
    'left_action_on_group_indices': left,
    'cell_maps': cell_maps,
    'reversed_edges': reversed_edges,
    'face_position_shifts': face_shifts,
    'cocycle': list(c), 'pullback_cocycle': list(pulled),
    'difference_cocycle': list(difference),
    'sheet_equation_rank': rank, 'sheet_equation_augmented_rank': augmented_rank,
    'obstruction_cycle': list(cycle),
    'cycle_support': [e for e in range(len(ends)) if cycle[e] != 0],
    'cycle_pairings': {'cocycle': c.dot_product(cycle), 'pullback': pulled.dot_product(cycle),
                       'difference': difference.dot_product(cycle)},
    'base_automorphism_lifts': False,
    'compatible_normal_quotient_tower': False,
}
def encode(value):
    if isinstance(value, (Integer, type(binary(0)))):
        return int(value)
    raise TypeError('unsupported certificate type: ' + type(value).__name__)
serialized = json.dumps(certificate, ensure_ascii=False, indent=2, default=encode) + '\n'
output = root / 'fixed-f7-double-cover-normal-quotient-obstruction/certificate.json'
if output.exists():
    assert output.read_text() == serialized, 'stored certificate differs from recomputation'
else:
    output.write_text(serialized)
print('RESULT: PASS — normal quotient compatibility rejected; base A action does not lift; sheet equation ranks 23 < 24; cycle pairings 1 and 0; certificate reproduced')
