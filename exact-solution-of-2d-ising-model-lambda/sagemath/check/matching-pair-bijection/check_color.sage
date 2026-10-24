# 対象ラベル: claim_matching_pair_bijection
# 本文: 二つの第一色の一致。
for tau, upsilon, p, q in CASES:
    sigma = pair_to_permutation(tau, upsilon)
    assert even_orbits(sigma)
    assert standard_color(sigma) == color(tau, p)
