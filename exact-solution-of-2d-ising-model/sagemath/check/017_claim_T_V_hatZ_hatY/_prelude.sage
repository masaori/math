# ---------------------------------------------------------
# 共通: B_1(theta), B_2 の定義（structured-latex 側 T_V_hatZ_hatY の proof と同じ）
#   B_1(theta) = mat(cosh K1, -i e^{i theta} sinh K1; i e^{-i theta} sinh K1, cosh K1)
#   B_2        = mat(cosh 2K2*, i sinh 2K2*; -i sinh 2K2*, cosh 2K2*)
# ---------------------------------------------------------
def B_1(th):
    return matrix([
        [cosh(K1),                     -i * exp(i*th) * sinh(K1)],
        [i * exp(-i*th) * sinh(K1),    cosh(K1)]
    ])

B_2 = matrix([
    [c_2_star,      i * s_2_star],
    [-i * s_2_star, c_2_star]
])

def B1_B2_B1(th):
    return B_1(th) * B_2 * B_1(th)
