# Step 4 と主張: γ_2(θ~_μ) ≠ 0。
#  - Step 4: sin θ~_μ = 0 となる組で、連立条件の第 1 式（c_1 cos θ = s_1 c_2）が s_1 c_2 = -c_1 を要求し、s_1 c_2 > 0 > -c_1 と矛盾すること。
#  - 主張: M_col = 2..16 の全 μ と結合定数の組（臨界点を含む）で、γ_2(θ~_μ) を def_gamma1_gamma2_of_theta の式から
#    円分体で厳密に作り、0 でないこと。あわせて Step 1 の同値（γ_2 = 0 ⟺ w = 0 ⟺ 連立条件）の両辺の真偽が一致すること。
#  - 対照: 整数運動量の θ = 0 では、臨界点 (Y,Z) = (2,3) で w(0) = c_1 - s_1 c_2 = 0、γ_2(0) = 0 になる
#    （Step 1 の同値が空でなく、半整数にずらしたことが効いていること）。
load("_prelude.sage")
load("../../_shared/defs.sage")   # def_A_theta の (1,2) 成分 gamma_2 を、略記を cosh・sinh・tanh・log の記号式で持つ形で使う
rep = Report("Step 4 と主張 γ_2(θ~_μ) ≠ 0")
for (Y, Z) in COUPLINGS:
    k = couplings(Y, Z)
    tag = f"(Y,Z)=({Y},{Z})"
    rep.check(k['s1'] * k['c2'] > 0 and -k['c1'] < 0 and k['s1'] * k['c2'] != -k['c1'],
              f"{tag} Step 4: s_1c_2 = {k['s1']*k['c2']} > 0 > -c_1 = {-k['c1']}、よって s_1c_2 ≠ -c_1")
    allnz = True
    for M in range(2, 17):
        for mu in range(1, M + 1):
            F, I_, E, co, si = cyclotomic_angle(M, mu)
            g = gamma2_by_definition(I_, E, co, si, k)
            w = k['c1'] * co - I_ * si - k['s1'] * k['c2']
            f1 = I_ * E * k['s2s']
            b = (-I_) * (1/E) * (1/k['s2s'])     # b(θ~_μ)。exp(-iθ) = 1/exp(iθ) は円分体での値
            cond = (si == 0) and (k['c1'] * co == k['s1'] * k['c2'])
            ok = (g != 0) and (f1 != 0) and (f1 * b == 1) and ((g == 0) == (w == 0) == cond)
            if si == 0:
                # Step 4 の鎖: c_1 cos θ~_μ = c_1·(-1) = -c_1
                ok = ok and co == -1 and k['c1'] * co == k['c1'] * (-1) == -k['c1']
            if not ok:
                allnz = False
                rep.check(False, f"{tag} M={M} μ={mu}: γ_2 = {g}")
    rep.check(allnz, f"{tag} M_col = 2..16 の全 μ で γ_2(θ~_μ) ≠ 0、a(θ~_μ) b(θ~_μ) = 1、Step 1 の三つの条件の真偽が一致")
# 同値の鎖の第 1 行 γ_2 = a w を、別の作り方の γ_2 と比べる: defs.sage の A_theta の (1,2) 成分（defs.sage の gamma_2。
# def_gamma1_gamma2_of_theta の式で、def_A_theta の (1,2) 成分と文字どおり同じ式）
# （K_1 = (1/2) log Y、K_2 = (1/2) log Z を代入した記号式。双対結合定数も defs.sage が tanh と log から作る）を QQbar へ移し、
# 円分体で本文の a(θ)・w(θ) の定義から別々に作った積 a w と比べる。記号式の QQbar への変換が重いので範囲を絞る。
for (Y, Z) in [(2, 3), (4, 3), (3/2, 5)]:
    k = couplings(Y, Z)
    ok = True
    for M in range(2, 7):
        for mu in range(1, M + 1):
            F, I_, E, co, si = cyclotomic_angle(M, mu)
            a_ = I_ * E * k['s2s']
            w_ = k['c1'] * co - I_ * si - k['s1'] * k['c2']
            th = 2 * pi * (mu - QQ(1)/2) / M
            sym = A_theta(th)[0, 1].subs({K1: log(QQ(Y))/2, K2: log(QQ(Z))/2})
            lhs = QQbar(sym.maxima_methods().exponentialize().simplify_full())   # 双曲線関数・三角関数を exp で書き直してから代数的数へ
            z = QQbar.zeta(4 * M)
            rhs = (a_ * w_).polynomial()(z)
            ok = ok and (lhs == rhs)
    rep.check(ok, f"(Y,Z)=({Y},{Z}) M_col = 2..6 の全 μ で、def_A_theta の (1,2) 成分（記号式）= a(θ~_μ) w(θ~_μ)（円分体）")
# 対照（臨界点 (2,3) で θ = 0）
k = couplings(2, 3)
F = CyclotomicField(4); I_ = F.gen(); E = F(1); co = F(1); si = F(0)
g0 = gamma2_by_definition(I_, E, co, si, k)
rep.check(k['s1'] * k['s2'] == 1, "対照: (Y,Z) = (2,3) は臨界点 s_1 s_2 = 1")
rep.check(g0 == 0 and k['c1'] * co == k['s1'] * k['c2'], "対照: θ = 0 では c_1 cos 0 = s_1 c_2 で γ_2(0) = 0（同値が空でない）")
k = couplings(4, 3)
g0 = gamma2_by_definition(I_, E, co, si, k)
rep.check(g0 != 0, "対照: 臨界点でない (4,3) では γ_2(0) ≠ 0")
rep.finish()
