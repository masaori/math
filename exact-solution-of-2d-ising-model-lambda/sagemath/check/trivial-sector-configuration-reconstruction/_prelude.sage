# 対象ラベル: claim_trivial_sector_configuration_reconstruction

def _rc_horizontal_boundary_rows(case):
    L = case['L']
    coordinates = Integers(L)
    zero = _rc_ring.zero()
    for i in range(L):
        j = L - 1
        m = representative(L, j)
        P = sum((case['bv'][(projection(L, r), 0)] for r in range(representative(L, i))), zero)
        H = lambda n: sum((case['bh'][(i, projection(L, c))] for c in range(n)), zero)
        a = case['bh'][(i, projection(L, m))]
        following = representative(L, coordinates(j) + coordinates(1))
        yield {
            'coordinate': (
                coordinates(j) + coordinates.one(),
                coordinates(m) + coordinates.one(),
                coordinates(m) + coordinates(1),
                coordinates(m + 1),
                coordinates(L),
                coordinates.zero(),
            ),
            'representative': (
                following,
                representative(L, coordinates.zero()),
                NN(0),
            ),
            'period': (
                H(L),
                sum((case['bh'][(i, projection(L, c))] for c in range(L)), zero),
                sum((case['bh'][(i, ZZ(k))] for k in coordinates), zero),
                zero,
            ),
            'prefix': (
                H(m),
                H(m) + zero,
                H(m) + (a + a),
                (H(m) + a) + a,
                H(m + 1) + a,
                H(L) + a,
                zero + a,
                a,
            ),
            'difference': (
                case['t'][(i, projection(L, j + 1))] + case['t'][(i, j)],
                (P + H(following)) + (P + H(m)),
                (P + H(0)) + (P + H(m)),
                (P + zero) + (P + H(m)),
                P + (P + H(m)),
                (P + P) + H(m),
                zero + H(m),
                H(m),
                a,
                case['bh'][(i, j)],
            ),
        }


def _rc_check_horizontal_boundary(section, left, right, label):
    checked = {1: 0, 2: 0, 3: 0}
    for case in _rc_cases:
        for rows in _rc_horizontal_boundary_rows(case):
            row = rows[section]
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked[case['L']] += 1
    assert checked == {1: 1, 2: 16, 3: 768}, checked
    print('RESULT: PASS (%s: %d 等式、横辺の周期境界)' % (label, sum(checked.values())))


def _rc_horizontal_interior_rows(case):
    L = case['L']
    coordinates = Integers(L)
    zero = _rc_ring.zero()
    for i, j in vertices(L):
        m = representative(L, j)
        if m + 1 >= L:
            continue
        P = sum((case['bv'][(projection(L, r), 0)] for r in range(representative(L, i))), zero)
        H = lambda n: sum((case['bh'][(i, projection(L, c))] for c in range(n)), zero)
        f = lambda c: case['bh'][(i, projection(L, c))]
        following = representative(L, coordinates(j) + coordinates(1))
        yield {
            'projection': (
                coordinates(m + 1),
                coordinates(m) + coordinates(1),
                coordinates(j) + coordinates(1),
                coordinates(j) + coordinates.one(),
            ),
            'representative': (
                following,
                representative(L, coordinates(m + 1)),
                m + 1,
            ),
            'difference': (
                case['t'][(i, projection(L, j + 1))] + case['t'][(i, j)],
                (P + H(following)) + (P + H(m)),
                (P + H(m + 1)) + (P + H(m)),
                (P + (H(m) + f(m))) + (P + H(m)),
                ((P + H(m)) + f(m)) + (P + H(m)),
                (P + H(m)) + (f(m) + (P + H(m))),
                (P + H(m)) + ((P + H(m)) + f(m)),
                ((P + H(m)) + (P + H(m))) + f(m),
                zero + f(m),
                f(m),
                case['bh'][(i, j)],
            ),
        }


def _rc_check_horizontal_interior(section, left, right, label):
    checked = {1: 0, 2: 0, 3: 0}
    for case in _rc_cases:
        for rows in _rc_horizontal_interior_rows(case):
            row = rows[section]
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked[case['L']] += 1
    assert checked == {1: 0, 2: 16, 3: 1536}, checked
    print('RESULT: PASS (%s: %d 等式、周期境界を除く)' % (label, sum(checked.values())))

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


def _rc_inverse_dual(L, edge):
    if edge <= L * L:
        i, j = divmod(edge - 1, L)
        return edge_number_vertical(L, i - 1, j)
    i, j = divmod(edge - L * L - 1, L)
    return edge_number_horizontal(L, i, j - 1)


