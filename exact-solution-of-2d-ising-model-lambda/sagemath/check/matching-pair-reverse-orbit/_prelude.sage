# 対象ラベル: claim_matching_pair_reverse_orbit
from itertools import permutations
from pathlib import Path

def orbit(f, i):
    seen = set()
    j = i
    while j not in seen:
        seen.add(j)
        j = f[j]
    assert j == i
    return seen

def inverse(f):
    return tuple(f.index(j) for j in range(len(f)))

def rows():
    for n in (0, 2, 4, 6):
        for sigma in permutations(range(n)):
            if any(len(orbit(sigma, i)) % 2 for i in range(n)):
                continue
            sigma_inv = inverse(sigma)
            color = set()
            for i in range(n):
                cycle = orbit(sigma, i)
                m = min(cycle)
                j = m
                k = 0
                while True:
                    if k % 2 == 0:
                        color.add(j)
                    j = sigma[j]
                    k += 1
                    if j == m:
                        break
            tau = tuple(sigma[j] if j in color else sigma_inv[j] for j in range(n))
            upsilon = tuple(sigma_inv[j] if j in color else sigma[j] for j in range(n))
            assert all(tau[tau[j]] == j and upsilon[upsilon[j]] == j for j in range(n))
            p = tuple(upsilon[tau[j]] for j in range(n))
            p_inv = inverse(p)
            for i in range(n):
                S = orbit(sigma, i)
                B = orbit(p, i) | orbit(p, tau[i])
                yield sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B

ROWS = list(rows())
