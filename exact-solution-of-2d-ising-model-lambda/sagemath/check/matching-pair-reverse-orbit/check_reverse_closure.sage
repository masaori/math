# 対象ラベル: claim_matching_pair_reverse_orbit
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit').is_dir())
load(str(_dir / '_prelude.sage'))
for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in ROWS:
    assert i in B
    assert all(tau[j] in B and p[tau[j]] == upsilon[j] and upsilon[j] in B for j in B)
    assert all(sigma[j] in B and sigma_inv[j] in B for j in B)
    assert S <= B
print('RESULT: PASS reverse closure', len(ROWS))
