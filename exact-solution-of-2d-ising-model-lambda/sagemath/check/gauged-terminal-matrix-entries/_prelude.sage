# 座標は有限集合、係数は Q(zeta_8)、成分はその一変数多項式環。
import os
_gt_dir = os.path.dirname(os.path.abspath(__file__))
load('sagemath/_shared/defs.sage')
load(os.path.join(_gt_dir, '../diagonal-gauge-inverse/construction.sage'))

_gt_ring = PolynomialRing(_dg_field, 'x')
_gt_x = _gt_ring.gen()

def _gt_source(L, edge):
    return endpoints(L, edge[0])[edge[1]]

def _gt_target(L, edge):
    return endpoints(L, edge[0])[1 - edge[1]]

def _gt_reverse(edge):
    return (edge[0], 1 - edge[1])

def _gt_twist(L, a, b, edge):
    horizontal = edge[0] <= L * L
    index = edge[0] - 1 if horizontal else edge[0] - L * L - 1
    row, column = divmod(index, L)
    return ZZ(-1) ** (a * ZZ(horizontal and column == L - 1)
                       + b * ZZ(not horizontal and row == L - 1))

def _gt_phase(z, directions, i, j):
    return {0: _dg_field(1), 1: z, 3: z ** (-1)}.get(
        (directions[j] - directions[i]) % 4, _dg_field(0))

def _gt_representatives(values):
    seen = set()
    result = []
    for i, value in enumerate(values):
        if value not in seen:
            seen.add(value)
            result.append(i)
    return result

_gt_cases = []
for L in (1, 2, 3):
    for a, b in product((0, 1), repeat=2):
        for root_power in (1, 3, 5, 7):
            case = diagonal_gauge_case(L, a, b, root_power)
            edges, dirs, z = case['edges'], case['directions'], case['z']
            n = len(edges)
            rev = [edges.index(_gt_reverse(e)) for e in edges]
            eps = [_gt_twist(L, a, b, e) for e in edges]
            M = matrix(_dg_field, n, lambda i, j:
                eps[j] * _gt_phase(z, dirs, i, j)
                if _gt_target(L, edges[i]) == _gt_source(L, edges[j])
                   and edges[j] != _gt_reverse(edges[i]) else 0)
            J = matrix(_gt_ring, n, lambda i, j: ZZ(j == rev[i]))
            K = identity_matrix(_gt_ring, n) - _gt_x * M.change_ring(_gt_ring)
            A = J * K
            Ux, Vx = case['U'].change_ring(_gt_ring), case['V'].change_ring(_gt_ring)
            B = Vx * A
            right = B * Ux
            transformed = _gt_ring(z ** 2) * right
            left_sums = matrix(_gt_ring, n, lambda i, j:
                sum((Vx[i, g] * A[g, j] for g in range(n)), _gt_ring(0)))
            right_sums = matrix(_gt_ring, n, lambda i, j:
                sum((B[i, g] * Ux[g, j] for g in range(n)), _gt_ring(0)))
            long = matrix(_gt_ring, n, lambda i, j: ZZ(j == rev[i]))
            short = matrix(_gt_ring, n, lambda i, j:
                _gt_ring(eps[j] * _gt_phase(z, dirs, rev[i], j))
                if _gt_source(L, edges[j]) == _gt_source(L, edges[i]) and i != j else 0)
            expected = matrix(_gt_ring, n, lambda i, j:
                _gt_ring(z ** 2 * (case['vs'][i] * case['us'][j]))
                * (long[i, j] - _gt_x * short[i, j]))
            case.update(n=n, rev=rev, eps=eps, A=A, Ux=Ux, Vx=Vx, B=B,
                right=right, transformed=transformed, left_sums=left_sums,
                right_sums=right_sums, long=long, short=short, expected=expected,
                row_representatives=[_gt_representatives(A.row(g)) for g in range(n)],
                column_representatives=[_gt_representatives(B.column(g)) for g in range(n)])
            _gt_cases.append(case)

def _gt_zero_chain(case, group, i, j, g):
    C = _gt_ring
    if group == 'left_zero':
        A, V, Vx = case['A'], case['V'], case['Vx']
        return (Vx[i, g] * A[g, j], C(V[i, g]) * A[g, j],
                C(_dg_field(0)) * A[g, j], C.zero() * A[g, j], C.zero())
    B, U, Ux = case['B'], case['U'], case['Ux']
    return (B[i, g] * Ux[g, j], B[i, g] * C(U[g, j]),
            B[i, g] * C(_dg_field(0)), B[i, g] * C.zero(), C.zero())

def _gt_entry_chain(case, group, i, j):
    C = _gt_ring
    A, B, U, V, Ux, Vx = (case[key] for key in ('A', 'B', 'U', 'V', 'Ux', 'Vx'))
    u, v, c = case['us'][j], case['vs'][i], case['z'] ** 2
    w = c * (v * u)
    if group == 'left_entry':
        return (B[i, j], case['left_sums'][i, j], Vx[i, i] * A[i, j],
                C(V[i, i]) * A[i, j], C(v) * A[i, j])
    if group == 'right_entry':
        return (case['right'][i, j], case['right_sums'][i, j],
                B[i, j] * Ux[j, j], B[i, j] * C(U[j, j]), B[i, j] * C(u))
    entry = A[i, j]
    return (case['transformed'][i, j], C(c) * case['right'][i, j],
            C(c) * (B[i, j] * C(u)), C(c) * ((C(v) * entry) * C(u)),
            C(c) * (C(v) * (entry * C(u))), C(c) * (C(v) * (C(u) * entry)),
            C(c) * ((C(v) * C(u)) * entry), (C(c) * (C(v) * C(u))) * entry,
            (C(c) * C(v * u)) * entry, C(c * (v * u)) * entry, C(w) * entry,
            C(w) * (case['long'][i, j] - _gt_x * case['short'][i, j]))

def _gt_check(group, step, name):
    count = 0
    for case in _gt_cases:
        n = case['n']
        if group == 'left_zero':
            indices = ((i, j, g) for i in range(n) for g in range(n) if g != i
                       for j in case['row_representatives'][g])
        elif group == 'right_zero':
            indices = ((i, j, g) for j in range(n) for g in range(n) if g != j
                       for i in case['column_representatives'][g])
        else:
            indices = ((i, j, None) for i in range(n) for j in range(n))
        for i, j, g in indices:
            values = (_gt_zero_chain(case, group, i, j, g) if g is not None
                      else _gt_entry_chain(case, group, i, j))
            assert values[step] == values[step + 1], (name, case['L'], case['a'], case['b'],
                                                      case['root_power'], i, j, g)
            count += 1
    assert count > 0
    print('PASS %s: %s equations' % (name, count))
