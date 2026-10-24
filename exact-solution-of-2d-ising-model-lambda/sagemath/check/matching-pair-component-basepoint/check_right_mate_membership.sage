# 対象ラベル: claim_matching_pair_component_basepoint
# 帰属: 有限番号集合とその部分集合。本文の行: tau[j] in orbit(p,tau[tau[i]])
from pathlib import Path
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint').is_dir()) / '_prelude.sage'))
for tau, upsilon, p, q, i, j in RIGHT:
    assert tau[j] in orbit(p,tau[tau[i]]), (tau, upsilon, i, j)
assert len(RIGHT) > 0
print('RESULT: PASS right_mate_membership', len(RIGHT))
