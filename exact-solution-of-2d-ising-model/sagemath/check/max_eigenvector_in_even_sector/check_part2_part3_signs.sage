# 対象ラベル: max_eigenvector_in_even_sector（準備 (P1)(P2)、主張 (2)(3) と証明の (2)(3) の鎖）
# (P1) (−1)^k(−1)^k = ((−1_ℂ)(−1_ℂ))^k = (((−1)(−1))_ℂ)^k = 1_ℂ^k = 1_ℂ の 4 行を k = 0..8 で（冪は def_power_of_complex_number の帰納法の cpow）。
#      ℂ の元は QQ(i)、包含 (·)_ℂ は r ↦ r + 0i、ℝ の積は QQ で取る。
# (P2) 全ての ϵ で |ϵ| ≤ #M̌ = M_col（|ϵ| と #M̌ を数えて比べるだけで、作り方で自明に近い）。
# (2) 全ての ϵ で η_ϵ の 8 行の鎖（η は epsilon_eigenvalue_on_check_Q の (1) の作り方で本文の ψ̌ から、E_1 で）と、εQ̌_ϵ = η_ϵQ̌_ϵ = (−1)^{M+|ϵ|}Q̌_ϵ の 2 行。
#     1 行目の η_(1,…,1)(−1)^{M−|ϵ|} は epsilon_eigenvalue_on_check_Q (3) の右辺で、η_(1,…,1) は ψ̌ から求めた値を使う（引いた主張の当てはめ）。
# (3) ε = (η_(1,…,1)(−1)^M)Π(I − 2ň_μ) = (1_ℂ(−1)^M)Π = (−1)^MΠ の 3 行（Π は本文の左から掛ける有限積、I − 2ň は本文の差とスカラー倍）と、
#     主張 (3) を Sage の `*`・`-` で独立に組んだ右辺と比べる。
# 否定コントロール: (2) の指数を 1 ずらした (−1)^{M−|ϵ|+1} は η_ϵ でない。(2) の符号を反転した −(−1)^{M+|ϵ|} は η_ϵ でない。(−1)^{|ϵ|} は M_col が奇数で η_ϵ でない。
#   (3) の右辺の符号を反転すると ε に一致しない。M_col が奇数では (−1)^M を落とした Π も ε に一致しない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("max_eigenvector_in_even_sector (P1)(P2)(2)(3)（厳密）")

# (P1) QQ(i) で
Ki = QuadraticField(-1, 'I')
incl = lambda q: Ki(q)
m1 = Ki(-1)
for k in range(0, 9):
    lines = [("(−1)^k(−1)^k", cpow(m1, k) * cpow(m1, k)), ("((−1_ℂ)(−1_ℂ))^k", cpow(m1 * m1, k)),
             ("(((−1)(−1))_ℂ)^k", cpow(incl(QQ(-1) * QQ(-1)), k)), ("1_ℂ^k", cpow(Ki(1), k)), ("1_ℂ", Ki(1))]
    rep.chain(lines, f"(P1) k={k}")

for s in max_settings(Ms):
    M, F, E, Id = s.M, s.F, s.E, s.Id
    tag = s.tag
    mF = F(-1)
    one = F(1)
    e1 = s.eta[s.ones]
    # (P2)
    for w in s.words:
        rep.check(popcount(w) <= len(range(1, M + 1)) == M, f"{tag} ϵ={w}: |ϵ| ≤ #M̌ = M")
    # (2)
    for w in s.words:
        tw = f"{tag} ϵ={w}"
        k = popcount(w)
        a, b = M - k, k
        lines = [("η_ϵ", s.eta[w]), ("η_1(−1)^(M−|ϵ|)", e1 * cpow(mF, a)), ("1_ℂ(−1)^(M−|ϵ|)", one * cpow(mF, a)), ("(−1)^(M−|ϵ|)", cpow(mF, a)), ("(−1)^(M−|ϵ|)1_ℂ", cpow(mF, a) * one),
                 ("(−1)^(M−|ϵ|)((−1)^|ϵ|(−1)^|ϵ|)", cpow(mF, a) * (cpow(mF, b) * cpow(mF, b))),
                 ("((−1)^(M−|ϵ|)(−1)^|ϵ|)(−1)^|ϵ|", (cpow(mF, a) * cpow(mF, b)) * cpow(mF, b)),
                 ("(−1)^M(−1)^|ϵ|", cpow(mF, M) * cpow(mF, b)), ("(−1)^(M+|ϵ|)", cpow(mF, M + b))]
        rep.chain(lines, f"{tw} (2) η_ϵ の鎖")
        rep.check(s.eta[w] == cpow(mF, M - k) and s.eta[w] == cpow(mF, M + k), f"{tw}: 主張 (2) η_ϵ = (−1)^(M−|ϵ|) = (−1)^(M+|ϵ|)")
        Q = s.Q[w]
        rep.chain([("εQ̌_ϵ", P_(E, Q)), ("η_ϵQ̌_ϵ", S_(s.eta[w], Q)), ("(−1)^(M+|ϵ|)Q̌_ϵ", S_(cpow(mF, M + k), Q))], f"{tw} (2) 行列の式")
        rep.check(E * Q == (-1)**(M + k) * Q, f"{tw}: 主張 (2) εQ̌_ϵ = (−1)^(M+|ϵ|)Q̌_ϵ（Sage の積）")
        rep.negative(s.eta[w] != -cpow(mF, M + k), f"{tw}: 符号を反転した −(−1)^(M+|ϵ|)")
        rep.negative(s.eta[w] != cpow(mF, M - k + 1), f"{tw}: 指数を 1 ずらした (−1)^(M−|ϵ|+1)")
        if M % 2 == 1:
            rep.negative(s.eta[w] != cpow(mF, k), f"{tw}: (−1)^|ϵ|（M_col 奇数）")
    # (3)
    T = [D_(Id, S_(2, s.ns[mu])) for mu in range(M)]               # I − 2ň_μ
    Pi = body_finite_product(T)
    rep.chain([("ε", E), ("(η_1(−1)^M)Π", S_(e1 * cpow(mF, M), Pi)), ("(1_ℂ(−1)^M)Π", S_(one * cpow(mF, M), Pi)), ("(−1)^MΠ", S_(cpow(mF, M), Pi))],
              f"{tag} (3) の鎖")
    Rhs = (-1)**M * prod([Id - 2 * s.ns[mu] for mu in range(M)])
    rep.check(E == Rhs, f"{tag}: 主張 (3)（Sage の積）")
    rep.negative(E != -Rhs, f"{tag}: (3) の符号を反転")
    if M % 2 == 1:
        rep.negative(E != Pi, f"{tag}: (−1)^M を落とした Π（M_col 奇数）")
    print(f"  {tag}: 済（累計 {rep.n} 件、否定 {rep.neg} 件）", flush=True)

rep.finish()
