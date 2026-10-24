# 対象ラベル: claim_matching_pair_first_recovery
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery').is_dir())
load(str(_dir.parent / 'matching-pair-permutation' / '_prelude.sage'))
DATA = [(tau, upsilon, color(tau, p), i) for tau, upsilon, p, q, i in ROWS]

def recovered(tau, upsilon, C, i):
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    inverse = tuple(sigma.index(j) for j in range(len(tau)))
    return sigma[i] if i in C else inverse[i]
