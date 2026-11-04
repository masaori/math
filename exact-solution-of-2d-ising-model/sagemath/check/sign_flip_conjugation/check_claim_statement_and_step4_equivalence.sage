# 対象ラベル: sign_flip_conjugation
# 主張そのものと、Step 4 の最後の段落（i(K_1)_ℂ, i(K_2^*)_ℂ ≠ 0 なので S の等式と H の等式は同値）を、
# ガウス有理数体 QQ(i) とその上の多項式環の厳密計算で確かめる（浮動小数点は使わない）。M_col = 2..6（(c) は 2..5）。
#   (a) 主張の定義どおりに E_m・E := E_1⊠…⊠E_M・F := σ^z⊠…⊠σ^z・U := EF を組み、U は可逆（det U ≠ 0、
#       Sage の逆行列が Step 0 の U^{-1} = FE と一致）。
#   (b) UH_1^{(+)}U^{-1} = -H_1^{(+)}、UH_2U^{-1} = -H_2 を、Z_m・Y_m を def_jordan_wigner_Z_matrices・
#       def_jordan_wigner_Y_matrices の左から掛けた積で組み、Sage の逆行列（証明とは別の経路）で確かめる。
#   (c) US_1^{(+)}U^{-1} = -S_1^{(+)}、US_2U^{-1} = -S_2 を、K_1・K_2^* を不定元にした QQ(i)[K_1, K_2^*] で（M_col = 2..5）。
#   (d) 最後の段落の「逆に」の向き: 正の有理数 K（実数の代表）で a := iK ≠ 0、a^{-1} = (-i)K^{-1} とし、
#       UHU^{-1} = a^{-1}(a(UHU^{-1})) = a^{-1}((U(aH))U^{-1}) = a^{-1}(-(aH)) = -H を一行ずつ。
# 否定コントロール: U の代わりに F だけ・E だけで共役すると H_1^{(+)} か H_2 の符号が反転しない。
#   K = 0（a = 0）なら S = O なので S の等式は U の代わりに F を置いても成り立つが、H の等式は成り立たない
#   （最後の段落が a ≠ 0 を要ることの確認）。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = identity_matrix(GAUSSIAN, 2)


def kron(factors):
    # def_kronecker: 多重添字 (s_1..s_M), (t_1..t_M) の成分は ∏_k (A_k)_{s_k t_k}。Sage の tensor_product と突き合わせる
    M = len(factors)
    d = 2 ** M
    def entry(r, c):
        val = GAUSSIAN(1)
        for k in range(M):
            val *= factors[k][(r >> (M - 1 - k)) & 1, (c >> (M - 1 - k)) & 1]
        return val
    out = matrix(GAUSSIAN, d, d, entry)
    ref = matrix(GAUSSIAN, 1, 1, [1])
    for A in factors:
        ref = ref.tensor_product(A)
    assert out == ref
    return out


def site(M, k, A):
    # def_site_pauli_matrices: 第 k 因子だけ A、他は I
    return kron([A if m == k else id2 for m in range(1, M + 1)])


count = 0
neg_count = 0


def check(b, label):
    global count
    assert b, label
    count += 1


