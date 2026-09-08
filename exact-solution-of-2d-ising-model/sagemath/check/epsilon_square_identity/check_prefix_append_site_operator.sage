# 対象ラベル: epsilon_square_identity
# 本文の帰納段第一行: 帰納法の仮定へ次のサイト作用素を右から掛ける。
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    for count in range(0, M):
        left = site_product(M, count) * site_sigma_x(M, count)
        right = prefix_sigma_x_factors(M, count) * site_sigma_x(M, count)
        assert left == right

print("RESULT: PASS")
