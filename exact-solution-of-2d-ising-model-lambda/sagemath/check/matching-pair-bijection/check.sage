# 対象ラベル: claim_matching_pair_bijection
from pathlib import Path
_bijection_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection'
            for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection').is_dir())
load(str(_bijection_dir / '_prelude.sage'))
load(str(_bijection_dir / 'check_color.sage'))
load(str(_bijection_dir / 'check_left_color_rewrite.sage'))
load(str(_bijection_dir / 'check_left_recovery.sage'))
load(str(_bijection_dir / 'check_left_inverse.sage'))
load(str(_bijection_dir / 'check_right_inverse.sage'))
print('RESULT: PASS', len(CASES), 'pairs and', even_count, 'even-orbit permutations')
