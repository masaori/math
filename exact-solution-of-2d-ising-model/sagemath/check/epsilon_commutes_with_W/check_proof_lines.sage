# 対象ラベル: epsilon_commutes_with_W
# 証明の準備（εD = Dε、ε(cD) = (cD)ε、εV_2 = V_2ε、εS = Sε の 3 行）、本体の 11 行の鎖、
# F^(+) の鎖 4 行と結論 Wf ∈ F^(+) を、行の括弧の形どおりに mat_mult の成分の式（body_product）で組んで厳密に確かめる。
#
# 計算の帰属:
#  - ε・σ_m^z・D は QQ(i)（KG）の行列。共通の準備 pauli_sites_exact.sage が def_kronecker の成分の式と Sage の
#    tensor_product の二通りで作り、一致を確かめてから使う。
#  - c := ((1/2)K_1)_ℂ は KG[c] の不定元（ε(cD) = (cD)ε の行）。
#  - Y := exp((1/2)K_1)、X2 := exp(K_2) を Laurent 多項式環 RL := KG[Y^{±1}, X2^{±1}] の不定元に置く。
#    D は整数の固有値 λ をもつ対角化可能な行列なので、S := V_1^{1/2} = exp(cD) を固有値の射影 P_λ から S := Σ_λ Y^λ P_λ と作る
#    （exp(cλ) = exp((1/2)K_1)^λ は実数の exp の指数法則を肩が整数倍のときにだけ使う）。V_2 は def_transfer_matrix の成分
#    exp(K_2 Σ_m μ(m)μ'(m)) = X2^{Σ μμ'} から作る。
#  ℝ への脱出は実数の exp の値を不定元に置く一点だけで、以後の等号は全て RL の厳密計算である。浮動小数点は使わない。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/row_configurations.sage")

n_eq = 0
n_neg = 0


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


def neq(a, b, what):
    global n_neg
    assert a != b, what
    n_neg += 1


P = body_product
RL = LaurentPolynomialRing(KG, ['Y', 'X2'])
Yg, X2g = RL.gens()
PC = PolynomialRing(KG, 'c')
cg = PC.gen()

