# 対象ラベル: epsilon_is_real_symmetric
# 本文の第三行: (sigma^x)^T ⊠ … ⊠ (sigma^x)^T = sigma^x ⊠ … ⊠ sigma^x   ((sigma^x)^T = sigma^x を各因子へ)
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

assert sigma_x.transpose() == sigma_x
for M in M_COL_RANGE:
    left = kronecker_factors([sigma_x.transpose() for _ in range(M)])
    right = all_sigma_x_factors(M)
    assert left == right
    print(f"  M_col={M}: (sigma^x)^T ⊠ … = sigma^x ⊠ …")

print("RESULT: PASS")
