# 順反復の一回: 合成
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: p(i) = \upsilon(\tau(i))
# 計算する式ペア: p[i] == upsilon[tau[i]]
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    lhs = p[i]
    rhs = upsilon[tau[i]]
    assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
    count += 1
print('RESULT: PASS; checked=%s' % count)
