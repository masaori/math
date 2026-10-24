# 対象ラベル: claim_matching_pair_successor_color
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color').is_dir())
for file in sorted(_dir.glob('check_*.sage')):
    load(str(file))
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in ROWS:
    C = color(tau, p)
    assert (successor(tau, upsilon, C, i) in C) == (i not in C)
assert len(CASES) == 236
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', len(ROWS), 'points')
