# 対象ラベル: claim_matching_pair_second_recovery
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery').is_dir())
load(str(_dir.parent / 'matching-pair-permutation' / '_prelude.sage'))
DATA = [(tau, upsilon, color(tau, p), i) for tau, upsilon, p, q, i in ROWS]

def recovered_second(tau, upsilon, C, i):
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    inverse = tuple(sigma.index(j) for j in range(len(tau)))
    return inverse[i] if i in C else sigma[i]
