from itertools import combinations, permutations
from pathlib import Path


def oss_closed_subsets(D, F):
    # F の軌道から閉集合を作る。重みや和の値では標本を選ばない。
    unseen, components = set(D), []
    while unseen:
        start = min(unseen)
        component, point = set(), start
        while point not in component:
            component.add(point)
            point = F[point]
        assert point == start
        unseen.difference_update(component)
        components.append(frozenset(component))
    selections = {frozenset(), frozenset(range(len(components)))}
    for size in range(min(2, len(components)) + 1):
        selections.update(frozenset(c) for c in combinations(range(len(components)), size))
    for k in range(len(components)):
        selections.add(frozenset(range(k)))
        selections.add(frozenset(range(k, len(components))))
        selections.add(frozenset(range(len(components))) - {k})
    selections.add(frozenset(range(0, len(components), 2)))
    selections.add(frozenset(range(1, len(components), 2)))
    subsets = {frozenset().union(*(components[k] for k in chosen)) for chosen in selections}
    return sorted(subsets, key=lambda S: (len(S), sorted(S)))


def oss_sum(row, S):
    # 各符号付き項は行列成分の積から求め、対の相殺を利用せず加える。
    return sum((row['weights'][rho] for rho in sorted(S)), sop_ring.zero())


if 'oss_groups' not in globals():
    oss_dir = Path(__file__).resolve().parent
    load(str(oss_dir.parent / 'selected-odd-orbit-skew-product-neg' / '_prelude.sage'))
    oss_groups, oss_terms, oss_stages, oss_remaining = [], [], [], []
    oss_permutations, oss_ordered_permutations = 0, 0
    oss_targets = {n: 0 for n in range(7)}
    for n in range(7):
        all_permutations = list(permutations(range(n)))
        oss_permutations += len(all_permutations)
        orders = [tuple(range(n))]
        if n > 1:
            orders.append(tuple(reversed(range(n))))
        for order in orders:
            oss_ordered_permutations += len(all_permutations)
            rank = tuple(order.index(i) for i in range(n))
            D = frozenset(sigma for sigma in all_permutations
                          if all(sigma[i] != i for i in range(n))
                          and any(len(support) % 2 == 1
                                  for support in sop_graph_supports(sigma).values()))
            F = {sigma: sop_selected_reversal(sigma, rank) for sigma in D}
            assert all(tau in D for tau in F.values())
            subsets = oss_closed_subsets(D, F)
            oss_targets[n] += len(D)
            for family in ('dense', 'zero', 'sparse'):
                A = sop_matrices[n, family]
                weights = {sigma: sop_constant(sop_sign(sigma, rank))
                           * sop_product(A, range(n), sigma) for sigma in D}
                group = dict(n=n, order=order, rank=rank, family=family,
                             D=D, F=F, A=A, weights=weights, subsets=subsets)
                oss_groups.append(group)
                for rho in sorted(D):
                    oss_terms.append(dict(group, rho=rho))
                for S in subsets:
                    for sigma in sorted(S):
                        tau = F[sigma]
                        R = (S - {sigma}) - {tau}
                        stage = dict(group, S=S, sigma=sigma, tau=tau, R=R,
                                     sumS=oss_sum(group, S),
                                     sumErase=oss_sum(group, S - {sigma}),
                                     sumR=oss_sum(group, R))
                        oss_stages.append(stage)
                        for rho in sorted(R):
                            oss_remaining.append((stage, rho))
    assert oss_permutations == 874
    assert oss_ordered_permutations == 1746
    assert sum(oss_targets.values()) == 172
    assert len(oss_groups) == 36
    assert len(oss_terms) == 516
    oss_results = {}


def oss_record(name, count):
    assert count > 0, name
    oss_results[name] = count
    print('RESULT: PASS ' + name + ' (' + str(count) + ' exact checks)')
