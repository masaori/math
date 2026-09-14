# 対象ラベル: epsilon_square_identity
# 本文の帰納段第三行: AI=IA=A と II=I を各因子へ適用する。
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in [1, 2, 3, 4, 5]:
    for count in range(0, M):
        left = kronecker_factors([
            sigma_x * identity_two if site < count
            else identity_two * sigma_x if site == count
            else identity_two * identity_two
            for site in range(M)
        ])
        right = prefix_sigma_x_factors(M, count + 1)
        assert left == right

print("RESULT: PASS")
