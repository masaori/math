# 対象ラベル: claim_high_temperature_polynomial_identity
# 帰属: 有限集合、ZZ、ZZ[x]。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

R.<x> = PolynomialRing(ZZ)


def edge_subsets(L):
    edges = list(range(1, 2 * L * L + 1))
    for size in range(len(edges) + 1):
        for subset in combinations(edges, size):
            yield frozenset(subset)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def high_temperature_polynomial(L):
    edge_count = 2 * L * L
    return sum(((1 + x) ** (edge_count - len(subset)) *
                (1 - x) ** len(subset)
                for subset in edge_subsets(L) if is_even_subgraph(L, subset)), R.zero())


def one_edge_weight(sigma, u, v):
    return (1 + x) + (1 - x) * ZZ(sigma[u]) * ZZ(sigma[v])


for L in (1, 2):
    for sigma in configurations(L):
        broken = broken_bond_count(L, sigma)
        edge_product = prod(one_edge_weight(sigma, *endpoints(L, edge))
                            for edge in range(1, 2 * L * L + 1))
        assert edge_product == ZZ(2) ** (2 * L * L) * x ** broken

    lhs = ZZ(2) ** (L * L) * partition_polynomial(L)
    rhs = high_temperature_polynomial(L)
    assert lhs == rhs
    print("L=%d: 一辺の二項表示と高温展開の多項式恒等式を厳密検査" % L)

load(os.path.join(_dir, '_prelude.sage'))
check_files = (
    'check_one_edge_intact.sage',
    'check_one_edge_broken.sage',
    'check_product_edge_evaluation.sage',
    'check_product_broken_set.sage',
    'check_product_split.sage',
    'check_product_constants.sage',
    'check_product_power.sage',
    'check_product_associate.sage',
    'check_product_power_add.sage',
    'check_product_complement_card.sage',
    'check_product_lattice_card.sage',
    'check_product_broken_count.sage',
    'check_sum_product.sage',
    'check_sum_constant_out.sage',
    'check_sum_partition_definition.sage',
    'check_subset_expansion.sage',
    'check_subset_product_split.sage',
    'check_subset_constant_products.sage',
    'check_subset_complement_card.sage',
    'check_subset_lattice_card.sage',
    'check_subset_associate.sage',
    'check_sum_order.sage',
    'check_sum_spin_factor.sage',
    'check_sum_spin_definition.sage',
    'check_sum_spin_evaluation.sage',
    'check_sum_remove_zero.sage',
    'check_sum_commute_factor.sage',
    'check_sum_even_factor.sage',
    'check_sum_high_temperature_definition.sage',
    'check_normalization_associate.sage',
    'check_normalization_power_add.sage',
    'check_normalization_exponent.sage',
    'check_common_sum_evaluations.sage',
    'check_cancel_common_factor.sage',
)
for check_file in check_files:
    load(os.path.join(_dir, check_file))

print("全18配位・全260辺部分集合・全4104組の行別検算: %d files" % len(check_files))
print("RESULT: PASS")
