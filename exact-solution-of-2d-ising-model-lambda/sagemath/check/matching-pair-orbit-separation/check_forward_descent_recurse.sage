# 二回減らす降下: 反復の再帰
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: p^{[k]}(p(i)) = p^{[k+1]}(i)
# 計算する式ペア: iterate(p, k, p[i]) == iterate(p, k + 1, i)
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for k in range(MAX_EXPONENT + 1):
        lhs = iterate(p, k, p[i])
        rhs = iterate(p, k + 1, i)
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print('RESULT: PASS; checked=%s' % count)
