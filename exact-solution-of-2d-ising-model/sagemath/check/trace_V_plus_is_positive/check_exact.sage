# 対象ラベル: trace_V_plus_is_positive
# 証明の二行（V_plus_is_positive_definite で V^(+) が正定値、trace_of_positive_definite_is_positive を
# n = 2^{M_col}・A = V^(+) へ当てて tr(V^(+)) ∈ ℝ_{>0}）と主張を、実際の V^(+) で厳密に確かめる。
# V^(+) は def_V_plus の ((V_1^(+))^{1/2} V_2)(V_1^(+))^{1/2} を成分の積で組む。V_2 は def_transfer_matrix の成分の定義、
# (V_1^(+))^{1/2} = exp((i/2)K_1H_1^(+)) は K_1 := 2 log y と選んで固有値の射影に y^λ を掛けて QQ で作る。
# V_2 を厳密に扱うため K_2 := log x と選ぶ（x, y ∈ {2, 3}）。ℝ への脱出は K_1・K_2 の選び方の一点だけで、
# 以後の等号・不等号は全て AA（実代数的数）・QQbar の厳密計算である。
load("_prelude.sage")

n_eq = 0
n_ineq = 0
n_neg = 0


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


def pos(r, what):
    global n_ineq
    assert r in AA and AA(r) > 0, what
    n_ineq += 1


for M in range(2, 5):
    n = 2**M
    assert n in ZZ and n >= 1                                    # 準備: n := 2^{M_col} ∈ Z_{≥1}
    for x in [QQ(2), QQ(3)]:
        V2 = V2_components_exact(M, x)
        for y in [QQ(2), QQ(3)]:
            B = exp_V1_half_exact(M, y, +1).change_ring(AA)
            Vp = body_product(body_product(B, V2), B)            # def_V_plus
            assert Vp.nrows() == n and Vp.ncols() == n            # 準備: V^(+) ∈ Mat(n, C)
            # 1 行目: V^(+) は正定値（V_plus_is_positive_definite の結論。def_hermitian_positive_definite の意味）
            eq(conj_transpose_exact(Vp), Vp, f"M={M}, x={x}, y={y}: V^(+)^* = V^(+)")
            assert is_positive_definite_exact(Vp), (M, x, y)      # 首座小行列式と特性多項式の二つの経路
            n_ineq += 1
            VQ = Vp.change_ring(QQbar)
            for xv in [vector(QQbar, [QQbar(k + 1) + QQbar(I) * (k % 3 - 1) for k in range(n)]),
                       vector(QQbar, [QQbar((-1)**k) for k in range(n)])]:
                v = quadratic_form_value(xv, VQ)                  # 定義の x^*Ax を具体の x ≠ 0 で
                assert v.imag() == 0
                pos(v.real(), f"M={M}: x^*V^(+)x > 0")
            # 2 行目: trace_of_positive_definite_is_positive を n = 2^{M_col}, A = V^(+) へ。
            # その証明の中身を A = V^(+) で: b^{(k)*}Ab^{(k)} = A_kk = (r_k)_C、r_k ∈ ℝ_{>0}
            r = []
            for k in range(n):
                b = standard_vector(n, k, QQbar)
                assert b != 0
                val = quadratic_form_value(b, VQ)
                eq(val, VQ[k, k], f"M={M}, k={k}: b^(k)*V^(+)b^(k) = V^(+)_kk")
                assert val.imag() == 0
                pos(val.real(), f"M={M}, k={k}: r_k > 0")
                r.append(AA(val.real()))
            # tr(A) = Σ A_kk（def_trace）= Σ (r_k)_C = (Σ r_k)_C（real_inclusion_preserves_finite_sum）
            tr_def = trace_by_definition(VQ)
            eq(tr_def, sum(QQbar(rk) for rk in r), f"M={M}: Σ A_kk = Σ (r_k)_C")
            eq(sum(QQbar(rk) for rk in r), QQbar(sum(r)), f"M={M}: Σ (r_k)_C = (Σ r_k)_C")
            # Σ r_k ≥ r_1 > 0
            assert sum(r) >= r[0]
            pos(r[0], f"M={M}: r_1 > 0")
            # 主張: tr(V^(+)) ∈ ℝ_{>0}（z = (r)_C で r > 0。Sage の trace とも一致）
            eq(tr_def, VQ.trace(), f"M={M}: 定義のトレース = Sage の trace")
            assert tr_def.imag() == 0
            pos(tr_def.real(), f"M={M}, x={x}, y={y}: tr(V^(+)) > 0")
            # 主張を V_plus_is_positive_definite の表示 a_C exp(S_1/2)exp(S_2)exp(S_1/2) からも（別の経路）
            a = prefactor_exact(M, x)
            A2 = exp_iK2star_H2_exact(M, x, +1)
            eq(trace_by_definition(body_scalar(a, body_product(body_product(B, A2), B))), Vp.trace(),
               f"M={M}: 表示から作った V^(+) のトレース")
            # 否定コントロール
            # (i) −V^(+) は正定値でなく、トレースは負（結論の符号が正定値性から来ていること）
            Vneg = body_scalar(AA(-1), Vp)
            assert not is_positive_definite_exact(Vneg) and trace_by_definition(Vneg) < 0
            n_neg += 1
            # (ii) V^(+) − λE_11（λ := V^(+)_11 + 1）はエルミートだが正定値でなく、対角成分 r_1 の段が外れる
            E11 = matrix(AA, n, n, lambda p, q: 1 if (p, q) == (0, 0) else 0)
            W = Vp - (Vp[0, 0] + 1) * E11
            assert conj_transpose_exact(W) == W and not is_positive_definite_exact(W) and W[0, 0] < 0
            n_neg += 1
            # (ii') 同じ W と b^{(1)} ≠ 0 で x^*Wx ≤ 0（1 行目の x^*Ax ∈ ℝ_{>0} の判定が外れること）
            wv = quadratic_form_value(standard_vector(n, 0, QQbar), W.change_ring(QQbar))
            assert wv.imag() == 0 and not (wv.real() > 0)
            n_neg += 1
            # (iii) b^{(k)} を零ベクトルにすると x^*Ax = 0 で ℝ_{>0} に入らない（b^{(k)} ≠ 0 が要ること）
            assert quadratic_form_value(vector(QQbar, [0] * n), VQ) == 0
            n_neg += 1
    print(f"M_col = {M}: x, y ∈ {{2, 3}} で二行と主張を AA・QQbar で厳密に確かめた")

print(f"等号 {n_eq} 個、不等号 {n_ineq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
