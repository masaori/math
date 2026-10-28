# 対象ラベル: claim_opposite_direction_permutation_term_zero
# 式: A_{δ,σ(δ)} = A_{δ,δ+2}。
def check_selected_entry(A, sigma, i):
    assert A[i, sigma[i]] == A[i, (i + 2) % 4]
