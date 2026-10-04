# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 帰属: Z/2Z、NN、ZZ。配位から作らず、全辺部分集合から A を選び B と t を構成する。
import os

_rc_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_rc_dir, '../../_shared/defs.sage'))
_rc_ring = Integers(2)


def _rc_s2(q):
    return NN(_rc_ring(q).lift())


def _rc_dual(L, edge):
    if edge <= L * L:
        i, j = divmod(edge - 1, L)
        return edge_number_vertical(L, i, j + 1)
    i, j = divmod(edge - L * L - 1, L)
    return edge_number_horizontal(L, i + 1, j)


def _rc_trivial_subsets(L):
    numbers = tuple(range(1, 2 * L * L + 1))
    incidence_masks = {vertex: int(0) for vertex in vertices(L)}
    for bit, edge in enumerate(numbers):
        for vertex in endpoints(L, edge):
            # 自己ループは同じ頂点へ二度寄与し、偶奇では相殺する。
            incidence_masks[vertex] = incidence_masks[vertex].__xor__(int(1) << int(bit))
    cuts = (
        {edge_number_horizontal(L, i, -1) for i in range(L)},
        {edge_number_vertical(L, -1, j) for j in range(L)},
    )
    cut_masks = [sum(int(1) << int(edge - 1) for edge in cut) for cut in cuts]
    constraints = tuple(incidence_masks.values()) + tuple(cut_masks)
    for mask in range(int(1) << int(len(numbers))):
        if all((int(mask) & int(constraint)).bit_count() % 2 == 0
               for constraint in constraints):
            yield frozenset(edge for edge in numbers if mask & (int(1) << int(edge - 1)))


def _rc_build_case(L, A):
    numbers = tuple(range(1, 2 * L * L + 1))
    B = frozenset(edge for edge in numbers if _rc_dual(L, edge) in A)
    bh = {(i, j): _rc_ring(NN(edge_number_horizontal(L, i, j) in B))
          for i, j in vertices(L)}
    bv = {(i, j): _rc_ring(NN(edge_number_vertical(L, i, j) in B))
          for i, j in vertices(L)}
    t = {(i, j): sum((bv[(projection(L, r), 0)] for r in range(representative(L, i))),
                     _rc_ring(0)) +
                   sum((bh[(i, projection(L, c))] for c in range(representative(L, j))),
                       _rc_ring(0))
         for i, j in vertices(L)}
    sigma = {vertex: ZZ(-1) ** _rc_s2(t[vertex]) for vertex in vertices(L)}
    broken = frozenset(edge for edge in numbers
                       if sigma[endpoints(L, edge)[0]] != sigma[endpoints(L, edge)[1]])
    vertical_rows = []
    for i, j in vertices(L):
        m = representative(L, j)
        vertical_rows.append({
            'i': i, 'j': j,
            'difference': t[((i + 1) % L, j)] + t[(i, j)],
            'expanded': bv[(i, 0)] + sum(
                (bh[((i + 1) % L, projection(L, c))] + bh[(i, projection(L, c))]
                 for c in range(m)), _rc_ring(0)),
            'face': bv[(i, 0)] + sum(
                (bv[(i, projection(L, c + 1))] + bv[(i, projection(L, c))]
                 for c in range(m)), _rc_ring(0)),
            'endpoints': bv[(i, 0)] +
                         (bv[(i, projection(L, m))] + bv[(i, projection(L, 0))]),
            'terminal': bv[(i, 0)] + (bv[(i, j)] + bv[(i, projection(L, 0))]),
            'zero': bv[(i, 0)] + (bv[(i, j)] + bv[(i, 0)]),
            'target': bv[(i, j)],
        })
    edge_rows = []
    for edge in numbers:
        v, w = endpoints(L, edge)
        edge_rows.append({
            'member': edge in broken,
            'spins': sigma[v] != sigma[w],
            'powers': ZZ(-1) ** _rc_s2(t[v]) != ZZ(-1) ** _rc_s2(t[w]),
            'parity': t[v] + t[w] == _rc_ring(1),
            'original': edge in B,
        })
    return {'L': L, 'A': A, 'B': B, 'bh': bh, 'bv': bv, 't': t, 'sigma': sigma,
            'vertical': vertical_rows, 'edges': edge_rows,
            'dual_broken': frozenset(_rc_dual(L, edge) for edge in broken),
            'dual_B': frozenset(_rc_dual(L, edge) for edge in B)}


if '_rc_cases' not in globals():
    _rc_cases = [_rc_build_case(L, A) for L in (1, 2, 3) for A in _rc_trivial_subsets(L)]


def _rc_check_vertical(left, right, label, interior=False):
    checked = 0
    for case in _rc_cases:
        for row in case['vertical']:
            if interior and row['i'] == case['L'] - 1:
                continue
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked += 1
    print("RESULT: PASS (%s: %d 頂点)" % (label, checked))


def _rc_check_edges(left, right, label):
    checked = 0
    for case in _rc_cases:
        for row in case['edges']:
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked += 1
    print("RESULT: PASS (%s: %d 辺)" % (label, checked))
