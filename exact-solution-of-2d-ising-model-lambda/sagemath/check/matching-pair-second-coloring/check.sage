# 対象ラベル: claim_matching_pair_second_coloring_alternates
from pathlib import Path
_second_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring').is_dir())
load(str(_second_dir / '_prelude.sage'))
for file in sorted(_second_dir.glob('check_*.sage')):
    load(str(file))
for tau, upsilon, p, q in CASES:
    C = color(tau,p)
    assert all((upsilon[i] in C) == (i not in C) for i in range(len(tau)))
assert len(CASES) == 236
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', len(ROWS), 'points')
