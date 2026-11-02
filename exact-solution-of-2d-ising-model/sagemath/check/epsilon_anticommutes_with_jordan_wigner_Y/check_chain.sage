# 対象ラベル: epsilon_anticommutes_with_jordan_wigner_Y
# Y_m = σ_1^x⋯σ_{m-1}^xσ_m^y = σ^x⊠⋯⊠σ^x⊠σ^y⊠I⊠⋯⊠I、因子の条件、εY_m + Y_mε = O、εY_m = -(Y_mε) を
# M_col = 1..5、全ての m で厳密に。Y_m は本文の積（左から掛ける）と Sage の積の二通りで作る（jw）。
load("_prelude.sage")
P = body_product
check_chain([P(I2, SX), SX, P(SX, I2)], "i > m の因子の条件")
assert P(PAULI['y'], SX) == body_negation(P(SX, PAULI['y']))
for M in range(1, 6):
    E = epsilon(M)
    O = matrix(KG, 2**M, 2**M, 0)
    for m in range(1, M + 1):
        J = jw(M, m, 'y')
        factors = [SX] * (m - 1) + [PAULI['y']] + [I2] * (M - m)
        assert J == prefix_product(M, ['x'] * (m - 1) + ['y']) == kron(factors)
        assert body_sum(P(E, J), P(J, E)) == body_sum(P(kron([SX] * M), kron(factors)), P(kron(factors), kron([SX] * M))) == O
        assert P(E, J) == body_negation(P(J, E))
    print(f"  M_col={M}: 全ての m で εY_m = -(Y_mε)")
print("RESULT: PASS")
