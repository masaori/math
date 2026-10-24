# 軌道一致による相手の所属
# 対象ラベル: def_matching_pair_step, claim_matching_pair_orbit_separation
# 本文の式: \tau(i) \in \operatorname{Orb}_{p}(i)
# 計算する式ペア: tau[i] in orbit(p, i) == True
from pathlib import Path
load(str(next(path for path in (Path('_prelude.sage'), Path('sagemath/check/matching-pair-orbit-separation/_prelude.sage'), Path('exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orbit-separation/_prelude.sage')) if path.is_file())))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for j in orbit(p, i):
        if not (j in orbit(p, tau[i])):
            continue
        lhs = tau[i] in orbit(p, i)
        rhs = True
        assert lhs == rhs, (tau, upsilon, i, lhs, rhs)
        count += 1
print(('RESULT: PASS; checked=%s' % count) if count else 'RESULT: NO_CASES; checked=0')
