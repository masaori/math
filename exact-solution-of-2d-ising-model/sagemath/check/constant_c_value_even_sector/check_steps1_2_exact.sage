# 対象ラベル: constant_c_value_even_sector（証明の準備の H + H = S_1 と二つの exp の積、Step 1 の二つの鎖、Step 2 の鎖）
# (a) H + H = S_1 の 8 行: K_1 を KG = QQ(i) 上の実の不定元に置いた多項式環で、成分ごとに厳密に（M_col = 2..5）。
# (b) 実際の行列で: K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}、M_col = 2..4）と選び、exp(±H)・exp(±S_1)・exp(±S_2) を
#     肩の整数行列（iH_1^(+)、2 iH_1^(+)、その符号反転、iH_2 とその符号反転、T_U で共役した行列）の射影から別々に作る。
#     V^(+) は def_V_plus の ((V_1^(+))^{1/2}V_2)(V_1^(+))^{1/2}（V_2 は成分の定義）、(V^(+))^{-1} は Sage の inverse、
#     U は sign_flip_conjugation の EF、U^{-1} は Sage の inverse（本文の積で U^{-1}U = UU^{-1} = I を確かめる）。
#     鎖の各行を QQbar で作り、隣どうしを厳密に比べる。浮動小数点は使わない。
load("_prelude.sage")

n_eq = 0
n_neg = 0


def chain(lines, what):
    global n_eq
    for k in range(len(lines) - 1):
        assert lines[k] == lines[k + 1], f"{what}: {k+1} 行目と {k+2} 行目"
        n_eq += 1


# (a) H + H = S_1（成分ごとの 8 行。K_1 は実の不定元、i は KG の i）
P = PolynomialRing(KG, 'K1')
K1 = P.gen()
half = P(QQ(1) / 2)
for M in range(2, 6):
    S1 = body_scalar(i_K * K1, H1_plus(M).change_ring(P))
    H = body_scalar(half, S1)
    HH = body_sum(H, H)
    n = 2**M
    for k in range(n):
        for l in range(n):
            lines = [HH[k, l], H[k, l] + H[k, l], half * S1[k, l] + half * S1[k, l],
                     (half + half) * S1[k, l], (QQ(1) / 2 + QQ(1) / 2) * S1[k, l], P(1) * S1[k, l], S1[k, l]]
            for j in range(len(lines) - 1):
                assert lines[j] == lines[j + 1]
    n_eq += 1   # 成分の全ての (k, l) を通した一つの確認として数える
    assert body_sum(H, H) == S1 and H != S1; n_neg += 1      # 否定: H 自身は S_1 でない

