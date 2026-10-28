# 対象ラベル: claim_opposite_direction_permutation_term_zero
# 式: 零因子を持つ有限積は零。
def check_product_zero(A, sigma):
    assert prod(A[j, sigma[j]] for j in range(4)) == 0
