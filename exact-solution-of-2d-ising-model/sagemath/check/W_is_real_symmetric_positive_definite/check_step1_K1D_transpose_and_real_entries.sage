# 対象ラベル: W_is_real_symmetric_positive_definite
# Step 1 の K_1D の実対称性の行を 1 行ずつ確かめる。M_col = 1..6（M_col = 1 は m^+ = m の場合）。
# - 準備: m^+（m ≤ M_col−1 で m+1、m = M_col で 1）について σ_{m+1}^z = σ_{m^+}^z（def_site_pauli_periodic_extension）と
#   σ_{m^+}^zσ_m^z = σ_m^zσ_{m^+}^z（m^+ ≠ m は distinct_site_pauli_matrices_commute、m^+ = m は M_col = 1 だけ）。
# - (σ_k^z)^⊤ = σ_k^z の 5 行、(σ_m^zσ_{m+1}^z)^⊤ = σ_m^zσ_{m+1}^z の 5 行、(K_1D)^⊤ = K_1D の 5 行。
# - 成分の実性の 2 段落（σ_k^z、σ_m^zσ_{m^+}^z、σ_m^zσ_{m+1}^z、D、K_1D = (K_1)_ℂD）。
# 各行の行列は本文の字面どおりに組む（クロネッカー積は def_kronecker (2) の成分の式 kron、転置は def_matrix_transpose の
# 成分の式 body_transpose、積は mat_mult の body_product、スカラー倍・有限和は成分の式）。K_1 は KG = QQ(i) 上の実の不定元。
# 浮動小数点は使わない。
load("_prelude.sage")

P.<K1> = PolynomialRing(KG)   # 実の不定元
T = body_transpose


def check_rows(rows, what):
    for k in range(1, len(rows)):
        eq(rows[k - 1], rows[k], f"{what}: 第 {k} 行と第 {k + 1} 行")


# 引く 2×2 の主張（transpose_of_identity_matrix_of_order_two・transpose_of_pauli_z）
assert T(I2) == I2 and T(SZ) == SZ

for M in range(1, 7):
    n = 2**M
    # 準備: m^+、σ_{m+1}^z = σ_{m^+}^z、σ_{m^+}^zσ_m^z = σ_m^zσ_{m^+}^z
    plus = {m: (m + 1 if m <= M - 1 else 1) for m in range(1, M + 1)}
    for m in range(1, M + 1):
        assert 1 <= plus[m] <= M
        eq(site_periodic_z(M, m + 1), site(M, plus[m], 'z'), f"M={M}, m={m}: σ_(m+1)^z = σ_(m^+)^z")
        assert (plus[m] == m) == (M == 1), (M, m)
        eq(body_product(site(M, plus[m], 'z'), site(M, m, 'z')),
           body_product(site(M, m, 'z'), site(M, plus[m], 'z')), f"M={M}, m={m}: σ_(m^+)^zσ_m^z = σ_m^zσ_(m^+)^z")
    # (σ_k^z)^⊤ = σ_k^z の 5 行
    for k in range(1, M + 1):
        f = lambda A, B: [A if j == k else B for j in range(1, M + 1)]
        check_rows([
            T(site(M, k, 'z')),
            T(kron(f(SZ, I2))),
            kron(f(T(SZ), T(I2))),
            kron(f(T(SZ), I2)),
            kron(f(SZ, I2)),
            site(M, k, 'z'),
        ], f"M={M}, k={k}: (σ_k^z)^⊤")
    # (σ_m^zσ_{m+1}^z)^⊤ = σ_m^zσ_{m+1}^z の 5 行
    bonds = []
    for m in range(1, M + 1):
        Zm, Zn, Zp = site(M, m, 'z'), site_periodic_z(M, m + 1), site(M, plus[m], 'z')
        bond = body_product(Zm, Zn)
        bonds.append(bond)
        check_rows([
            T(bond),
            T(body_product(Zm, Zp)),
            body_product(T(Zp), T(Zm)),
            body_product(Zp, Zm),
            body_product(Zm, Zp),
            bond,
        ], f"M={M}, m={m}: (σ_m^zσ_(m+1)^z)^⊤")
    # (K_1D)^⊤ = K_1D の 5 行（D は def_transfer_matrix_square_root の有限和）
    D = bond_sum(M)
    eq(D, body_finite_sum(bonds), f"M={M}: D の定義")
    bondsP = [b.change_ring(P) for b in bonds]
    K1D = body_scalar(K1, D.change_ring(P))
    check_rows([
        T(K1D),
        T(body_scalar(K1, body_finite_sum(bondsP))),
        body_scalar(K1, T(body_finite_sum(bondsP))),
        body_scalar(K1, body_finite_sum([T(b) for b in bondsP])),
        body_scalar(K1, body_finite_sum(bondsP)),
        K1D,
    ], f"M={M}: (K_1D)^⊤")
    # 成分の実性: 因子 I・σ^z、σ_k^z、σ_m^zσ_(m^+)^z、σ_m^zσ_(m+1)^z、D、K_1D
    assert entries_are_real(I2) and entries_are_real(SZ)
    for k in range(1, M + 1):
        assert site(M, k, 'z') == kron([SZ if j == k else I2 for j in range(1, M + 1)])
        assert entries_are_real(site(M, k, 'z')), (M, k)
    for m in range(1, M + 1):
        assert entries_are_real(body_product(site(M, m, 'z'), site(M, plus[m], 'z'))), (M, m)
        assert entries_are_real(bonds[m - 1]), (M, m)
    assert entries_are_real(D)
    assert entries_are_real(K1D)
    # 否定コントロール: 転置の積の並びを逆にしない (σ_1^zσ_1^x)^⊤ ≠ (σ_1^z)^⊤(σ_1^x)^⊤
    ZX = body_product(site(M, 1, 'z'), site(M, 1, 'x'))
    neq(T(ZX), body_product(T(site(M, 1, 'z')), T(site(M, 1, 'x'))), f"M={M}: 並びを逆にしない転置の積")
    # 否定コントロール: σ^y を因子に持つ σ_1^y は成分が実でない（因子の実性が効いている）
    assert not entries_are_real(site(M, 1, 'y'))
    n_neg += 1
    # 否定コントロール: 周期端を σ_(M+1)^z := I と取り違えた和は D と違う
    wrong = body_finite_sum([body_product(site(M, m, 'z'), site(M, m + 1, 'z') if m < M else body_identity(KG, n))
                             for m in range(1, M + 1)])
    neq(wrong, D, f"M={M}: 周期端を落とした和")
    print(f"M_col = {M}: Step 1 の K_1D の転置の鎖と成分の実性を確かめた（累計の等号 {n_steps} 個）")
print(f"等号 {n_steps} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
