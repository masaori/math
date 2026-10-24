# 対象ラベル: claim_matching_pair_first_recovery
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery/_prelude.sage' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-first-recovery/_prelude.sage').is_file())))
assert all(successor(tau, upsilon, C, i) == tau[i] and recovered(tau, upsilon, C, i) == tau[i] for tau, upsilon, C, i in DATA if i in C)
print('RESULT: PASS first color')