for M in range(2, 7):
    d = 2 ** M
    Id = identity_matrix(GAUSSIAN, d)
    # (a) 主張の定義
    Em = {m: (sx if m % 2 == 1 else id2) for m in range(1, M + 1)}
    E = kron([Em[m] for m in range(1, M + 1)])
    F = kron([sz] * M)
    U = E * F
    check(U.det() != 0, "U は可逆 M=%d" % M)
    Uinv = U.inverse()
    check(Uinv == F * E, "U^{-1} = FE M=%d" % M)
    check(U * Uinv == Id and Uinv * U == Id, "UU^{-1} = U^{-1}U = I M=%d" % M)
    # Jordan–Wigner の Z_m・Y_m（左から掛けた積 σ_1^x⋯σ_{m-1}^xσ_m^a）
    SX = {k: site(M, k, sx) for k in range(1, M + 1)}
    SY = {k: site(M, k, sy) for k in range(1, M + 1)}
    SZ = {k: site(M, k, sz) for k in range(1, M + 1)}
    def jw(m, last):
        P = Id
        for r in range(1, m):
            P = P * SX[r]
        return P * last[m]
    Z = {m: jw(m, SZ) for m in range(1, M + 1)}
    Y = {m: jw(m, SY) for m in range(1, M + 1)}
    H1 = sum((Y[m] * Z[m + 1] for m in range(1, M)), matrix(GAUSSIAN, d, d, 0)) - Y[M] * Z[1]   # def_H1_plus
    H2 = sum((Z[m] * Y[m] for m in range(1, M + 1)), matrix(GAUSSIAN, d, d, 0))                # def_H2
    check(H1 != 0 and H2 != 0, "H は零でない M=%d" % M)
    # (b) H の等式（Sage の逆行列で）
    check((U * H1) * Uinv == -H1, "UH_1U^{-1} = -H_1 M=%d" % M)
    check((U * H2) * Uinv == -H2, "UH_2U^{-1} = -H_2 M=%d" % M)
    # (c) S の等式（K_1, K_2^* は不定元。多項式環の 2^M 次の積が重いので M_col ≤ 5）
    if M <= 5:
      R = PolynomialRing(GAUSSIAN, ["K1", "K2s"])
      K1, K2s = R.gens()
      UR, UinvR = U.change_ring(R), Uinv.change_ring(R)
      S1 = (I_ * K1) * H1.change_ring(R)
      S2 = (I_ * K2s) * H2.change_ring(R)
      check((UR * S1) * UinvR == -S1, "US_1U^{-1} = -S_1 M=%d" % M)
      check((UR * S2) * UinvR == -S2, "US_2U^{-1} = -S_2 M=%d" % M)
    # (d) 最後の段落の「逆に」の向き（正の有理数 K を実数の代表として）
    for Kval in [QQ(1) / 3, QQ(2), QQ(5) / 7]:
        a = I_ * Kval
        check(a != 0, "a = iK ≠ 0")
        ainv = (-I_) * (1 / Kval)
        check(a * ainv == 1 and ainv * a == 1, "a^{-1} = (-i)K^{-1}")
        for H in [H1, H2]:
            S = a * H
            check((U * S) * Uinv == -S, "S の等式（仮定）")
            rows = [
                (U * H) * Uinv,                       # UHU^{-1}
                ainv * (a * ((U * H) * Uinv)),        # a^{-1}a = 1 と scalar_multiple_by_one を右辺から左辺へ
                ainv * ((U * (a * H)) * Uinv),        # スカラー倍を積の外から中へ（右の因子・左の因子）
                ainv * (-(a * H)),                    # S の等式
                -H,                                   # a^{-1}(-(aH)) = -((a^{-1}a)H) = -H
            ]
            for j in range(1, len(rows)):
                check(rows[j] == rows[j - 1], "最後の段落の鎖の %d 行目 M=%d" % (j, M))
    # 否定コントロール
    Finv, Einv = F.inverse(), E.inverse()
    assert (F * H1) * Finv != -H1 and (F * H2) * Finv == -H2, "F だけでは H_1 の符号が反転しない"
    assert (E * H2) * Einv != -H2, "E だけでは H_2 の符号が反転しない"
    neg_count += 2
    S1zero = GAUSSIAN(0) * H1
    assert (F * S1zero) * Finv == -S1zero and (F * H1) * Finv != -H1, "a = 0 なら S の等式から H の等式は従わない"
    neg_count += 1
    print("M_col = %d: PASS" % M)

print("PASS sign_flip_conjugation の主張と Step 4 の最後の段落: %d 段、否定コントロール %d 件" % (count, neg_count))
