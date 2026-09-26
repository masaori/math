# 対象ラベル: epsilon_is_real_symmetric
# 主張全体: epsilon^T = epsilon（定義 sigma^x_1 … sigma^x_M から作った epsilon について直接）
#   あわせて、定義から作った epsilon の転置から出発して本文の四行の鎖を順にたどり、
#   各行の値が隣の行と等しいことを確かめる。
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in M_COL_RANGE:
    eps = epsilon_by_definition(M)
    assert eps.transpose() == eps
    chain = [
        eps.transpose(),
        all_sigma_x_factors(M).transpose(),
        kronecker_factors([sigma_x.transpose() for _ in range(M)]),
        all_sigma_x_factors(M),
        eps,
    ]
    for a, b in zip(chain, chain[1:]):
        assert a == b
    print(f"  M_col={M}: epsilon^T = epsilon（本文の鎖の各行も一致）")

print("RESULT: PASS")
