# 対象ラベル: isotropic_gamma_in_kappa
# γ(θ) の鎖と主張を、具体の K（QQ）と θ = πr（r ∈ QQ）で、値を囲む実数のボール（RealBallField）で確かめる。
# ℝ への脱出: sinh・cosh・tanh の値は実数の exp の値（部分和の極限）、K_2^*・K^* は実対数の値、
#   sin・cos・arccosh・arcsinh・√ の値も実数なので、ここだけ区間計算を使う。
# - γ(θ) は主張の式を使わずに本文の定義どおりに作る: γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ（def_gamma1_gamma2_of_theta）、
#   γ(θ) = arccosh(γ_1(θ))（def_gamma_theta）。arccosh・arcsinh は本文の定義 log(y + √(y^2 ∓ 1)) から作る。
#   cos θ・sin(θ/2) は Arb の cos・sin を使う（本文に全実数上の cos・sin が未整備のため）。
#   sinh 2K・cosh 2K・tanh K は本文の exp のボール、K^* は QQ に無いので sinh 2K^*・cosh 2K^* は Arb で作る。
# - 1 行目は γ と gamma_kappa_identity の第 3 式の右辺（A を残す）の重なりで、主張は γ と κ(K) の式の重なりで確かめる。
#   2・3・4 行目は A = 1、κ = κ(K) を代入した同じ形の値の照合である（内容は check_lines_generic.sage と上流の検算）。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/isotropic_balls.sage")

r_list = [QQ(0), QQ(1)/7, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, -QQ(2)/5]
pi = RB.pi()
for K in K_list:
    Ks = -(btanh(K).log()) / 2                        # def_isotropic_dual_coupling（= K_2^*）
    s1, c1 = bsinh(2 * K), bcosh(2 * K)
    s2s, c2s = (2 * Ks).sinh(), (2 * Ks).cosh()
    A = s1 * s2s
    kap = 2 * K - 2 * Ks                              # def_kappa（K_1 = K、K_2^* = K^*）
    kapK = 2 * K - 2 * Ks                             # def_isotropic_kappa_of_K
    for r in r_list:
        th = pi * r
        tag = f"(K={K}, θ={r}π)"
        g1 = c1 * c2s - s1 * s2s * th.cos()           # def_gamma1_gamma2_of_theta
        check(f"γ_1(θ) ≥ 1 {tag}", g1 >= 1)
        gamma = body_arccosh(g1)                      # def_gamma_theta
        Y = ((th / 2).sin())^2
        sqrtS = (((kapK / 2).sinh())^2 + Y).sqrt()
        G = [2 * body_arcsinh((((kap / 2).sinh())^2 + A * Y).sqrt()),
             2 * body_arcsinh((((kap / 2).sinh())^2 + 1 * Y).sqrt()),
             2 * body_arcsinh((((kap / 2).sinh())^2 + Y).sqrt()),
             2 * body_arcsinh((((kapK / 2).sinh())^2 + Y).sqrt())]
        eq(gamma, G[0], f"左辺→1 行目（gamma_kappa_identity の第 3 式） {tag}")
        for j, nm in enumerate(["1→2", "2→3", "3→4"]):
            eq(G[j], G[j + 1], f"{nm} 行目 {tag}")
        eq(gamma, G[3], f"主張 {tag}")
        eq(body_arcsinh(sqrtS), sqrtS.arcsinh(), f"本文の arcsinh と Arb の arcsinh {tag}")
    # 対照: 異方的（K_2 = K + 1/3）では A を落とした式は γ と一致しない（θ = π/2）
    K2sa = -(btanh(K + QQ(1) / 3).log()) / 2
    Aa = s1 * (2 * K2sa).sinh()
    th = pi / 2
    ga = body_arccosh(c1 * (2 * K2sa).cosh() - Aa * th.cos())
    Xa = (((2 * K - 2 * K2sa) / 2).sinh())^2
    Ya = ((th / 2).sin())^2
    ne(ga, 2 * body_arcsinh((Xa + Ya).sqrt()), f"対照 異方的なら A を落とした式は γ と一致しない (K={K})")
    eq(ga, 2 * body_arcsinh((Xa + Aa * Ya).sqrt()), f"異方的でも A を残した式は γ と一致する (K={K})")
finish()
