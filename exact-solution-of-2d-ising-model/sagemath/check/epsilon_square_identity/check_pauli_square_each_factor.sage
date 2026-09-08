# 対象ラベル: epsilon_square_identity
# 本文: (sigma^x sigma^x) boxtimes ... = I_2 boxtimes ... boxtimes I_2
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

assert sigma_x * sigma_x == identity_two
for M in [1, 2, 3, 4, 5]:
    left = kronecker_factors([sigma_x * sigma_x for _ in range(M)])
    right = all_identity_factors(M)
    assert left == right

print("RESULT: PASS")
