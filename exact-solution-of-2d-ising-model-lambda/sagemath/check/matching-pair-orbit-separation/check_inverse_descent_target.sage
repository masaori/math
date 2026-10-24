# 逆反復の降下: 対合の打消し
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \upsilon(\tau(\tau(i))) = \upsilon(i)
# 計算する式ペア: upsilon[tau[tau[i]]] == upsilon[i]
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for k in range(MAX_EXPONENT + 1):
        lhs = upsilon[tau[tau[i]]]
        rhs = upsilon[i]
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print('RESULT: PASS; checked=%s' % count)
