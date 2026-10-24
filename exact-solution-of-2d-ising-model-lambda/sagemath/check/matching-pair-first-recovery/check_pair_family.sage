# 対象ラベル: claim_matching_pair_first_recovery
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery/_prelude.sage' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery/_prelude.sage').is_file())))
assert all(frozenset((i, recovered(tau, upsilon, C, i))) == frozenset((i, tau[i])) for tau, upsilon, C, i in DATA)
for tau, upsilon, p, q, i in ROWS:
    C = color(tau, p)
    assert {frozenset((j, recovered(tau, upsilon, C, j))) for j in range(len(tau))} == {frozenset((j, tau[j])) for j in range(len(tau))}
print('RESULT: PASS pair family')
