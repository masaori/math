# 二回減らす降下: 反復の交換
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \tau(\upsilon(p(p^{[k+1]}(i)))) = \tau(\upsilon(p^{[k+2]}(i)))
# 計算する式ペア: tau[upsilon[p[iterate(p, k + 1, i)]]] == tau[upsilon[iterate(p, k + 2, i)]]
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for k in range(MAX_EXPONENT + 1):
        lhs = tau[upsilon[p[iterate(p, k + 1, i)]]]
        rhs = tau[upsilon[iterate(p, k + 2, i)]]
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print('RESULT: PASS; checked=%s' % count)
