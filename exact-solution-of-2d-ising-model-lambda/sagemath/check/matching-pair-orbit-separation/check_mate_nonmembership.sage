# 第一相手は二歩置換の軌道に属さない
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \tau(i) \notin \operatorname{Orb}_{p}(i)
# 計算する式ペア: tau[i] not in orbit(p, i) == True
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    lhs = tau[i] not in orbit(p, i)
    rhs = True
    assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
    count += 1
print('RESULT: PASS; checked=%s' % count)
