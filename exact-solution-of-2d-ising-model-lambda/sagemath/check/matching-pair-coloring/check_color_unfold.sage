# 対象ラベル: claim_matching_pair_coloring_alternates
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in ROWS:
    m = minimum(tau,p,i)
    assert (tau[i] in color(tau,p)) == (tau[i] in orbit(p,minimum(tau,p,tau[i])))
print('RESULT: PASS color_unfold', len(ROWS), 'cases')
