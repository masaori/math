# 対象ラベル: claim_matching_pair_bijection
# 帰属: 有限番号集合と自然数。全て厳密な有限演算。
from pathlib import Path
from itertools import permutations
_root = next(d for d in (Path.cwd(), *Path.cwd().parents)
             if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation/_prelude.sage'))

def standard_color(sigma):
    result = set()
    for i in range(len(sigma)):
        minimum_point = min(orbit(sigma, i))
        point = minimum_point
        parity = 0
        while point != i:
            point = sigma[point]
            parity += 1
        if parity % 2 == 0:
            result.add(i)
    return frozenset(result)

def inverse(sigma):
    return tuple(sigma.index(i) for i in range(len(sigma)))

def pair_to_permutation(tau, upsilon):
    p = compose(upsilon, tau)
    C = color(tau, p)
    return tuple(successor(tau, upsilon, C, i) for i in range(len(tau)))

def permutation_to_pair(sigma):
    C = standard_color(sigma)
    sigma_inv = inverse(sigma)
    tau = tuple(sigma[i] if i in C else sigma_inv[i] for i in range(len(sigma)))
    upsilon = tuple(sigma_inv[i] if i in C else sigma[i] for i in range(len(sigma)))
    return tau, upsilon

def even_orbits(sigma):
    return all(len(orbit(sigma, i)) % 2 == 0 for i in range(len(sigma)))
