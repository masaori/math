# 対象ラベル: claim_matching_pair_component_basepoint
# 帰属: 有限番号集合とその部分集合。本文の行: orbit(p,i) | orbit(p,tau[j]) == orbit(p,i) | orbit(p,tau[i])
from pathlib import Path
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint').is_dir()) / '_prelude.sage'))
for tau, upsilon, p, q, i, j in LEFT:
    assert orbit(p,i) | orbit(p,tau[j]) == orbit(p,i) | orbit(p,tau[i]), (tau, upsilon, i, j)
assert len(LEFT) > 0
print('RESULT: PASS left_second_basepoint', len(LEFT))
