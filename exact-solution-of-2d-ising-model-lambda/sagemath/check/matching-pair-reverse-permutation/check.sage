# 対象ラベル: claim_matching_pair_reverse_permutation
from pathlib import Path
_root = next(d for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-permutation/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-permutation/_prelude.sage'))
assert len(COLOR_ROWS) == 1388
assert all(C == D and all(reconstructed_value(row, D, j) == sigma[j] for j in range(len(sigma)))
           for row, C, D in COLOR_ROWS
           for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in (row,))
print('RESULT: PASS reconstructed permutation', len(COLOR_ROWS))
