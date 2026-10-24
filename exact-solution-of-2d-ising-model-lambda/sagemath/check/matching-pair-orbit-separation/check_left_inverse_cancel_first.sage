# 逆写像の左逆: 第一対合の打消し
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \tau(\tau(i)) = i
# 計算する式ペア: tau[tau[i]] == i
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    lhs = tau[tau[i]]
    rhs = i
    assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
    count += 1
print('RESULT: PASS; checked=%s' % count)
