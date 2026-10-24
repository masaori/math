# 対象ラベル: claim_matching_pair_reverse_orbit
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reverse-orbit').is_dir())
load(str(_dir / '_prelude.sage'))
for sigma, sigma_inv, tau, upsilon, p, p_inv, i, S, B in ROWS:
    assert all(tau[j] in S and upsilon[j] in S for j in S)
    assert all(p[j] == upsilon[tau[j]] and p_inv[j] == tau[upsilon[j]] for j in S)
    assert all(p[j] in S and p_inv[j] in S for j in S)
    assert B <= S
print('RESULT: PASS forward closure', len(ROWS))
