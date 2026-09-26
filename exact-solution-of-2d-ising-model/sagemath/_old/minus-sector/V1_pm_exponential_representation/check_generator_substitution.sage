# ---------------------------------------------------------
# SageMath: V1^(±) の有限和を H1^(±) へ置換する等号
# 対象ラベル: V1_pm_exponential_representation
# 対象: transfer_matrix_011c_claim_V1_pm_exponential_representation の証明
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

for width in (2..5):
    for boundary_sign in [K(-1), K(1)]:
        definition_sum = sum(
            (jordan_wigner_y(site, width) * jordan_wigner_z(site + 1, width)
             for site in (1..(width - 1))),
            zero_matrix(K, 2^width),
        ) + boundary_sign * jordan_wigner_y(width, width) * jordan_wigner_z(1, width)
        h1 = sum(
            ((boundary_sign if site == width else K(1))
             * jordan_wigner_y(site, width)
             * jordan_wigner_z(1 if site == width else site + 1, width)
             for site in (1..width)),
            zero_matrix(K, 2^width),
        )
        assert definition_sum == h1
        assert ii * K(2) * definition_sum == ii * K(2) * h1

print("RESULT: PASS")
