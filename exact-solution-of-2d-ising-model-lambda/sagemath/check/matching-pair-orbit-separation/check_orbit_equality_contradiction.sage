# 共通点がある場合の両軌道一致
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \operatorname{Orb}_{p}(\tau(i)) = \operatorname{Orb}_{p}(i)
# 計算する式ペア: orbit(p, tau[i]) == orbit(p, i)
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for j in orbit(p, i):
        if not (j in orbit(p, tau[i])):
            continue
        lhs = orbit(p, tau[i])
        rhs = orbit(p, i)
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print(('RESULT: PASS; checked=%s' % count) if count else 'RESULT: NO_CASES; checked=0')