# (b) 実際の行列
for M in range(2, 5):
    n = 2**M
    N1 = iH1_plus_integer_matrix(M)                 # H = (log y)·N1
    N2 = iH2_integer_matrix(M)                      # S_2 = K_2^*·N2
    Id = body_identity(QQbar, n)
    U = sign_flip_U(M)
    Uinv = U.inverse()
    assert body_product(Uinv, U) == body_identity(KG, n) and body_product(U, Uinv) == body_identity(KG, n)
    UQ, UinvQ = to_qqbar_matrix(U), to_qqbar_matrix(Uinv)
    TN1 = T_body(U, (2 * N1).change_ring(KG), Uinv)    # T_U(S_1) の肩（S_1 = (log y)·2N1）
    TN2 = T_body(U, N2.change_ring(KG), Uinv)
    assert all(z in QQ for z in TN1.list()) and all(z in QQ for z in TN2.list())
    TN1q = matrix(QQ, n, n, [QQ(z) for z in TN1.list()])
    TN2q = matrix(QQ, n, n, [QQ(z) for z in TN2.list()])
    # sign_flip_conjugation の主張（本文の上流）: T_U(S_1) = −S_1、T_U(S_2) = −S_2
    assert TN1q == -2 * N1 and TN2q == -N2
    for x in [QQ(2), QQ(3)]:
        _, t = second_coupling_exact(x)
        rt = AA(t).sqrt()
        A_p = exp_by_spectral_projectors(N2, lambda lam: rt ** (-lam), AA)        # exp(S_2)
        A_m = exp_by_spectral_projectors(-N2, lambda lam: rt ** (-lam), AA)       # exp(−S_2)
        A_T = exp_by_spectral_projectors(TN2q, lambda lam: rt ** (-lam), AA)      # exp(T_U(S_2))
        assert A_p == exp_iK2star_H2_exact(M, x, +1) and A_m == exp_iK2star_H2_exact(M, x, -1)
        a = prefactor_exact(M, x)
        ainv = AA(1) / a
        assert a > 0 and ainv > 0
        V2 = V2_components_exact(M, x)
        for y in [QQ(2), QQ(3)]:
            EH = exp_of_log_multiple(N1, y, QQ)            # exp(H)
            EmH = exp_of_log_multiple(-N1, y, QQ)          # exp(−H)
            ES1 = exp_of_log_multiple(2 * N1, y, QQ)       # exp(S_1) = exp(H + H)
            EmS1 = exp_of_log_multiple(-2 * N1, y, QQ)     # exp(−S_1)
            EmHmH = exp_of_log_multiple((-N1) + (-N1), y, QQ)   # exp((−H) + (−H))
            EmHH = exp_of_log_multiple(-(N1 + N1), y, QQ)       # exp(−(H + H))
            ET1 = exp_of_log_multiple(TN1q, y, QQ)         # exp(T_U(S_1))
            assert EH == exp_V1_half_exact(M, y, +1) and EmH == exp_V1_half_exact(M, y, -1)
            # 準備の二つの鎖: exp(H)exp(H) = exp(H+H) = exp(S_1)、exp(−H)exp(−H) = exp((−H)+(−H)) = exp(−(H+H)) = exp(−S_1)
            chain([body_product(EH, EH), ES1, ES1], f"M={M}: exp(H)exp(H)")
            chain([body_product(EmH, EmH), EmHmH, EmHH, EmS1], f"M={M}: exp(−H)exp(−H)")
            # 型をそろえる
            q = lambda A: to_qqbar_matrix(A)
            EHq, EmHq, ES1q, EmS1q = q(EH), q(EmH), q(ES1), q(EmS1)
            Apq, Amq, ATq, ET1q = q(A_p), q(A_m), q(A_T), q(ET1)
            aq, ainvq = QQbar(a), QQbar(ainv)
            # V^(+)（def_V_plus）と (V^(+))^{-1}
            B = EH.change_ring(AA)
            Vp = q(body_product(body_product(B, V2), B))
            Vpinv = Vp.inverse()
            assert body_product(Vp, Vpinv) == Id
            tau = trace_body(body_product(ES1q, Apq))
            taup = trace_body(body_product(EmS1q, Amq))
            # Step 1 の第一の鎖
            L1 = [trace_body(Vp),
                  trace_body(body_scalar(aq, body_product(body_product(EHq, Apq), EHq))),
                  aq * trace_body(body_product(body_product(EHq, Apq), EHq)),
                  aq * trace_body(body_product(EHq, body_product(EHq, Apq))),
                  aq * trace_body(body_product(body_product(EHq, EHq), Apq)),
                  aq * trace_body(body_product(ES1q, Apq)),
                  aq * tau]
            chain(L1, f"M={M}, x={x}, y={y}: Step 1 第一")
            # Step 1 の第二の鎖（(V^(+))^{-1} = R^(+) は V_plus_is_invertible。ここでは Sage の inverse と R^(+) の一致も見る）
            Rp = body_scalar(ainvq, body_product(body_product(EmHq, Amq), EmHq))
            L2 = [trace_body(Vpinv), trace_body(Rp),
                  ainvq * trace_body(body_product(body_product(EmHq, Amq), EmHq)),
                  ainvq * trace_body(body_product(EmHq, body_product(EmHq, Amq))),
                  ainvq * trace_body(body_product(body_product(EmHq, EmHq), Amq)),
                  ainvq * trace_body(body_product(EmS1q, Amq)),
                  ainvq * taup]
            chain(L2, f"M={M}, x={x}, y={y}: Step 1 第二")
            assert Vpinv == Rp
            # Step 2 の鎖
            TU = lambda A: T_body(UQ, A, UinvQ)
            PQ = body_product(ES1q, Apq)
            L3 = [taup,
                  trace_body(body_product(EmS1q, Amq)),
                  trace_body(body_product(ET1q, ATq)),
                  trace_body(body_product(TU(ES1q), TU(Apq))),
                  trace_body(TU(PQ)),
                  trace_body(body_product(body_product(UQ, PQ), UinvQ)),
                  trace_body(body_product(UQ, body_product(PQ, UinvQ))),
                  trace_body(PQ),
                  tau]
            chain(L3, f"M={M}, x={x}, y={y}: Step 2")
            # 2 行目→3 行目の中身（exp(−S_1) = exp(T_U(S_1)) は、射影を別の行列 −2N1・T_U(2N1) から作って一致を見た）
            assert EmS1q == ET1q and Amq == ATq
            # 3 行目→4 行目の中身（conjugation_commutes_with_matrix_exp の B → U、X → S_1, S_2）
            assert TU(ES1q) == ET1q and TU(Apq) == ATq
            n_eq += 2
            # 否定コントロール
            # (i) 因子を一つ多くした tr(exp(S_1)exp(S_2)exp(S_2)) は τ でない（τ の比較が自明でないこと）
            assert trace_body(body_product(PQ, Apq)) != tau; n_neg += 1
            # (ii) 準備の H を S_1 にすると exp(S_1)exp(S_1) ≠ exp(S_1)
            assert body_product(ES1q, ES1q) != ES1q; n_neg += 1
            # (iii) Step 1 の係数を a^{-1} にすると tr(V^(+)) に一致しない
            assert ainvq * tau != trace_body(Vp); n_neg += 1
            # (iv) U を F だけにすると S_1 の符号は反転しない（T_F(S_1) ≠ −S_1）
            Fm = kron_def([SZ] * M)
            assert T_body(Fm, (2 * N1).change_ring(KG), Fm.inverse()) != (-2 * N1).change_ring(KG); n_neg += 1
    print(f"M_col = {M}: x, y ∈ {{2, 3}} で準備・Step 1・Step 2 を QQbar で厳密に確かめた", flush=True)

print(f"等号 {n_eq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
