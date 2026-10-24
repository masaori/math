# 対象ラベル: claim_matching_pair_coloring_alternates
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring').is_dir())
load(str(_dir / '_prelude.sage'))
for file in sorted(_dir.glob('check_*.sage')):
    load(str(file))
for tau, upsilon, p, q in CASES:
    C = color(tau,p)
    assert all((tau[i] in C) == (i not in C) for i in range(len(tau)))
assert len(CASES) == 236
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', len(ROWS), 'points')
