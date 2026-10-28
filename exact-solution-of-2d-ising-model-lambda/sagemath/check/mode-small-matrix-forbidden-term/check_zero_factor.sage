# 対象ラベル: claim_opposite_direction_permutation_term_zero
# 式: A_{δ,δ+2} = 0 - x C(0) = 0。
def check_zero_factor(A, x, i):
    assert A[i, (i + 2) % 4] == -x * A.base_ring()(0)
    assert A[i, (i + 2) % 4] == 0
