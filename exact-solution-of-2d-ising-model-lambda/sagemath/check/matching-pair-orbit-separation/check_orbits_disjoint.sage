# 二歩置換の二つの軌道は交わらない
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \operatorname{Orb}_{p}(i)\cap \operatorname{Orb}_{p}(\tau(i)) = \varnothing
# 計算する式ペア: orbit(p, i).intersection(orbit(p, tau[i])) == frozenset()
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    lhs = orbit(p, i).intersection(orbit(p, tau[i]))
    rhs = frozenset()
    assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
    count += 1
print('RESULT: PASS; checked=%s' % count)
