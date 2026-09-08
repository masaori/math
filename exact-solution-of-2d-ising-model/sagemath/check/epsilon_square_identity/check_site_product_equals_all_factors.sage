# 対象ラベル: epsilon_square_identity
# 本文: sigma_1^x ... sigma_M^x = sigma^x boxtimes ... boxtimes sigma^x
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    for count in range(0, M + 1):
        assert site_product(M, count) == prefix_sigma_x_factors(M, count)
    assert site_product(M) == all_sigma_x_factors(M)

print("RESULT: PASS")