def _rc_opening_rows(case):
    L, A, B = case['L'], case['A'], case['B']
    a = lambda edge: NN(edge in A)
    q = lambda edge: NN(edge in B)
    faces = []
    for i, j in vertices(L):
        vertex = (projection(L, i + 1), projection(L, j + 1))
        pairs = {(edge, endpoint) for edge in A for endpoint in (0, 1)
                 if endpoints(L, edge)[endpoint] == vertex}
        count = NN(len(pairs))
        count_sum = sum((NN(1) for edge in A for endpoint in (0, 1)
                         if endpoints(L, edge)[endpoint] == vertex), NN(0))
        incident_edges = (edge_number_horizontal(L, i + 1, j + 1),
                          edge_number_horizontal(L, i + 1, j),
                          edge_number_vertical(L, i + 1, j + 1),
                          edge_number_vertical(L, i, j + 1))
        inverse_edges = (edge_number_vertical(L, i, j + 1),
                         edge_number_vertical(L, i, j),
                         edge_number_horizontal(L, i + 1, j),
                         edge_number_horizontal(L, i, j))
        ordered_edges = (edge_number_vertical(L, i, j),
                         edge_number_horizontal(L, i, j),
                         edge_number_vertical(L, i, j + 1),
                         edge_number_horizontal(L, i + 1, j))
        ordered = sum((q(edge) for edge in ordered_edges), NN(0))
        faces.append({
            'incidence': count,
            'definition': count_sum,
            'incident': sum((a(edge) for edge in incident_edges), NN(0)),
            'preimage': sum((q(_rc_inverse_dual(L, edge)) for edge in incident_edges), NN(0)),
            'inverse': sum((q(edge) for edge in inverse_edges), NN(0)),
            'ordered': ordered,
            'face': case['bv'][(i, j)] + case['bh'][(i, j)] +
                    case['bv'][(i, projection(L, j + 1))] +
                    case['bh'][(projection(L, i + 1), j)],
            'project_terms': sum((_rc_ring(q(edge)) for edge in ordered_edges), _rc_ring(0)),
            'project_sum': _rc_ring(ordered),
            'project_incidence': _rc_ring(count),
            'project_even': _rc_ring(2 * (count // 2)),
            'zero': _rc_ring(0),
        })
    cycles = {}
    for direction in ('vertical', 'horizontal'):
        if direction == 'vertical':
            source = tuple(edge_number_vertical(L, i, -1) for i in range(L))
            shifted = tuple(edge_number_vertical(L, i - 1, -1) for i in range(L))
            dual_cut = tuple(edge_number_horizontal(L, i, -1) for i in range(L))
            bhv = tuple(case['bv'][(i, projection(L, -1))] for i in range(L))
        else:
            source = tuple(edge_number_horizontal(L, -1, j) for j in range(L))
            shifted = tuple(edge_number_horizontal(L, -1, j - 1) for j in range(L))
            dual_cut = tuple(edge_number_vertical(L, -1, j) for j in range(L))
            bhv = tuple(case['bh'][(projection(L, -1), j)] for j in range(L))
        count = NN(len(A.intersection(set(dual_cut))))
        winding = NN(sum((a(edge) for edge in dual_cut), NN(0)) % 2)
        cycles[direction] = {
            'cycle': sum(bhv, _rc_ring(0)),
            'project_terms': sum((_rc_ring(q(edge)) for edge in source), _rc_ring(0)),
            'project_sum': _rc_ring(sum((q(edge) for edge in source), NN(0))),
            'shifted': _rc_ring(sum((q(edge) for edge in shifted), NN(0))),
            'preimage': _rc_ring(sum((q(_rc_inverse_dual(L, edge)) for edge in dual_cut), NN(0))),
            'image': _rc_ring(sum((a(edge) for edge in dual_cut), NN(0))),
            'count': _rc_ring(count),
            'remainder': _rc_ring(count % 2),
            'winding': _rc_ring(winding),
            'zero_cast': _rc_ring(NN(0)),
            'zero': _rc_ring(0),
        }
    return {'face': faces, **cycles}


_rc_opening = [_rc_opening_rows(case) for case in _rc_cases]


def _rc_check_opening(section, left, right, label):
    checked = 0
    for case, opening in zip(_rc_cases, _rc_opening):
        rows = opening[section] if section == 'face' else (opening[section],)
        for row in rows:
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked += 1
    print('RESULT: PASS (%s: %d 件)' % (label, checked))


def _rc_even_subsets(L):
    numbers = tuple(range(1, 2 * L * L + 1))
    incidence_masks = {vertex: int(0) for vertex in vertices(L)}
    for bit, edge in enumerate(numbers):
        for vertex in endpoints(L, edge):
            incidence_masks[vertex] = incidence_masks[vertex].__xor__(int(1) << int(bit))
    for mask in range(int(1) << int(len(numbers))):
        if all((int(mask) & int(constraint)).bit_count() % 2 == 0
               for constraint in incidence_masks.values()):
            yield frozenset(edge for edge in numbers if mask & (int(1) << int(edge - 1)))


def _rc_invariance_rows(L, A):
    B = frozenset(edge for edge in range(1, 2 * L * L + 1) if _rc_dual(L, edge) in A)
    bh = lambda i, j: _rc_ring(NN(edge_number_horizontal(L, i, j) in B))
    bv = lambda i, j: _rc_ring(NN(edge_number_vertical(L, i, j) in B))
    zero = _rc_ring(0)
    local_row, local_column = [], []
    for i, j in vertices(L):
        v, h, vs, hs = bv(i, j), bh(i, j), bv(i, j + 1), bh(i + 1, j)
        alpha, beta, gamma, delta = v, h, vs, hs
        row_rest = (alpha + beta) + gamma
        column_rest = (alpha + beta) + delta
        local_row.append((hs, delta, delta + zero, delta + (row_rest + row_rest),
                          (delta + row_rest) + row_rest,
                          (((alpha + beta) + gamma) + delta) + row_rest,
                          zero + row_rest, row_rest, (v + h) + vs))
        local_column.append((vs, gamma, gamma + zero, gamma + (column_rest + column_rest),
                             (gamma + column_rest) + column_rest,
                             ((gamma + (alpha + beta)) + delta) + column_rest,
                             (((alpha + beta) + gamma) + delta) + column_rest,
                             zero + column_rest, column_rest, (v + h) + hs))
    row_sum, column_sum = [], []
    for i in range(L):
        sv = sum((bv(i, j) for j in range(L)), zero)
        sh = sum((bh(i, j) for j in range(L)), zero)
        shifted = sum((bv(i, j + 1) for j in range(L)), zero)
        row_sum.append((
            sum((bh(i + 1, j) for j in range(L)), zero),
            sum(((bv(i, j) + bh(i, j)) + bv(i, j + 1) for j in range(L)), zero),
            sum((bv(i, j) + bh(i, j) for j in range(L)), zero) + shifted,
            (sv + sh) + shifted, (sv + sh) + sv, sv + (sh + sv),
            sv + (sv + sh), (sv + sv) + sh, zero + sh, sh))
    for j in range(L):
        sv = sum((bv(i, j) for i in range(L)), zero)
        sh = sum((bh(i, j) for i in range(L)), zero)
        shifted = sum((bh(i + 1, j) for i in range(L)), zero)
        column_sum.append((
            sum((bv(i, j + 1) for i in range(L)), zero),
            sum(((bv(i, j) + bh(i, j)) + bh(i + 1, j) for i in range(L)), zero),
            sum((bv(i, j) + bh(i, j) for i in range(L)), zero) + shifted,
            (sv + sh) + shifted, (sv + sh) + sh, sv + (sh + sh), sv + zero, sv))
    return {'L': L, 'A': A, 'local_row': local_row, 'local_column': local_column,
            'row_sum': row_sum, 'column_sum': column_sum}


def _rc_check_invariance(section, left, right, label):
    global _rc_invariance
    if '_rc_invariance' not in globals():
        _rc_invariance = [_rc_invariance_rows(L, A)
                          for L in (1, 2, 3) for A in _rc_even_subsets(L)]
        assert [sum(case['L'] == L for case in _rc_invariance) for L in (1, 2, 3)] == [4, 32, 1024]
    checked = 0
    for case in _rc_invariance:
        for row in case[section]:
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked += 1
    assert checked > 0
    print('RESULT: PASS (%s: %d 等式、1060 偶部分グラフ)' % (label, checked))


def _rc_period_rows(case, direction):
    L = case['L']
    coordinates = Integers(L)
    minus_one, one, zero = coordinates(-1), coordinates(1), coordinates.zero()
    parity_zero = _rc_ring.zero()
    if direction == 'row':
        period = lambda x: sum((case['bh'][ZZ(x), j] for j in range(L)), parity_zero)
    else:
        period = lambda x: sum((case['bv'][i, ZZ(x)] for i in range(L)), parity_zero)
    base = [(period(minus_one + coordinates(NN(0))), period(minus_one + zero),
             period(minus_one), parity_zero)]
    step, representatives = [], []
    for k in range(L):
        step.append((
            period(minus_one + coordinates(k + 1)),
            period(minus_one + (coordinates(k) + coordinates(NN(1)))),
            period(minus_one + (coordinates(k) + one)),
            period((minus_one + coordinates(k)) + one),
            period(minus_one + coordinates(k)), parity_zero))
    for value in range(L):
        x = coordinates(value)
        representative = NN(ZZ(x + one))
        assert 0 <= representative < L
        representatives.append((
            period(x), period(zero + x), period((minus_one + one) + x),
            period(minus_one + (one + x)), period(minus_one + (x + one)),
            period(minus_one + coordinates(representative)), parity_zero))
    return {'base': base, 'step': step, 'representative': representatives}


def _rc_check_period(direction, phase, left, right, label):
    global _rc_period
    if '_rc_period' not in globals():
        assert [sum(case['L'] == L for case in _rc_cases) for L in (1, 2, 3)] == [1, 8, 256]
        _rc_period = [{direction: _rc_period_rows(case, direction)
                       for direction in ('row', 'column')} for case in _rc_cases]
    checked = 0
    for case, rows in zip(_rc_cases, _rc_period):
        for row in rows[direction][phase]:
            assert row[left] == row[right], (label, case['L'], case['A'], row)
            checked += 1
    assert checked == (265 if phase == 'base' else 785)
    print('RESULT: PASS (%s: %d 等式、265 自明セクター部分グラフ)' % (label, checked))
