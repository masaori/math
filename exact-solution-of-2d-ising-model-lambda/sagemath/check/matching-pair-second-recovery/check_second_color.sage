# 対象ラベル: claim_matching_pair_second_recovery
from pathlib import Path
load(str(next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery/_prelude.sage' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery/_prelude.sage').is_file())))
assert all(successor(tau, upsilon, C, i) == upsilon[i] and recovered_second(tau, upsilon, C, i) == upsilon[i] for tau, upsilon, C, i in DATA if i not in C)
print('RESULT: PASS second color')
