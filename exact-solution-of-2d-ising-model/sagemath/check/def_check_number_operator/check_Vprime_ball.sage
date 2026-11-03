# 対象ラベル: def_check_number_operator
# 主張 (2) の第二式 V̌' = exp(X̌) と、第一式を γ(θ̃_μ) の実際の値で組んだ X̌ について確かめる。ℝ への脱出を含む量なのでボールで囲む。
#   γ(θ̃_μ) は def_gamma_theta・def_arccosh の log(g + √(g^2 - 1))（g = γ_1(θ̃_μ)、実対数）のボール（RealBallField(512)）。
#   X̌_def := Σ_μ (γ)_C (ψ̌_μ^† ψ̌_{σ(μ)} - (1/2)_C I)（def_check_Vprime）と X̌_n := Σ_μ (γ)_C (ň_μ - (1/2)_C I) を、E_μ の値を
#   to_cb（ζ ↦ exp(2πi/(4M))、σ > 0、R ↦ +r_μ の埋め込み）で ComplexBallField(512) へ移して別々に組み、重なることを見る。
#   V̌' := exp(X̌_def) は Sage の行列の exp で、exp(X̌_n) は def_exp の部分和に尾の上界を足したボール（_prelude.sage の body_exp_ball）で作り、
#   重なることを見る。def_check_Vprime の V̌' の定義そのものなので、この行は exp の作り方が本文の定義と合っていることの確認である。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4。
# 対照: γ の符号を逆にした exp(-X̌_n) とは重ならない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("def_check_number_operator: 主張 (2) の X̌ と V̌' = exp(X̌)（ボール）")


def main():
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            st = NumberOperatorSetting(f)
            n = f.n
            tag0 = f"(x,y)=({x},{y}) M={M}"
            Icb = body_identity(CB, n)
            half = body_scalar(CB(1) / 2, Icb)
            terms_def, terms_n = [], []
            for m in st.J:
                s = st.S[m]
                to0 = to_cb_factory(s)
                cache = {}

                def to(e, to0=to0, cache=cache):
                    # 同じ E_μ の元は同じボールへ移るので、値ごとに覚えておく（行列の成分は同じ値が多く繰り返す）
                    if e not in cache:
                        cache[e] = to0(e)
                    return cache[e]
                g = RB(s.g1_AA)
                gam = (g + (g**2 - 1).sqrt()).log()                                   # def_arccosh（実対数）
                rep.check(gam > 0, f"{tag0} μ={m}: γ(θ̃_μ) > 0", quiet=True)
                prod_def = mat_cb(body_product(st.dag[m], st.psi_sig[m]), to)         # ψ̌_μ^† ψ̌_{σ(μ)}
                n_mu = body_product(mat_cb(st.dag[m], to), mat_cb(st.psi_sig[m], to)) # ň_μ をボールの因子の積で
                rep.check(balls_overlap(prod_def, n_mu), f"{tag0} μ={m}: ň_μ = ψ̌_μ^† ψ̌_σ(μ)（ボール）", quiet=True)
                terms_def.append(body_scalar(CB(gam), body_difference(prod_def, half)))
                terms_n.append(body_scalar(CB(gam), body_difference(n_mu, half)))
            Xdef = body_finite_sum(terms_def)
            Xn = body_finite_sum(terms_n)
            rep.check(balls_overlap(Xdef, Xn), f"{tag0}: 主張 (2) の第一式 X̌ = Σ γ(ň_μ - I/2)（ボール）")
            Vdef = Xdef.exp()                                                         # V̌' := exp(X̌)（Sage の exp）
            Vn = body_exp_ball(Xn)                                                    # exp(Σ γ(ň - I/2))（def_exp の部分和と尾）
            rep.check(balls_overlap(Vdef, Vn), f"{tag0}: 主張 (2) の第二式 V̌' = exp(X̌)（ボール）")
            rep.check(not balls_overlap(Vdef, body_exp_ball(body_negation(Xn))), f"対照 {tag0}: exp(-X̌) とは重ならない")


main()
rep.finish()