for M in range(1, 6):
    n = 2**M
    eps = epsilon(M)                       # def_global_spin_flip_matrix（本文の経路と Sage の経路の一致は epsilon() の中で確かめる）
    D = bond_sum(M)                        # D := Σ_m σ_m^z σ_{m+1}^z（def_finite_sum_of_matrices の左からの和）
    # D を別の経路（row_configurations.sage の site_pauli、Sage の行列積と和）でも作って一致を見る
    D_alt = sum((site_pauli('z', m, M) * site_pauli('z', 1 if m == M else m + 1, M) for m in range(1, M + 1)), matrix(ZZ, n, n, 0))
    eq(D, D_alt.change_ring(KG), f"M={M}: D の二つの経路")

    # ---- 準備 1: εD = Dε（epsilon_commutes_with_bond_sum）----
    eq(P(eps, D), P(D, eps), f"M={M}: εD = Dε")

    # ---- 準備 2: ε(cD) = (cD)ε（commuting_with_scalar_multiple、c は不定元）----
    epsC = eps.change_ring(PC)
    cD = body_scalar(cg, D.change_ring(PC))
    eq(P(epsC, cD), P(cD, epsC), f"M={M}: ε(cD) = (cD)ε")

    # ---- B = exp(cD) と V_2 ----
    B = exp_by_spectral_projectors(D.change_ring(QQ), lambda lam: Yg**lam, RL)
    V1 = V1_by_components(M, lambda m: Yg**(2 * m), RL)
    eq(B * B, V1, f"M={M}: BB = V_1（B が def_transfer_matrix_square_root の平方根であること）")
    V2 = V2_by_components(M, lambda m: X2g**m, RL)
    E = eps.change_ring(RL)

    # ---- 準備 3: εV_2 = V_2ε（epsilon_commutes_with_V2）----
    eq(P(E, V2), P(V2, E), f"M={M}: εV_2 = V_2ε")

    # ---- 準備の鎖: εS = ε exp(cD) = exp(cD)ε = Sε（コード中の B が証明の S := V_1^{1/2}）----
    expcD = B                              # 1 行目・3 行目は def_transfer_matrix_square_root（構成上の一致）
    b_lines = [P(E, B), P(E, expcD), P(expcD, E), P(B, E)]
    for k in range(3):
        eq(b_lines[k], b_lines[k + 1], f"M={M}: εB の鎖の {k + 1} 行目")

    # ---- 本体の鎖 11 行 ----
    BV2 = P(B, V2)
    W = P(BV2, B)                          # def_symmetrized_transfer_matrix: W := (V_1^{1/2}V_2)V_1^{1/2}
    eq(W, B * V2 * B, f"M={M}: W の二つの経路（mat_mult と Sage の積）")
    lines = [
        P(E, W),                                  # εW
        P(E, P(BV2, B)),                          # ε((BV_2)B)
        P(P(E, BV2), B),                          # (ε(BV_2))B
        P(P(P(E, B), V2), B),                     # ((εB)V_2)B
        P(P(P(B, E), V2), B),                     # ((Bε)V_2)B
        P(P(B, P(E, V2)), B),                     # (B(εV_2))B
        P(P(B, P(V2, E)), B),                     # (B(V_2ε))B
        P(P(BV2, E), B),                          # ((BV_2)ε)B
        P(BV2, P(E, B)),                          # (BV_2)(εB)
        P(BV2, P(B, E)),                          # (BV_2)(Bε)
        P(P(BV2, B), E),                          # ((BV_2)B)ε
        P(W, E),                                  # Wε
    ]
    for k in range(11):
        eq(lines[k], lines[k + 1], f"M={M}: 本体の鎖の {k + 1} 行目")

    # ---- F^(+) の鎖 ----
    Fp = (eps - identity_matrix(KG, n)).right_kernel().basis()
    eq(len(Fp), 2**(M - 1), f"M={M}: dim F^(+) = 2^(M-1)")
    vecs = [vector(KG, f) for f in Fp]
    vecs += [sum((KG(j + 1) + (j % 3) * i_K) * f for j, f in enumerate(vecs)), sum(((-1)**j * (2 - i_K)) * f for j, f in enumerate(vecs))]
    for f in vecs:
        fc = matrix(RL, n, 1, list(f))     # mat_mult の取り決め: n 行 1 列の行列
        eq(P(E, fc), fc, f"M={M}: εf = f")
        f_lines = [P(E, P(W, fc)), P(P(E, W), fc), P(P(W, E), fc), P(W, P(E, fc)), P(W, fc)]
        for k in range(4):
            eq(f_lines[k], f_lines[k + 1], f"M={M}: F^(+) の鎖の {k + 1} 行目")

    # ---- 否定コントロール ----
    # (1) ε の代わりに σ_1^z（D・B と可換だが V_2 と可換でない）では、εV_2 = V_2ε を当てる 6 行目と結論が崩れる。
    G = site(M, 1, 'z').change_ring(RL)
    eq(P(G, B), P(B, G), f"M={M}: 対照: σ_1^z は B と可換")
    neq(P(P(B, P(G, V2)), B), P(P(B, P(V2, G)), B), f"M={M}: 対照: σ_1^z では本体の鎖の 6 行目が崩れる")
    neq(P(G, W), P(W, G), f"M={M}: 対照: σ_1^z W ≠ W σ_1^z")
    # (2) ε と可換でない B'（成分 Y^k の対角行列）では εB' = B'ε が崩れ、本体の鎖の 4 行目が崩れる。
    Bp = diagonal_matrix(RL, [Yg**k for k in range(n)])
    neq(P(P(P(E, Bp), V2), Bp), P(P(P(Bp, E), V2), Bp), f"M={M}: 対照: ε と可換でない B' では 4 行目が崩れる")
    # (3) εf = −f の f では ε(Wf) ≠ Wf（最後の行 εf = f が要る）。
    Fm = (eps + identity_matrix(KG, n)).right_kernel().basis()
    for f in Fm[:2]:
        fc = matrix(RL, n, 1, list(f))
        neq(P(E, P(W, fc)), P(W, fc), f"M={M}: 対照: εf = −f では ε(Wf) ≠ Wf")
    print(f"M={M}: ok")

print(f"等号 {n_eq} 件、否定コントロール {n_neg} 件")
print("RESULT: PASS")
