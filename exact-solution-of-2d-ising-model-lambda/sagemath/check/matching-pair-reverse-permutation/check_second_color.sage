# 対象ラベル: claim_matching_pair_reverse_permutation
from pathlib import Path
_root = next(d for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-permutation/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-permutation/_prelude.sage'))
assert all(reconstructed_value(row, D, j) == upsilon[j] == sigma[j]
           for row, C, D in COLOR_ROWS
           for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in (row,)
           for j in range(len(sigma)) if j not in C)
print('RESULT: PASS second-color branch', len(COLOR_ROWS))
