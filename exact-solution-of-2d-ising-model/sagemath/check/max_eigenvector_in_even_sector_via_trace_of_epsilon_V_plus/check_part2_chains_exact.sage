# 対象ラベル: max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus（証明の (2) の鎖を一行ずつ、厳密に）
# 結合定数 K_1 := 2 log y、K_2 := log x（(x, y) ∈ COUPLINGS）、M_col = 2, 3 で、本文の ψ̌ の ε・Q̌_ϵ・η_ϵ（数体 E_1）と
# 実際の V^(+)（def_V_plus。QQ の行列を E_1 へ移したもの）を ../max_eigenvector_in_even_sector/_prelude.sage から取る。
#   含意の鎖: 1 行目 tr(εV^(+)) = r_ℂ かつ r ∈ ℝ_{>0}（r は QQ）、2 行目 tr(εV^(+)) > 0（z > 0 の定め方の証人 r）、3 行目 η_(1,…,1) = +1。
#   εQ̌_(1,…,1) = η_(1,…,1)Q̌ = 1_ℂQ̌ = Q̌ の 3 行。
#   y := Q̌_(1,…,1)x を、x を I の全ての列 e_k と有理数の列 z に取って、Q̌y = Q̌(Q̌x) = (Q̌Q̌)x = Q̌x = y の 4 行と
#   εy = ε(Q̌y) = (εQ̌)y = Q̌y = y の 4 行（列は 2^M 行 1 列の行列、積は括弧どおり）。y ∈ F^(+)（εy = y）。
# 否定コントロール: r の和を差にしたものは tr(εV^(+)) に一致しない。η_ϵ = −1 となる ϵ の Q̌_ϵ では εQ̌_ϵ ≠ Q̌_ϵ。
#                   im に入らない有理数の列 z では Q̌z ≠ z。
load("../max_eigenvector_in_even_sector/_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus (2)（厳密）")

for s in max_settings(Ms):
    M, F, E, N, x, y = s.M, s.F, s.E, s.N, s.x, s.y
    tag = s.tag
    one_w = s.ones
    Q1 = s.Q[one_w]
    e1 = s.eta[one_w]
    # 含意の鎖
    T = body_trace(P_(E, s.V))                                     # tr(εV^(+))
    r = r_of(M, x, y)
    rep.check(r in QQ and r > 0 and T == F(r), f"{tag}: 1 行目 tr(εV^(+)) = r_ℂ かつ r ∈ ℝ_{{>0}}")
    rep.negative(T != F((2 * x**(-1) * (y**2 + y**(-2)) / 2)**M - (2 * x * (y**2 - y**(-2)) / 2)**M), f"{tag}: r の和を差にしたもの")
    witness = [rr for rr in [r] if rr > 0 and T == F(rr)]
    rep.check(len(witness) == 1, f"{tag}: 2 行目 tr(εV^(+)) > 0（証人 r）")
    rep.check(e1 == F(1), f"{tag}: 3 行目 η_(1,…,1) = +1")
    # εQ̌ = Q̌ の 3 行
    rep.chain([("εQ̌", P_(E, Q1)), ("η_1Q̌", S_(e1, Q1)), ("1_ℂQ̌", S_(F(1), Q1)), ("Q̌", Q1)], f"{tag} εQ̌_(1,…,1) = Q̌_(1,…,1)")
    for w in s.words:
        if s.eta[w] == F(-1):
            rep.negative(P_(E, s.Q[w]) != s.Q[w], f"{tag} ϵ={w}: η_ϵ = −1 の Q̌_ϵ では εQ̌_ϵ ≠ Q̌_ϵ")
            break
    # y の鎖
    xs = [s.basis(k) for k in range(N)] + [matrix(F, N, 1, [QQ(k + 1) / (k + 3) for k in range(N)])]
    for j, xv in enumerate(xs):
        tj = f"{tag} x#{j}"
        yv = P_(Q1, xv)
        rep.chain([("Q̌y", P_(Q1, yv)), ("Q̌(Q̌x)", P_(Q1, P_(Q1, xv))), ("(Q̌Q̌)x", P_(P_(Q1, Q1), xv)), ("Q̌x", P_(Q1, xv)), ("y", yv)], f"{tj} Q̌y = y")
        rep.chain([("εy", P_(E, yv)), ("ε(Q̌y)", P_(E, P_(Q1, yv))), ("(εQ̌)y", P_(P_(E, Q1), yv)), ("Q̌y", P_(Q1, yv)), ("y", yv)], f"{tj} εy = y")
        rep.check(P_(E, yv) == yv, f"{tj}: y ∈ F^(+)")
    z = xs[-1]
    rep.negative(P_(Q1, z) != z, f"{tag}: im に入らない列 z では Q̌z ≠ z")
    print(f"  {tag}: tr(εV^(+)) = {r}、η_(1,…,1) = {e1}（累計 {rep.n} 件、否定 {rep.neg} 件）", flush=True)

rep.finish()
