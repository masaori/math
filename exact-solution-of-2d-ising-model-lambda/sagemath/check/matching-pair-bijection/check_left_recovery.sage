# 対象ラベル: claim_matching_pair_bijection
# 本文: 第一・第二マッチングの復元を組に適用する等号。
for tau, upsilon, p, q in CASES:
    sigma = pair_to_permutation(tau, upsilon)
    sigma_inv = inverse(sigma)
    C = color(tau, p)
    first = tuple(sigma[i] if i in C else sigma_inv[i] for i in range(len(sigma)))
    second = tuple(sigma_inv[i] if i in C else sigma[i] for i in range(len(sigma)))
    assert first == tau
    assert second == upsilon
