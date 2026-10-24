# 対象ラベル: claim_matching_pair_reverse_color
from pathlib import Path
_dir_color = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color').is_dir())
load(str(_dir_color / '_prelude.sage'))
assert all((sigma[j] in C) == (j not in C) and (sigma[j] in D) == (j not in D)
           for row, C, D in COLOR_ROWS for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in (row,)
           for j in range(len(sigma)))
print('RESULT: PASS alternation', len(COLOR_ROWS))
