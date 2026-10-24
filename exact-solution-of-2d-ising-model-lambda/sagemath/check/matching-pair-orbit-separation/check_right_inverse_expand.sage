# 逆写像の右逆: 定義展開
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: p(q(i)) = \upsilon(\tau(\tau(\upsilon(i))))
# 計算する式ペア: p[q[i]] == upsilon[tau[tau[upsilon[i]]]]
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    lhs = p[q[i]]
    rhs = upsilon[tau[tau[upsilon[i]]]]
    assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
    count += 1
print('RESULT: PASS; checked=%s' % count)
