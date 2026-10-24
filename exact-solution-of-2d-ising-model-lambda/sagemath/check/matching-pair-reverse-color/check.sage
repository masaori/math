# 対象ラベル: claim_matching_pair_reverse_color
from pathlib import Path
_dir_color = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color').is_dir())
load(str(_dir_color / '_prelude.sage'))
assert len(COLOR_ROWS) == 1388
assert all(min(B) == min(S) and min(S) in C and min(S) in D and C == D
           for row, C, D in COLOR_ROWS for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in (row,))
print('RESULT: PASS recovered first color', len(COLOR_ROWS))
