# 対象ラベル: claim_matching_pair_bijection
# 本文: G(F(D_tau,D_upsilon))=(D_tau,D_upsilon)。
for tau, upsilon, p, q in CASES:
    sigma = pair_to_permutation(tau, upsilon)
    assert permutation_to_pair(sigma) == (tau, upsilon)
