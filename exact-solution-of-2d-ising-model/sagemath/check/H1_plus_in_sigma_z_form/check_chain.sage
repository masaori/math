# 対象ラベル: H1_plus_in_sigma_z_form（iH_1^{(+)} = D_0 + εG）
# 証明の準備 1〜4 と最後の鎖の全ての行を、行に書かれた形のとおりに組み、隣どうしを QQ(i) で厳密に比べる。
#   - 「σ_1^x⋯σ_{m-1}^xσ_m^y」などサイトの積の行は、def_site_pauli_matrices の σ_k^a を mat_mult の積で左から掛けて組む（prefix_product）。
#   - 「A_1⊠⋯⊠A_M」の行は def_kronecker (2) の成分の式で組む。因子の積 (AB) は 2 次の mat_mult、(cA) は def_matrix_scalar_multiple。
#   - スカラーの積 i·(−i)・(−1)·i は definition_of_cc の積を QQ の対で計算した値（cc_mul）で組む。
# M_col = 2..5、準備 1・3 は全ての m ∈ {1,…,M_col−1}。浮動小数点は使わない。
load("_prelude.sage")

rep = Report("H1_plus_in_sigma_z_form: 準備 1〜4 と最後の鎖")
i = i_
for M in range(2, 6):
    eps = epsilon(M)
    YM = jw(M, M, 'y')
    Z1 = jw(M, 1, 'z')
    G = P_(site(M, M, 'z'), site(M, 1, 'z'))              # def_G_boundary_operator
    for m in range(1, M):
        # 準備 1
        rep.chain([("Y_m", jw(M, m, 'y')),
                   ("σ_1^x⋯σ_{m-1}^xσ_m^y", prefix_product(M, ['x'] * (m - 1) + ['y'])),
                   ("σ^x…⊠σ^y⊠I…", kron([X] * (m - 1) + [Y] + [I] * (M - m)))], f"M={M} m={m} 準備1 Y_m")
        rep.chain([("Z_{m+1}", jw(M, m + 1, 'z')),
                   ("σ_1^x⋯σ_m^xσ_{m+1}^z", prefix_product(M, ['x'] * m + ['z'])),
                   ("σ^x…⊠σ^z⊠I…", kron([X] * m + [Z] + [I] * (M - m - 1)))], f"M={M} m={m} 準備1 Z_m+1")
        zz = kron([I] * (m - 1) + [Z, Z] + [I] * (M - m - 1))
        rep.chain([("σ_m^zσ_{m+1}^z", P_(site(M, m, 'z'), site(M, m + 1, 'z'))),
                   ("(I…σ^z…)(I…σ^z…)", P_(kron([I] * (m - 1) + [Z] + [I] * (M - m)), kron([I] * m + [Z] + [I] * (M - m - 1)))),
                   ("(II)…(σ^zI)(Iσ^z)(II)…", kron([P_(I, I)] * (m - 1) + [P_(Z, I), P_(I, Z)] + [P_(I, I)] * (M - m - 1))),
                   ("I…σ^z(Iσ^z)I…", kron([I] * (m - 1) + [Z, P_(I, Z)] + [I] * (M - m - 1))),
                   ("I…σ^zσ^zI…", zz)], f"M={M} m={m} 準備1 σσ")
        # 準備 3
        L = [("i(Y_mZ_{m+1})", S_(i, P_(jw(M, m, 'y'), jw(M, m + 1, 'z')))),
             ("i((σ^x…σ^y I…)Z_{m+1})", S_(i, P_(kron([X] * (m - 1) + [Y] + [I] * (M - m)), jw(M, m + 1, 'z')))),
             ("i((σ^x…σ^y I…)(σ^x…σ^z I…))", S_(i, P_(kron([X] * (m - 1) + [Y] + [I] * (M - m)), kron([X] * m + [Z] + [I] * (M - m - 1))))),
             ("i((σ^xσ^x)…(σ^yσ^x)(Iσ^z)(II)…)", S_(i, kron([P_(X, X)] * (m - 1) + [P_(Y, X), P_(I, Z)] + [P_(I, I)] * (M - m - 1)))),
             ("i(I…(σ^yσ^x)(Iσ^z)(II)…)", S_(i, kron([I] * (m - 1) + [P_(Y, X), P_(I, Z)] + [P_(I, I)] * (M - m - 1)))),
             ("i(I…(σ^yσ^x)σ^zI…)", S_(i, kron([I] * (m - 1) + [P_(Y, X), Z] + [I] * (M - m - 1)))),
             ("i(I…((−i)σ^z)σ^zI…)", S_(i, kron([I] * (m - 1) + [S_(minus_i, Z), Z] + [I] * (M - m - 1)))),
             ("i((−i)(I…σ^zσ^zI…))", S_(i, S_(minus_i, zz))),
             ("(i·(−i))(I…σ^zσ^zI…)", S_(cc_mul(i, minus_i), zz)),
             ("1_C(I…σ^zσ^zI…)", S_(KG(1), zz)),
             ("I…σ^zσ^zI…", zz),
             ("σ_m^zσ_{m+1}^z", P_(site(M, m, 'z'), site(M, m + 1, 'z')))]
        rep.chain(L, f"M={M} m={m} 準備3")
    # 準備 2
    rep.chain([("Y_M", YM), ("σ_1^x⋯σ_{M-1}^xσ_M^y", prefix_product(M, ['x'] * (M - 1) + ['y'])),
               ("σ^x…⊠σ^y", kron([X] * (M - 1) + [Y]))], f"M={M} 準備2 Y_M")
    rep.chain([("Z_1", Z1), ("σ_1^z", site(M, 1, 'z')), ("σ^z⊠I…", kron([Z] + [I] * (M - 1)))], f"M={M} 準備2 Z_1")
    rep.chain([("ε", eps), ("σ^x⊠…⊠σ^x", kron([X] * M))], f"M={M} 準備2 ε")
    zbd = kron([Z] + [I] * (M - 2) + [Z])
    rep.chain([("σ_M^zσ_1^z", P_(site(M, M, 'z'), site(M, 1, 'z'))),
               ("(I…σ^z)(σ^z I…)", P_(kron([I] * (M - 1) + [Z]), kron([Z] + [I] * (M - 1)))),
               ("(Iσ^z)(II)…(σ^zI)", kron([P_(I, Z)] + [P_(I, I)] * (M - 2) + [P_(Z, I)])),
               ("(Iσ^z)I…σ^z", kron([P_(I, Z)] + [I] * (M - 2) + [Z])),
               ("σ^zI…σ^z", zbd)], f"M={M} 準備2 σ_Mσ_1")
    # 準備 4
    B = P_(YM, Z1)
    yxy = kron([Y] + [X] * (M - 2) + [Y])
    L = [("−(i(Y_MZ_1))", N_(S_(i, B))),
         ("(−1)(i(Y_MZ_1))", S_(minus_one, S_(i, B))),
         ("((−1)·i)(Y_MZ_1)", S_(cc_mul(minus_one, i), B)),
         ("(−i)(Y_MZ_1)", S_(minus_i, B)),
         ("(−i)((σ^x…σ^y)Z_1)", S_(minus_i, P_(kron([X] * (M - 1) + [Y]), Z1))),
         ("(−i)((σ^x…σ^y)(σ^z I…))", S_(minus_i, P_(kron([X] * (M - 1) + [Y]), kron([Z] + [I] * (M - 1))))),
         ("(−i)((σ^xσ^z)(σ^xI)…(σ^yI))", S_(minus_i, kron([P_(X, Z)] + [P_(X, I)] * (M - 2) + [P_(Y, I)]))),
         ("(−i)((σ^xσ^z)σ^x…σ^y)", S_(minus_i, kron([P_(X, Z)] + [X] * (M - 2) + [Y]))),
         ("(−i)(((−i)σ^y)σ^x…σ^y)", S_(minus_i, kron([S_(minus_i, Y)] + [X] * (M - 2) + [Y]))),
         ("(−i)((−i)(σ^yσ^x…σ^y))", S_(minus_i, S_(minus_i, yxy))),
         ("(−i)(σ^yσ^x…((−i)σ^y))", S_(minus_i, kron([Y] + [X] * (M - 2) + [S_(minus_i, Y)]))),
         ("((−i)σ^y)σ^x…((−i)σ^y)", kron([S_(minus_i, Y)] + [X] * (M - 2) + [S_(minus_i, Y)])),
         ("(σ^xσ^z)σ^x…(σ^xσ^z)", kron([P_(X, Z)] + [X] * (M - 2) + [P_(X, Z)])),
         ("(σ^xσ^z)(σ^xI)…(σ^xσ^z)", kron([P_(X, Z)] + [P_(X, I)] * (M - 2) + [P_(X, Z)])),
         ("(σ^x…σ^x)(σ^zI…σ^z)", P_(kron([X] * M), zbd)),
         ("ε(σ^zI…σ^z)", P_(eps, zbd)),
         ("ε(σ_M^zσ_1^z)", P_(eps, P_(site(M, M, 'z'), site(M, 1, 'z')))),
         ("εG", P_(eps, G))]
    rep.chain(L, f"M={M} 準備4")
    # 最後の鎖
    terms = [P_(jw(M, m, 'y'), jw(M, m + 1, 'z')) for m in range(1, M)]
    D0 = F_([P_(site(M, m, 'z'), site(M, m + 1, 'z')) for m in range(1, M)])   # def_D0_open_chain_operator
    H = H1_plus(M)
    L = [("iH_1^{(+)}", S_(i, H)),
         ("i(ΣY_mZ_{m+1} − Y_MZ_1)", S_(i, D_(F_(terms), B))),
         ("i(Σ…) − i(Y_MZ_1)", D_(S_(i, F_(terms)), S_(i, B))),
         ("Σ(i(Y_mZ_{m+1})) − i(Y_MZ_1)", D_(F_([S_(i, T) for T in terms]), S_(i, B))),
         ("Σσ_m^zσ_{m+1}^z − i(Y_MZ_1)", D_(F_([P_(site(M, m, 'z'), site(M, m + 1, 'z')) for m in range(1, M)]), S_(i, B))),
         ("D_0 − i(Y_MZ_1)", D_(D0, S_(i, B))),
         ("D_0 + (−(i(Y_MZ_1)))", A_(D0, N_(S_(i, B)))),
         ("D_0 + εG", A_(D0, P_(eps, G)))]
    rep.chain(L, f"M={M} 最後の鎖")
    # 主張そのものを、Sage の tensor_product・`*`・`+` だけで組んだ独立な経路でも確かめる
    sx = lambda k: kron_sage(site_factors(M, k, X))
    sy = lambda k: kron_sage(site_factors(M, k, Y))
    sz = lambda k: kron_sage(site_factors(M, k, Z))
    jwS = lambda m, s: prod([sx(k) for k in range(1, m)], identity_matrix(KG, 2**M)) * s(m)
    Hs = sum(jwS(m, sy) * jwS(m + 1, sz) for m in range(1, M)) - jwS(M, sy) * jwS(1, sz)
    Es = prod([sx(k) for k in range(1, M + 1)], identity_matrix(KG, 2**M))
    D0s = sum(sz(m) * sz(m + 1) for m in range(1, M))
    rep.check(i * Hs == D0s + Es * (sz(M) * sz(1)), f"M={M} 主張（Sage の経路）")
    rep.check(S_(i, H) == i * Hs and D0 == D0s, f"M={M} 本文の経路と Sage の経路の一致")
    # 否定コントロール
    rep.negative(S_(i, H) != A_(D0, G), f"M={M} ε を落とした D_0 + G は外れる")
    Hwrong = A_(F_(terms), B)
    rep.negative(S_(i, Hwrong) != A_(D0, P_(eps, G)), f"M={M} 境界項の符号を + にした H は外れる")
    m = 1
    Lw = S_(i, kron([I] * (m - 1) + [S_(i, Z), Z] + [I] * (M - m - 1)))
    rep.negative(S_(i, kron([I] * (m - 1) + [P_(Y, X), Z] + [I] * (M - m - 1))) != Lw, f"M={M} σ^yσ^x を (+i)σ^z にすると外れる")
    rep.negative(S_(i, B) != P_(eps, G), f"M={M} 準備4 の符号を落とした i(Y_MZ_1) = εG は外れる")
rep.finish()
