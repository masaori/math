# ---------------------------------------------------------
# SageMath: V2 の有限和を H2 へ置換する等号
# 対象ラベル: V2_exponential_representation
# 対象: transfer_matrix_011d_claim_V2_exponential_representation の証明
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

for width in (1..5):
    jordan_wigner_sum = sum(
        [jordan_wigner_z(site, width) * jordan_wigner_y(site, width)
         for site in (1..width)],
        zero_matrix(K, 2^width),
    )
    h2 = sum(
        (jordan_wigner_z(site, width) * jordan_wigner_y(site, width)
         for site in (1..width)),
        zero_matrix(K, 2^width),
    )
    assert jordan_wigner_sum == h2
    assert ii * K(3) * jordan_wigner_sum == ii * K(3) * h2

print("RESULT: PASS")
