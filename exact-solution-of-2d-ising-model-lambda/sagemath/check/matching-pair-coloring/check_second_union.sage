# 対象ラベル: claim_matching_pair_coloring_alternates
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in SECOND_ROWS:
    m = minimum(tau,p,i)
    assert i in orbit(p,tau[m])
print('RESULT: PASS second_union', len(SECOND_ROWS), 'cases')
