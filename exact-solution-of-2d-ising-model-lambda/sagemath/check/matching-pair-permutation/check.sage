# 対象ラベル: claim_matching_pair_permutation
from pathlib import Path
_perm_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation').is_dir())
load(str(_perm_dir / '_prelude.sage'))
for file in sorted(_perm_dir.glob('check_*.sage')):
    load(str(file))
shared_pairs = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    sigma = tuple(successor(tau, upsilon, C, i) for i in range(len(tau)))
    eta = tuple(predecessor(tau, upsilon, C, i) for i in range(len(tau)))
    assert sorted(sigma) == list(range(len(tau)))
    assert sorted(eta) == list(range(len(tau)))
    assert all(eta[sigma[i]] == i and sigma[eta[i]] == i for i in range(len(tau)))
    shared_pairs += sum(1 for i in range(len(tau)) if i < tau[i] and tau[i] == upsilon[i])
assert len(CASES) == 236
assert shared_pairs > 0
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', len(ROWS), 'points;', shared_pairs, 'shared pairs')
