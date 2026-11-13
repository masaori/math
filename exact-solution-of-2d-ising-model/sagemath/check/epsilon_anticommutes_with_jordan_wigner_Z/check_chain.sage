# 対象ラベル: epsilon_anticommutes_with_jordan_wigner_Z
# 証明の (k)（F_j^{(z)} = σ_j^{a_j}）、Z_m の 4 行の鎖（def_jordan_wigner_Z_matrices の有限積 Π F_j^{(z)} → Π σ_j^{a_j} →
# site_pauli_prefix_product_kronecker_form → a_j の定義）、因子の条件、εZ_m + Z_mε = O、εZ_m = -(Z_mε) を
# M_col = 1..5、全ての m で厳密に。Z_m は本文の積（左から掛ける）と Sage の積の二通りで作る（jw）。
load("_prelude.sage")
P = body_product


def finite_product(As):
    """def_finite_product_of_matrices: Π^1 := A_1、Π^{r+1} := (Π^r)A_{r+1}（左から掛ける）。"""
    Q = As[0]
    for A in As[1:]:
        Q = P(Q, A)
    return Q


check_chain([P(I2, SX), SX, P(SX, I2)], "i > m の因子の条件")
assert P(PAULI['z'], SX) == body_negation(P(SX, PAULI['z']))
for M in range(1, 6):
    E = epsilon(M)
    O = matrix(KG, 2**M, 2**M, 0)
    for m in range(1, M + 1):
        J = jw(M, m, 'z')
        a = ['x'] * (m - 1) + ['z']                                    # a_j の定義
        F = [site(M, j, 'x') for j in range(1, m)] + [site(M, m, 'z')]  # def_jordan_wigner_Z_matrices の F_j^{(z)}
        for j in range(1, m + 1):
            assert F[j - 1] == site(M, j, a[j - 1])                    # (k)
        factors = [SX] * (m - 1) + [PAULI['z']] + [I2] * (M - m)
        check_chain([J,
                     finite_product(F),                                 # def_jordan_wigner_Z_matrices
                     finite_product([site(M, j, a[j - 1]) for j in range(1, m + 1)]),  # (k) を m 個の因子へ
                     kron([PAULI[c] for c in a] + [I2] * (M - m)),      # site_pauli_prefix_product_kronecker_form (r → m)
                     kron(factors)],                                    # a_j の定義を m か所へ
                    f"Z_m の鎖 (M_col={M}, m={m})")
        assert body_sum(P(E, J), P(J, E)) == body_sum(P(kron([SX] * M), kron(factors)), P(kron(factors), kron([SX] * M))) == O
        assert P(E, J) == body_negation(P(J, E))
    print(f"  M_col={M}: 全ての m で εZ_m = -(Z_mε)")
print("RESULT: PASS")
