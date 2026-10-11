from itertools import permutations


def sop_inverse(sigma):
    return tuple(sigma.index(i) for i in range(len(sigma)))


def sop_orbit(sigma, start):
    seen, point = [], start
    while point not in seen:
        seen.append(point)
        point = sigma[point]
    assert point == start
    return frozenset(seen)


def sop_return_time(sigma, start):
    point, length = sigma[start], ZZ(1)
    while point != start:
        point, length = sigma[point], length + 1
    return length


def sop_graph_supports(sigma):
    neighbors = [set() for _ in sigma]
    for i, j in enumerate(sigma):
        neighbors[i].add(j)
        neighbors[j].add(i)
    supports = {}
    for start in range(len(sigma)):
        seen, pending = set(), [start]
        while pending:
            point = pending.pop()
            if point not in seen:
                seen.add(point)
                pending.extend(neighbors[point] - seen)
        supports[start] = frozenset(seen)
    return supports


def sop_sign(sigma, rank):
    inversions = ZZ(sum(1 for i in range(len(sigma)) for j in range(len(sigma))
                        if rank[i] < rank[j] and rank[sigma[j]] < rank[sigma[i]]))
    return ZZ(-1) ** inversions


def sop_constant(value):
    return sop_ring([sop_field(ZZ(value))])


def sop_selected_reversal(sigma, rank):
    # 選択する台を標本生成の無向探索とは独立に順反復から求める。
    odd_points = [i for i in range(len(sigma))
                  if len(sop_orbit(sigma, i)) % 2 == 1]
    start = min(odd_points, key=lambda i: rank[i])
    subset = sop_orbit(sigma, start)
    inverse = sop_inverse(sigma)
    return tuple(inverse[i] if i in subset else sigma[i] for i in range(len(sigma)))


def sop_product(A, indices, pi):
    result = sop_ring.one()
    for i in sorted(indices):
        result *= A[i, pi[i]]
    return result


def sop_factor_product(factors):
    result = sop_ring.one()
    for factor in factors:
        result *= factor
    return result


def sop_matrix(n, family):
    A = matrix(sop_ring, n, n)
    for i in range(n):
        for j in range(i + 1, n):
            value = ((i + 1) + (j + 1) * sop_zeta
                     + (i + j + 1) * sop_x + sop_zeta ** (i + j + 1) * sop_x ** 2)
            if family == 'zero' or (family == 'sparse' and (j - i) % 2 == 1):
                value = sop_ring.zero()
            A[i, j], A[j, i] = value, -value
    A.set_immutable()
    return A


if 'sop_rows' not in globals():
    sop_field = CyclotomicField(8, 'zeta')
    sop_zeta = sop_field.gen()
    sop_ring = PolynomialRing(sop_field, 'x')
    sop_x = sop_ring.gen()
    sop_rows, sop_matrix_rows = [], []
    sop_permutation_count, sop_ordered_permutation_count = 0, 0
    sop_target_counts = {n: 0 for n in range(7)}
    sop_matrices = {(n, family): sop_matrix(n, family)
                    for n in range(7) for family in ('dense', 'zero', 'sparse')}
    for n in range(7):
        for sigma in permutations(range(n)):
            sop_permutation_count += 1
            supports = sop_graph_supports(sigma)
            odd_points = frozenset(i for i in range(n) if len(supports[i]) % 2 == 1)
            orders = [tuple(range(n))]
            if n > 1:
                orders.append(tuple(reversed(range(n))))
            for order in orders:
                sop_ordered_permutation_count += 1
                if not odd_points or any(sigma[i] == i for i in range(n)):
                    continue
                sop_target_counts[n] += 1
                rank = tuple(order.index(i) for i in range(n))
                start = min(odd_points, key=lambda i: rank[i])
                subset = supports[start]
                outside = frozenset(range(n)) - subset
                inverse = sop_inverse(sigma)
                tau = sop_selected_reversal(sigma, rank)
                c_sigma = sop_ring(sop_field(sop_sign(sigma, rank)))
                c_tau = sop_ring(sop_field(sop_sign(tau, rank)))
                row = dict(sigma=sigma, inverse=inverse, rank=rank, start=start,
                           subset=subset, outside=outside, tau=tau,
                           odd_points=odd_points, supports=supports,
                           c_sigma=c_sigma, c_tau=c_tau)
                sop_rows.append(row)
                for family in ('dense', 'zero', 'sparse'):
                    A = sop_matrices[n, family]
                    sop_matrix_rows.append(dict(row, A=A, family=family,
                        P_sigma=sop_product(A, subset, sigma),
                        P_tau=sop_product(A, subset, tau),
                        Q_sigma=sop_product(A, outside, sigma),
                        Q_tau=sop_product(A, outside, tau),
                        all_sigma=sop_product(A, range(n), sigma),
                        all_tau=sop_product(A, range(n), tau)))
    assert sop_permutation_count == 874
    assert sop_ordered_permutation_count == 1746
    assert len(sop_rows) == 172
    assert len(sop_matrix_rows) == 516
    sop_results = {}


def sop_points(inside=False):
    for row in sop_rows:
        for i in (sorted(row['subset']) if inside else range(len(row['sigma']))):
            yield row, i


def sop_record(name, count):
    assert count > 0, name
    sop_results[name] = count
    print('RESULT: PASS ' + name + ' (' + str(count) + ' exact checks)')
