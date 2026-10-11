from itertools import permutations


def irs_inverse(sigma):
    return tuple(sigma.index(i) for i in range(len(sigma)))


def irs_compose(phi, psi):
    return tuple(phi[psi[i]] for i in range(len(psi)))


def irs_sign(sigma, rank):
    inversions = ZZ(sum(1 for i in range(len(sigma)) for j in range(len(sigma))
                        if rank[i] < rank[j] and rank[sigma[j]] < rank[sigma[i]]))
    return ZZ(-1) ** inversions


def irs_reverse(sigma, subset):
    inverse = irs_inverse(sigma)
    return tuple(inverse[i] if i in subset else sigma[i] for i in range(len(sigma)))


def irs_graph_supports(sigma):
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


def irs_selected_reversal(sigma, rank):
    # 定義どおりの順反復で軌道を作り、標本生成の無向探索と独立に計算する。
    supports = {}
    for start in range(len(sigma)):
        seen, point = set(), start
        while point not in seen:
            seen.add(point)
            point = sigma[point]
        supports[start] = frozenset(seen)
    odd_points = [i for i in range(len(sigma)) if len(supports[i]) % 2 == 1]
    assert odd_points and all(sigma[i] != i for i in range(len(sigma)))
    start = min(odd_points, key=lambda i: rank[i])
    return irs_reverse(sigma, supports[start])


if "irs_rows" not in globals():
    irs_rows, irs_odd_rows = [], []
    irs_permutation_count, irs_subset_count, irs_ordered_permutation_count = 0, 0, 0
    for n in range(7):
        for sigma in permutations(range(n)):
            irs_permutation_count += 1
            inverse = irs_inverse(sigma)
            orders = [tuple(range(n))]
            if n > 1:
                orders.append(tuple(reversed(range(n))))
            subsets = [frozenset(i for i in range(n) if (mask >> i) & 1)
                       for mask in range(1 << n)]
            invariant_subsets = [subset for subset in subsets
                                 if frozenset(sigma[i] for i in subset) == subset]
            irs_subset_count += len(invariant_subsets)
            supports = irs_graph_supports(sigma)
            odd_points = frozenset(i for i in range(n) if len(supports[i]) % 2 == 1)
            for order in orders:
                irs_ordered_permutation_count += 1
                rank = tuple(order.index(i) for i in range(n))
                for subset in invariant_subsets:
                    p = tuple(sigma[i] if i in subset else i for i in range(n))
                    q = tuple(inverse[i] if i in subset else i for i in range(n))
                    tau = irs_reverse(sigma, subset)
                    q_sigma = irs_compose(q, sigma)
                    q_q_sigma = irs_compose(q, q_sigma)
                    irs_rows.append(dict(sigma=sigma, inverse=inverse, subset=subset,
                        p=p, q=q, tau=tau, rank=rank, q_sigma=q_sigma,
                        q_q_sigma=q_q_sigma))
                if odd_points and all(sigma[i] != i for i in range(n)):
                    start = min(odd_points, key=lambda i: rank[i])
                    subset = supports[start]
                    irs_odd_rows.append(dict(sigma=sigma, rank=rank, subset=subset))
    assert irs_permutation_count == 874
    assert irs_subset_count == 5913
    assert irs_ordered_permutation_count == 1746
    assert len(irs_rows) == 11823
    assert len(irs_odd_rows) == 172
    irs_results = {}


def irs_points(inside=None):
    for row in irs_rows:
        for i in range(len(row["sigma"])):
            if inside is None or (i in row["subset"]) == inside:
                yield row, i


def irs_record(name, count):
    assert count > 0, name
    irs_results[name] = count
    print("RESULT: PASS " + name + " (" + str(count) + " exact checks)")
