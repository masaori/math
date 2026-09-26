# ---------------------------------------------------------
# SageMath: 証明の中間目標「V_2 を A のクロネッカー冪で書く」の各行
#   (V_2)_{ord(μ),ord(μ')} = exp(K_2 Σ μ(m)μ'(m)) = Π_m exp(K_2 μ(m)μ'(m)) = Π_m A_{i_m j_m}
#     = (A^{⊠M})_{ν(ι(μ)),ν(ι(μ'))} = (A^{⊠M})_{ord(μ),ord(μ')}
#   A_{ij} = exp(K_2 ς_i ς_j), ς_1 = +1, ς_2 = -1
# 対象ラベル: second_transfer_matrix_pauli_form
# 対象: structured-latex/content/004_transfer_matrix.ts
#       ブロック transfer_matrix_claim_second_transfer_matrix_pauli_form の proof 前半
# 帰属: exp(K_2 n) を x^n（x = exp(K_2) を不定元とする Laurent 多項式環 ZZ[x, x^{-1}]）で表す。
#       exp(K_2 n) = exp(K_2)^n（n ∈ ZZ）なので、ここでの等号は任意の K_2 について成り立つ等号と同値。
#       ℝ 脱出なし。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
L = LaurentPolynomialRing(ZZ, 'x')
xL = L.gen()
varsigma = {ZZ(1): 1, ZZ(2): -1}
A = matrix(L, 2, 2, lambda i, j: xL ** (varsigma[ZZ(i + 1)] * varsigma[ZZ(j + 1)]))
ok_all = (A == matrix(L, [[xL, xL ** -1], [xL ** -1, xL]]))
for M_col in range(1, 7):
    V2 = V2_by_components(M_col, lambda n: xL ** n, L)
    Ak = kron_by_definition([A] * M_col, L)
    ok = (V2 == Ak)
    for mu in row_configurations(M_col):
        I = iota(mu)
        for mup in row_configurations(M_col):
            J = iota(mup)
            o, op = ord_number(mu), ord_number(mup)
            chain = [V2[o - 1, op - 1],
                     xL ** sum(mu[m] * mup[m] for m in range(M_col)),
                     prod([xL ** (mu[m] * mup[m]) for m in range(M_col)], L(1)),
                     prod([A[I[m] - 1, J[m] - 1] for m in range(M_col)], L(1)),
                     Ak[nu_number(I) - 1, nu_number(J) - 1],
                     Ak[o - 1, op - 1]]
            ok = ok and all(c == chain[0] for c in chain)
    print(f"  M_col={M_col}: V_2（成分定義、ord で指す） = A^(⊠M_col) を Laurent 多項式として、成分の 5 段も -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
