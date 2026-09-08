# 対象ラベル: epsilon_square_identity
# 本文: (sigma^x boxtimes ...)(sigma^x boxtimes ...)
#       = (sigma^x sigma^x) boxtimes ... boxtimes (sigma^x sigma^x)
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    left = all_sigma_x_factors(M) * all_sigma_x_factors(M)
    right = kronecker_factors([sigma_x * sigma_x for _ in range(M)])
    assert left == right

print("RESULT: PASS")
