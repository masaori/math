# 対象ラベル: claim_matching_pair_reverse_color
from pathlib import Path
_root = next(d for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit/_prelude.sage'))

def first_colors(row):
    sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B = row
    n = len(sigma)
    C = set()
    D = set()
    for j in range(n):
        m_sigma = min(orbit(sigma, j))
        k = m_sigma
        r = 0
        while k != j:
            k = sigma[k]
            r += 1
        if r % 2 == 0:
            C.add(j)
        m_pair = min(orbit(p, j) | orbit(p, tau[j]))
        if j in orbit(p, m_pair):
            D.add(j)
    return C, D

COLOR_ROWS = [(row, *first_colors(row)) for row in ROWS]
