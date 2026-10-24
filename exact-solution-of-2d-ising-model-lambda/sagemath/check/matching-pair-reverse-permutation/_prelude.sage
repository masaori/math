# 対象ラベル: claim_matching_pair_reverse_permutation
from pathlib import Path
_root = next(d for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color/_prelude.sage'))

def reconstructed_value(row, D, j):
    sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B = row
    return tau[j] if j in D else upsilon[j]
