# 対象ラベル: factorization_of_A_theta_general
# 具体の結合定数と角度で、準備の全ての鎖（実数の値と包含の像の行を含む）、Step 1〜5 の全ての行、Step 6 と主張を
# 代数的数（QQbar）の中で厳密に確かめる。
#
# ℝ への脱出: K_1 = log y、K_2^* = (1/2) log x（x, y ∈ QQ_{>1}）と選び、exp(±K_1) = y^{±1}、exp(±2K_2^*) = x^{±1} とする。
# K_2 は第二の双対結合定数の定義 K_2^* = -(1/2) log(tanh K_2) を解いて exp(2K_2) = (x+1)/(x-1) とし、
# c_2 = cosh 2K_2 を K_2^* と独立に作る（双対関係 c_2^* = s_2^* c_2 を作り方から通さないため）。
# θ = 2πk/n とし、e_± は Sage の記号式 exp(±2πik/n)、cos θ・sin θ は記号式 cos(2πk/n)・sin(2πk/n) を
# それぞれ独立に QQbar・AA へ変換する（Euler の公式を作り方から通さないため）。
load("_prelude.sage")

rep = Report("factorization_of_A_theta_general: 具体値での厳密検算")

PARAMS = [(QQ(2), QQ(3)), (QQ(3), QQ(7)/3), (QQ(5)/2, QQ(2))]   # (y, x)
ANGLES = [(0, 1), (1, 3), (1, 4), (1, 5), (2, 5), (1, 6), (3, 7), (5, 8), (7, 12)]  # θ = 2πk/n

def cosh_from_exp(E):
    """def_cosh_sinh: exp(t) = E のとき cosh t = (E + E^{-1})/2。"""
    return (E + 1/E) / 2

def sinh_from_exp(E):
    return (E - 1/E) / 2

