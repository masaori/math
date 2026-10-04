# 対象ラベル: claim_dual_broken_edges_winding_zero
# 帰属: 有限集合と ZZ の非負整数。双対写像と逆写像を独立に構成する。
import os
import sys
winding_entry = sys.argv[0] if sys.argv[0].endswith('.sage') else __file__
winding_directory = os.path.dirname(os.path.abspath(winding_entry))
load(os.path.join(winding_directory, '../../_shared/defs.sage'))

winding_lattice_rows = []
for L in (1, 2, 3):
    edges = tuple(range(1, 2*L*L+1))
    dual_map = {}
    for i in range(L):
        for j in range(L):
            dual_map[edge_number_horizontal(L, i, j)] = edge_number_vertical(L, i, j+1)
            dual_map[edge_number_vertical(L, i, j)] = edge_number_horizontal(L, i+1, j)
    inverse_map = {dual: primal for primal, dual in dual_map.items()}
    for sigma in configurations(L):
        broken = frozenset(e for e in edges if sigma[endpoints(L, e)[0]] != sigma[endpoints(L, e)[1]])
        dual_broken = frozenset(dual_map[e] for e in broken)
        for direction in ('horizontal', 'vertical'):
            if direction == 'horizontal':
                boundary = tuple(edge_number_horizontal(L, i, L-1) for i in range(L))
                primal_shift = tuple(edge_number_vertical(L, i-1, L-1) for i in range(L))
                primal = tuple(edge_number_vertical(L, i, L-1) for i in range(L))
                points = tuple((i, L-1) for i in range(L))
                next_points = tuple(((i+1) % L, L-1) for i in range(L))
            else:
                boundary = tuple(edge_number_vertical(L, L-1, j) for j in range(L))
                primal_shift = tuple(edge_number_horizontal(L, L-1, j-1) for j in range(L))
                primal = tuple(edge_number_horizontal(L, L-1, j) for j in range(L))
                points = tuple((L-1, j) for j in range(L))
                next_points = tuple((L-1, (j+1) % L) for j in range(L))
            inverse = tuple(inverse_map[e] for e in boundary)
            winding_lattice_rows.append((L, sigma, broken, dual_broken, boundary,
                inverse, primal_shift, primal, points, next_points))
