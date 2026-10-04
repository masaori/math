# 対象ラベル: claim_high_temperature_polynomial_identity
# 本文の各式を ZZ[x] で独立に評価する。自己ループの端点は二回数える。
import os
from itertools import combinations

_check_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_check_dir, '../../_shared/defs.sage'))
R = PolynomialRingZx


def _edge_subsets(edge_numbers):
    return tuple(frozenset(subset)
                 for size in range(len(edge_numbers) + 1)
                 for subset in combinations(edge_numbers, size))


def _spin_monomial(L, sigma, subset):
    return prod(ZZ(sigma[u]) * ZZ(sigma[v])
                for edge in subset for u, v in [endpoints(L, edge)])


def _even(L, subset):
    return all(sum(1 for edge in subset for endpoint in endpoints(L, edge)
                   if endpoint == vertex) % 2 == 0
               for vertex in vertices(L))


def _high_temperature_case(L):
    edge_numbers = tuple(range(1, 2 * L * L + 1))
    configs = tuple(configurations(L))
    subsets = _edge_subsets(edge_numbers)
    edge_set = frozenset(edge_numbers)
    local_rows = []
    product_rows = []
    term_rows = {}
    for config_index, sigma in enumerate(configs):
        broken_set = frozenset(edge for edge in edge_numbers
                               if sigma[endpoints(L, edge)[0]] != sigma[endpoints(L, edge)[1]])
        intact_set = edge_set - broken_set
        edge_weights = []
        for edge in edge_numbers:
            u, v = endpoints(L, edge)
            weight = (1 + x) + (1 - x) * ZZ(sigma[u]) * ZZ(sigma[v])
            edge_weights.append(weight)
            local_rows.append({'same': sigma[u] == sigma[v], 'weight': weight})
        product_rows.append({
            'raw': prod(edge_weights),
            'by_spin': prod(R(2) if sigma[u] == sigma[v] else 2*x
                            for u, v in (endpoints(L, edge) for edge in edge_numbers)),
            'by_broken': prod(2*x if edge in broken_set else R(2) for edge in edge_numbers),
            'split': prod(R(2) for edge in intact_set) * prod(2*x for edge in broken_set),
            'constants': R(2)**len(intact_set) * (2*x)**len(broken_set),
            'power_product': R(2)**len(intact_set) * (R(2)**len(broken_set) * x**len(broken_set)),
            'associated': (R(2)**len(intact_set) * R(2)**len(broken_set)) * x**len(broken_set),
            'power_sum': R(2)**(len(intact_set)+len(broken_set)) * x**len(broken_set),
            'edge_card': R(2)**len(edge_numbers) * x**len(broken_set),
            'lattice_card': R(2)**(2*L*L) * x**len(broken_set),
            'broken_count': R(2)**(2*L*L) * x**broken_bond_count(L, sigma),
        })
        for subset in subsets:
            complement = edge_set - subset
            spin = _spin_monomial(L, sigma, subset)
            term_rows[config_index, subset] = {
                'raw': prod(1+x for edge in complement) *
                       prod((1-x)*ZZ(sigma[u])*ZZ(sigma[v])
                            for edge in subset for u,v in [endpoints(L, edge)]),
                'split': prod(1+x for edge in complement) *
                         (prod(1-x for edge in subset) * spin),
                'constants': (1+x)**len(complement) * ((1-x)**len(subset)*spin),
                'complement_card': (1+x)**(len(edge_numbers)-len(subset)) *
                                   ((1-x)**len(subset)*spin),
                'edge_card': (1+x)**(2*L*L-len(subset)) * ((1-x)**len(subset)*spin),
                'associated': ((1+x)**(2*L*L-len(subset))*(1-x)**len(subset))*spin,
                'spin': spin,
            }
    spin_sums = {subset: sum(_spin_monomial(L, sigma, subset) for sigma in configs)
                 for subset in subsets}
    weights = {subset: (1+x)**(2*L*L-len(subset)) * (1-x)**len(subset)
               for subset in subsets}
    even = {subset: _even(L, subset) for subset in subsets}
    h_polynomial = sum((weights[subset] for subset in subsets if even[subset]), R.zero())
    config_indices = range(len(configs))
    sums = {
        'common': sum((row['raw'] for row in product_rows), R.zero()),
        'product_evaluated': sum((R(2)**(2*L*L)*x**broken_bond_count(L, sigma)
                                  for sigma in configs), R.zero()),
        'constant_out': R(2)**(2*L*L)*sum((x**broken_bond_count(L, sigma)
                                         for sigma in configs), R.zero()),
        'partition': R(2)**(2*L*L)*partition_polynomial(L),
        'expanded': sum((sum((term_rows[i,subset]['raw'] for subset in subsets), R.zero())
                         for i in config_indices), R.zero()),
        'associated': sum((sum((term_rows[i,subset]['associated'] for subset in subsets), R.zero())
                           for i in config_indices), R.zero()),
        'swapped': sum((sum((term_rows[i,subset]['associated'] for i in config_indices), R.zero())
                        for subset in subsets), R.zero()),
        'spin_factor': sum((weights[subset]*sum(term_rows[i,subset]['spin'] for i in config_indices)
                            for subset in subsets), R.zero()),
        'spin_definition': sum((weights[subset]*spin_sums[subset] for subset in subsets), R.zero()),
        'spin_evaluated': sum((weights[subset]*(ZZ(2)**(L*L) if even[subset] else ZZ(0))
                               for subset in subsets), R.zero()),
        'even_only': sum((weights[subset]*ZZ(2)**(L*L)
                         for subset in subsets if even[subset]), R.zero()),
        'commuted': sum((ZZ(2)**(L*L)*weights[subset]
                        for subset in subsets if even[subset]), R.zero()),
        'even_factor_out': ZZ(2)**(L*L)*sum((weights[subset]
                                           for subset in subsets if even[subset]), R.zero()),
        'high_temperature': ZZ(2)**(L*L)*h_polynomial,
        'nested_factor': R(2)**(L*L)*(R(2)**(L*L)*partition_polynomial(L)),
        'associated_factor': (R(2)**(L*L)*R(2)**(L*L))*partition_polynomial(L),
        'power_added': R(2)**(L*L+L*L)*partition_polynomial(L),
        'cancelled_left': R(2)**(L*L)*partition_polynomial(L),
        'cancelled_right': h_polynomial,
    }
    return {
        'L': L, 'local': local_rows, 'products': product_rows, 'terms': term_rows,
        'sums': sums, 'subsets': subsets, 'spins': spin_sums, 'even': even,
        'config_count': len(configs),
    }


if '_high_temperature_cases' not in globals():
    _high_temperature_cases = [_high_temperature_case(L) for L in (1, 2)]

