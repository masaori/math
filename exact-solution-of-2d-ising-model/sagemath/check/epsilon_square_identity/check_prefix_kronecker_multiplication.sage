# 対象ラベル: epsilon_square_identity
# 本文の帰納段第二行: 二つのクロネッカー積の積を因子ごとの積へ直す。
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    for count in range(0, M):
        left = prefix_sigma_x_factors(M, count) * site_sigma_x(M, count)
        right = kronecker_factors([
            sigma_x * identity_two if site < count
            else identity_two * sigma_x if site == count
            else identity_two * identity_two
            for site in range(M)
        ])
        assert left == right

print("RESULT: PASS")
