# 逆反復の降下: 反復の交換
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \upsilon(\tau(q(q^{[k]}(i)))) = \upsilon(\tau(q^{[k+1]}(i)))
# 計算する式ペア: upsilon[tau[q[iterate(q, k, i)]]] == upsilon[tau[iterate(q, k + 1, i)]]
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for k in range(MAX_EXPONENT + 1):
        lhs = upsilon[tau[q[iterate(q, k, i)]]]
        rhs = upsilon[tau[iterate(q, k + 1, i)]]
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print('RESULT: PASS; checked=%s' % count)
