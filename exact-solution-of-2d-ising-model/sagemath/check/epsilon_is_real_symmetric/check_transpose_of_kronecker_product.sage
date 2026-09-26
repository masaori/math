# 対象ラベル: epsilon_is_real_symmetric
# 本文の第二行: (sigma^x ⊠ … ⊠ sigma^x)^T = (sigma^x)^T ⊠ … ⊠ (sigma^x)^T   (kronecker_transpose)
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in M_COL_RANGE:
    left = all_sigma_x_factors(M).transpose()
    right = kronecker_factors([sigma_x.transpose() for _ in range(M)])
    assert left == right
    print(f"  M_col={M}: (sigma^x ⊠ …)^T = (sigma^x)^T ⊠ …")

print("RESULT: PASS")
