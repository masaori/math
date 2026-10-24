# 対象ラベル: claim_matching_pair_coloring_alternates
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i, j in BASEPOINT_ROWS:
    m = minimum(tau,p,i)
    assert minimum(tau,p,i) in component(tau,p,i)
print('RESULT: PASS minimum_source_i', len(BASEPOINT_ROWS), 'cases')
