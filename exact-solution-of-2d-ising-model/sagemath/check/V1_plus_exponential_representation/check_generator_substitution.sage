# ---------------------------------------------------------
# SageMath: V_1^{(+)} の有限和を H_1^{(+)} へ置換する等号
# 対象ラベル: V1_plus_exponential_representation
# 対象: transfer_matrix_011c_claim_V1_pm_exponential_representation の証明
#   V_1^{(+)} = exp(i K_1 (sum_{m=1}^{M-1} Y_m Z_{m+1} - Y_M Z_1))   （def_V1_plus）
#             = exp(i K_1 H_1^{(+)})                                  （def_H1_plus）
# 帰属: 行列成分は QQ(i)。有限次元の厳密等号だけを判定し、浮動小数点を使わない。
# ---------------------------------------------------------
K.<ii> = QuadraticField(-1)

I2 = identity_matrix(K, 2)
SX = matrix(K, [[0, 1], [1, 0]])
SY = matrix(K, [[0, -ii], [ii, 0]])
SZ = matrix(K, [[1, 0], [0, -1]])

def kron_list(matrices):
    result = matrix(K, [[1]])
    for item in matrices:
        result = result.tensor_product(item)
    return result

def jordan_wigner_z(site, width):
    return kron_list([SX if index < site else (SZ if index == site else I2)
                      for index in (1..width)])

def jordan_wigner_y(site, width):
    return kron_list([SX if index < site else (SY if index == site else I2)
                      for index in (1..width)])

for width in (2..6):
    # def_V1_plus の指数の中の有限和（M_col = 2 では一項 Y_1 Z_2 だけ）
    definition_sum = sum(
        (jordan_wigner_y(site, width) * jordan_wigner_z(site + 1, width)
         for site in (1..(width - 1))),
        zero_matrix(K, 2^width),
    ) - jordan_wigner_y(width, width) * jordan_wigner_z(1, width)
    # def_H1_plus: H_1^{(+)} を周期的な添字 m -> m+1 (mod M_col) の M_col 項の和として、
    # 境界の項 (m = M_col) だけ符号 -1 を付けて独立に組み立てる
    h1_plus = sum(
        ((K(-1) if site == width else K(1))
         * jordan_wigner_y(site, width)
         * jordan_wigner_z(1 if site == width else site + 1, width)
         for site in (1..width)),
        zero_matrix(K, 2^width),
    )
    assert definition_sum == h1_plus
    # 指数関数の引数 i K_1 (...) が等しいこと（K_1 は記号のまま扱えないので、
    # 有理数の代表値 K_1 = 1, 2/5 で係数倍の一致を確かめる）
    for k1 in [K(1), K(2/5)]:
        assert ii * k1 * definition_sum == ii * k1 * h1_plus
    print(f"  M_col={width}: sum Y_mZ_(m+1) - Y_M Z_1 = H_1^(+)（QQ(i) 上で厳密に一致）")

print("RESULT: PASS")
