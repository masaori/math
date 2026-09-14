# 対象ラベル: epsilon_square_identity
# 本文: I_2 boxtimes ... boxtimes I_2 = I_{Mat(2^M, C)}
# 検査では両辺を Mat(2^M, QQ) に置き、QQ -> C の包含前に厳密判定する。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    assert all_identity_factors(M) == identity_matrix(QQ, 2**M)

print("RESULT: PASS")
