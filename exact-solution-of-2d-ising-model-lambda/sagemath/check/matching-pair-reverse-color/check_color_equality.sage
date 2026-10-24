# 対象ラベル: claim_matching_pair_reverse_color
from pathlib import Path
_dir_color = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-color').is_dir())
load(str(_dir_color / '_prelude.sage'))
assert all(C == D for row, C, D in COLOR_ROWS)
print('RESULT: PASS color equality', len(COLOR_ROWS))
