# 対象ラベル: epsilon_is_real_symmetric
# 本文の第一行と最終行が引く表示: epsilon = sigma^x ⊠ … ⊠ sigma^x
#   （epsilon_square_and_eigenvalues の証明で得た表示。ここでは定義 sigma^x_1 … sigma^x_M から作った
#     epsilon と比べて、引用する表示が実際に成り立つことを確かめる）
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in M_COL_RANGE:
    assert epsilon_by_definition(M) == all_sigma_x_factors(M)
    print(f"  M_col={M}: sigma^x_1 … sigma^x_M = sigma^x ⊠ … ⊠ sigma^x")

print("RESULT: PASS")