for (y, x) in PARAMS:
    # 実数の値（QQ）。exp(K_1) = y、exp(2K_1) = exp(K_1 + K_1) = y^2、exp(2K_2^*) = x
    chK1, shK1 = cosh_from_exp(y), sinh_from_exp(y)
    ch_K1_plus_K1 = cosh_from_exp(y**2)          # cosh(K_1 + K_1)
    c1_val = cosh_from_exp(y**2)                 # c_1 = cosh 2K_1
    s1_val = sinh_from_exp(y**2)                 # s_1 = sinh 2K_1
    sh_half = sinh_from_exp(y)                   # sinh(2K_1/2)（2K_1/2 = K_1）
    ch_half = cosh_from_exp(y)
    c2s_val, s2s_val = cosh_from_exp(x), sinh_from_exp(x)
    q = (x + 1) / (x - 1)                        # exp(2K_2)
    rep.check(((q - 1) / (q + 1)) == 1 / x, f"(y,x)=({y},{x}) K_2 の作り方: tanh K_2 = exp(-2K_2^*)")
    c2_val = cosh_from_exp(q)

    # 準備の 1 本目〜3 本目（包含の像の行は QQ ⊂ QQbar の元として同じ値になる）
    chain = [chK1**2 + shK1**2, chK1*chK1 + shK1*shK1, (chK1*chK1) + (shK1*shK1), chK1*chK1 + shK1*shK1,
             ch_K1_plus_K1, c1_val, c1_val]
    rep.check(all(v == chain[0] for v in chain), f"(y,x)=({y},{x}) 準備の 1 本目 a^2+b^2 = (c_1)_C の全行")
    rep.check(chK1*chK1 + shK1*shK1 == ch_K1_plus_K1, f"(y,x)=({y},{x}) cosh_addition_formula の当てはめ cosh K_1 cosh K_1 + sinh K_1 sinh K_1 = cosh(K_1+K_1)")
    chain = [2*chK1*shK1, (2*chK1)*shK1, (2*chK1)*shK1, 2*chK1*shK1, 2*shK1*chK1, 2*sh_half*ch_half, s1_val, s1_val]
    rep.check(all(v == chain[0] for v in chain), f"(y,x)=({y},{x}) 準備の 2 本目 2ab = (s_1)_C の全行")
    rep.check(2*sh_half*ch_half == s1_val, f"(y,x)=({y},{x}) sinh_double_angle_formula の当てはめ 2 sinh K_1 cosh K_1 = sinh 2K_1")
    chain = [chK1**2 - shK1**2, chK1*chK1 - shK1*shK1, (chK1*chK1) - (shK1*shK1), chK1*chK1 + (-1)*(shK1*shK1),
             chK1*chK1 + QQ(-1)*(shK1*shK1), chK1*chK1 + ((-1)*shK1*shK1), chK1*chK1 + (-1)*shK1*shK1,
             chK1**2 - shK1**2, QQ(1), QQ(1)]
    rep.check(all(v == chain[0] for v in chain), f"(y,x)=({y},{x}) 準備の 3 本目 a^2-b^2 = 1_C の全行")
    rep.check(c2s_val == s2s_val * c2_val, f"(y,x)=({y},{x}) duality_c2_star_eq_s2_star_c2: c_2^* = s_2^* c_2（独立に作った値で）")

    for (k, n) in ANGLES:
        th = 2 * pi * k / n
        ep_v = QQbar(exp(I * th))
        em_v = QQbar(exp((-I) * th))       # e_- = exp((-i)(θ)_C)
        emn_v = QQbar(exp(-(I * th)))      # exp(-(i(θ)_C))（euler_formula_cos_sin の読み）
        co_v = QQbar(AA(cos(th)))
        si_v = QQbar(AA(sin(th)))
        tag = f"(y,x)=({y},{x}), θ=2π·{k}/{n}"
        # 準備の 4 本目: e_+ e_- = exp(i(θ)_C + (-i)(θ)_C) = exp(0_C) = 1_C
        lhs = ep_v * em_v
        mid = QQbar(exp(I * th + (-I) * th))
        rep.check(lhs == mid and mid == QQbar(exp(0)) and QQbar(exp(0)) == 1, f"{tag} 準備の 4 本目 e_+e_- = 1_C の全行")
        # Euler の公式（引く主張の当てはめ）
        rep.check(em_v == emn_v, f"{tag} negative_i_times_complex_is_negation_of_i_times の当てはめ exp((-i)(θ)_C) = exp(-(i(θ)_C))")
        rep.check(co_v == (ep_v + emn_v) / 2 and si_v == (ep_v - emn_v) / (2 * QQbar(I)),
                  f"{tag} euler_formula_cos_sin の当てはめ（cos・sin と e_± を独立に作って）")

        vals = {a: QQbar(chK1), b: QQbar(shK1), C: QQbar(c2s_val), S: QQbar(s2s_val), ep: ep_v, em: em_v, emn: emn_v,
                co: co_v, si: si_v, c1: QQbar(c1_val), s1: QQbar(s1_val), c2: QQbar(c2_val),
                c2s: QQbar(c2s_val), s2s: QQbar(s2s_val)}
        def evq(f):
            """多項式 f に値を入れる。係数 QQ(i) の元は実部 + I・虚部として QQbar へ送る。"""
            g = R(f)
            return sum(QQbar(Ki(cf).real()) * prod(vals[v]**e for v, e in zip(R.gens(), m)) +
                       QQbar(I) * QQbar(Ki(cf).imag()) * prod(vals[v]**e for v, e in zip(R.gens(), m))
                       for cf, m in zip(g.coefficients(), g.exponents())) if g != 0 else QQbar(0)
        for name, lines in CHAINS.items():
            vs = [evq(e) for e, _ in lines]
            rep.check(all(v == vs[0] for v in vs), f"{tag} {name} の鎖の全 {len(vs)} 行が同じ値")

        # Step 1〜6 と主張を、Sage の行列積で作った値と照らす
        B1v = matrix(QQbar, 2, 2, [QQbar(chK1), ((-QQbar(I)) * ep_v) * QQbar(shK1),
                                   (QQbar(I) * em_v) * QQbar(shK1), QQbar(chK1)])
        B2v = matrix(QQbar, 2, 2, [QQbar(c2s_val), QQbar(I) * QQbar(s2s_val),
                                   (-QQbar(I)) * QQbar(s2s_val), QQbar(c2s_val)])
        Nv = B2v * B1v
        Pv = B1v * Nv
        rep.check(all(Nv[r, c] == evq(CHAINS['N_%d%d' % (r + 1, c + 1)][0][0]) for r in range(2) for c in range(2)),
                  f"{tag} Step 1 の始点 N_jk が Sage の行列積 B_2B_1 の成分に等しい")
        rep.check(all(Pv[r, c] == evq(CHAINS['P_%d%d' % (r + 1, c + 1)][0][0]) for r in range(2) for c in range(2)),
                  f"{tag} Step 2〜5 の始点 P_jk が Sage の行列積 B_1(B_2B_1) の成分に等しい")
        Av = matrix(QQbar, 2, 2, [
            QQbar(c1_val * c2s_val) - QQbar(s1_val * s2s_val) * co_v,
            QQbar(I) * ep_v * QQbar(s2s_val) * (QQbar(c1_val) * co_v - QQbar(I) * si_v - QQbar(s1_val * c2_val)),
            -QQbar(I) * em_v * QQbar(s2s_val) * (QQbar(c1_val) * co_v + QQbar(I) * si_v - QQbar(s1_val * c2_val)),
            QQbar(c1_val * c2s_val) - QQbar(s1_val * s2s_val) * co_v,
        ])
        rep.check((B1v * B2v) * B1v == Av and B1v * (B2v * B1v) == Av, f"{tag} 主張 B_1(θ)B_2B_1(θ) = A(θ)（両方の括弧の付け方で）")
        # 対照: A(θ) の非対角成分の c_2 を c_2^* に替えたもの・B_1(-θ) では一致しない
        Abad = copy(Av)
        Abad[0, 1] = QQbar(I) * ep_v * QQbar(s2s_val) * (QQbar(c1_val) * co_v - QQbar(I) * si_v - QQbar(s1_val * c2s_val))
        rep.check(Abad != Av and (B1v * B2v) * B1v != Abad, f"{tag} 対照: 非対角成分の c_2 を c_2^* に替えた A とは一致しない")
        if ep_v != em_v:
            B1m = matrix(QQbar, 2, 2, [B1v[0, 0], ((-QQbar(I)) * em_v) * QQbar(shK1), (QQbar(I) * ep_v) * QQbar(shK1), B1v[1, 1]])
            rep.check(B1m * B2v * B1m != Av, f"{tag} 対照: B_1(-θ) では A(θ) にならない")
        else:
            print(f"SKIP {tag} 対照 B_1(-θ)（e_+ = e_- なので意味を持たない）")

rep.finish()
