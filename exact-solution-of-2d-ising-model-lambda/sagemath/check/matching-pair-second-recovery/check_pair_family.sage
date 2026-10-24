# 対象ラベル: claim_matching_pair_second_recovery
from pathlib import Path
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery/_prelude.sage' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery/_prelude.sage').is_file())))
assert all(frozenset((i, recovered_second(tau, upsilon, C, i))) == frozenset((i, upsilon[i])) for tau, upsilon, C, i in DATA)
for tau, upsilon, p, q, i in ROWS:
    C = color(tau, p)
    assert {frozenset((j, recovered_second(tau, upsilon, C, j))) for j in range(len(tau))} == {frozenset((j, upsilon[j])) for j in range(len(tau))}
print('RESULT: PASS pair family')
