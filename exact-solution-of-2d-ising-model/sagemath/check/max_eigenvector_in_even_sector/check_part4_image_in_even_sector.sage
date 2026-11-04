# 対象ラベル: max_eigenvector_in_even_sector（主張 (4) と証明の (4) の鎖、言い換えの部分）
# 本文の ψ̌ の Q̌_{(1,…,1)}・ε（E_1）と実際の V^(+)（def_V_plus。QQ の行列を E_1 へ移したもの）で、厳密に確かめる。
#   εQ̌_{(1,…,1)} = η_{(1,…,1)}Q̌ = 1_ℂQ̌ = Q̌ の 3 行。
#   y := Q̌_{(1,…,1)}x を、x を I の全ての列 e_k と有理数の列 z に取って、Q̌y = y の 4 行と εy = y の 4 行（列は 2^M 行 1 列の行列）。
#   im Q̌_{(1,…,1)} ⊆ F^(+): Q̌ の全ての列 y で εy = y（def_even_eigenvectors_of_epsilon の条件）。im は列の張る空間なので列で足りる。
#   言い換え: {x | V^(+)x = Λ̌_max x} = im Q̌_{(1,…,1)}（max_eigenvalue_of_V_plus_simple (3) の当てはめ）を、Λ̌_max を V^(+)Q̌_{(1,…,1)} の比として持ち、
#     その QQbar での像が V^(+) の固有多項式（QQ）の最大の根（AA）に等しいことを確かめたうえで、V^(+) − Λ̌_max I の核（E_1）と Q̌ の列空間の一致で確かめる。
#   独立の確認（ψ̌ を使わない）: V^(+) の最大の根 λ（AA）について V^(+) − λI の核（QQbar）は 1 次元で、その基底 v は εv = v。
# 否定コントロール: η_ϵ = −1 となる最初の ϵ の Q̌_ϵ の列 y では εy = −y ≠ y。im に入らない有理数の列 z では Q̌z ≠ z。2 番目に大きい根の固有ベクトルは F^(+) に入らないものがある。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("max_eigenvector_in_even_sector (4) と言い換え（厳密）")

for s in max_settings(Ms):
    M, F, E, Id, N = s.M, s.F, s.E, s.Id, s.N
    tag = s.tag
    one_w = s.ones
    Q1 = s.Q[one_w]
    e1 = s.eta[one_w]
    mF = F(-1)
    # εQ̌ = Q̌
    rep.chain([("εQ̌", P_(E, Q1)), ("η_1Q̌", S_(e1, Q1)), ("1_ℂQ̌", S_(F(1), Q1)), ("Q̌", Q1)], f"{tag} εQ̌_(1,…,1) = Q̌_(1,…,1)")
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
    for w in s.words:
        if s.eta[w] == mF:                                        # η_ϵ = −1 の ϵ（|ϵ| ≢ M_col mod 2）
            col = next(P_(s.Q[w], s.basis(k)) for k in range(N) if P_(s.Q[w], s.basis(k)) != 0)
            rep.negative(P_(E, col) != col, f"{tag} ϵ={w}: Q̌_ϵ の列は F^(+) に入らない（εy = η_ϵy、η_ϵ = {s.eta[w]}）")
            break
    # 言い換え
    lm = s.lam[one_w]                                             # Λ̌_max = Λ̌_(1,…,1)（eigenvalues_of_V_plus (2) の置き方）
    roots = {}
    for (rt, k) in s.VQ.charpoly().roots(AA):
        roots[rt] = roots.get(rt, 0) + k
    rmax = max(roots.keys())
    rep.check(s.to_qqbar(lm) == QQbar(rmax) and roots[rmax] == 1, f"{tag}: Λ̌_(1,…,1) は V^(+) の最大の根で重複度 1")
    Kr = (s.V - lm * Id).right_kernel()
    Im = Q1.column_space()
    rep.check(Kr.dimension() == 1 and Kr == Im, f"{tag}: {{x | V^(+)x = Λ̌_max x}} = im Q̌_(1,…,1)")
    rep.check(all(E * matrix(F, N, 1, list(v)) == matrix(F, N, 1, list(v)) for v in Kr.basis()), f"{tag}: その空間 ⊆ F^(+)")
    # 独立の確認（ψ̌ を使わない）
    VA = s.VQ.change_ring(QQbar)
    EA = matrix(QQbar, N, N, [QQbar(c) for c in epsilon(M).list()])
    KA = (VA - QQbar(rmax) * identity_matrix(QQbar, N)).right_kernel()
    vA = matrix(QQbar, N, 1, list(KA.basis()[0]))
    rep.check(KA.dimension() == 1 and EA * vA == vA, f"{tag}: V^(+) の最大の根の固有ベクトル v で εv = v（ψ̌ を使わない）")
    r2 = sorted(roots.keys())[-2]
    K2 = (VA - QQbar(r2) * identity_matrix(QQbar, N)).right_kernel()
    rep.negative(any(EA * matrix(QQbar, N, 1, list(v)) != matrix(QQbar, N, 1, list(v)) for v in K2.basis()), f"{tag}: 2 番目の根の固有空間は F^(+) に入らない基底を持つ")
    print(f"  {tag}: Λ̌_max ≈ {RR(rmax):.6f}（累計 {rep.n} 件、否定 {rep.neg} 件）", flush=True)

rep.finish()
