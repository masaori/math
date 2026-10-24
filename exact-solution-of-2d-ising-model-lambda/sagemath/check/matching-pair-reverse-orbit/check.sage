# 対象ラベル: claim_matching_pair_reverse_orbit
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit').is_dir())
load(str(_dir / 'check_forward_closure.sage'))
load(str(_dir / 'check_reverse_closure.sage'))
assert len(ROWS) == 1388
assert all(B == S for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in ROWS)
print('RESULT: PASS orbit equality', len(ROWS))
