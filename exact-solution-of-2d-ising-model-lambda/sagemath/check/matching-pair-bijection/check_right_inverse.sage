# 対象ラベル: claim_matching_pair_bijection
# 本文: F(G(sigma))=sigma。
even_count = 0
for size in (0, 2, 4, 6):
    for sigma in permutations(range(size)):
        if even_orbits(sigma):
            even_count += 1
            assert pair_to_permutation(*permutation_to_pair(sigma)) == sigma
assert even_count == 236
