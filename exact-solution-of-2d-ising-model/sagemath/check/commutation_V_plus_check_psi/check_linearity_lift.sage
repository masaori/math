# 対象ラベル: commutation_V_plus_check_psi
# 証明の準備 3（T := T_{(V^{(+)})} を組へ当てる、6 式の鎖と組の 3 式）を一行ずつ確かめる。
# T は def_T_V_plus の三つの共役の合成 T_S(T_{V_2}(T_S(X)))（S = (V_1^{(+)})^{1/2}）で、T_{V^{(+)}} は def_V_plus の
# V^{(+)} = (S V_2) S による def_T_g の共役 (V^{(+)}X)(V^{(+)})^{-1} である。積は全て mat_mult の成分の式で組む。
# G の成分は E 上の独立な不定元に取り、X_1, X_2 は (Ž_μ, Y̌_μ) と、成分が -3..3 の整数（実部・虚部）の乱択行列の組の二通りにする。
# 範囲: 結合定数 3 組 × M_col = 2, 3 × 全 μ（数体 E の中で厳密）。
# 対照: 第 5 式で G を転置して読んだ (T(X_1), T(X_2))G^T の成分とは一致しない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("commutation_V_plus_check_psi: 準備 3（T を組へ当てる）")
set_random_seed(20261103)

for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        for mu in range(1, M + 1):
            s = PsiSetting(f, mu)
            E, n = s.E, s.n
            Pg = PolynomialRing(E, ['g11', 'g12', 'g21', 'g22'])
            G = matrix(Pg, 2, 2, Pg.gens())
            up = lambda A: A.change_ring(Pg)
            S, Sinv, V2, V2inv = up(s.S), up(s.Sinv), up(s.V2), up(s.V2inv)
            V, Vinv = s.Vplus()
            I = body_identity(E, n)
            rep.check(body_product(V, Vinv) == I and body_product(Vinv, V) == I,
                      f"(x,y)=({x},{y}) M={M} μ={mu}: V^(+) と (S^-1 V_2^-1) S^-1 は互いの逆元", quiet=True)
            V, Vinv = up(V), up(Vinv)
            T = lambda X: conj_body(S, conj_body(V2, conj_body(S, X, Sinv), V2inv), Sinv)
            TV = lambda X: conj_body(V, X, Vinv)
            iE = E(f.i)
            rnd = lambda: matrix(E, n, n, [ZZ.random_element(-3, 4) + ZZ.random_element(-3, 4) * iE for _ in range(n * n)])
            for tag, (X1, X2) in (("(Ž, Y̌)", (s.Z, s.Y)), ("乱択", (rnd(), rnd()))):
                X1, X2 = up(X1), up(X2)
                pairX = (X1, X2)
                TX = (T(X1), T(X2))
                for l in (1, 2):
                    L = l - 1
                    comb = body_sum(body_scalar(G[0, L], X1), body_scalar(G[1, L], X2))
                    rows = [
                        T(pr(l, pair_times_two_by_two(pairX, G))),
                        T(comb),
                        TV(comb),
                        body_sum(body_scalar(G[0, L], TV(X1)), body_scalar(G[1, L], TV(X2))),
                        body_sum(body_scalar(G[0, L], TX[0]), body_scalar(G[1, L], TX[1])),
                        pr(l, pair_times_two_by_two(TX, G)),
                    ]
                    for k in range(len(rows) - 1):
                        rep.check(rows[k] == rows[k + 1],
                                  f"(x,y)=({x},{y}) M={M} μ={mu} {tag} l={l}: 第 {k+1} 式 = 第 {k+2} 式", quiet=True)
                    rep.check(rows[-1] != pr(l, pair_times_two_by_two(TX, G.transpose())),
                              f"対照 (x,y)=({x},{y}) M={M} μ={mu} {tag} l={l}: G を転置して読むと一致しない", quiet=True)
                lhs = (T(pr(1, pair_times_two_by_two(pairX, G))), T(pr(2, pair_times_two_by_two(pairX, G))))
                mid = (pr(1, pair_times_two_by_two(TX, G)), pr(2, pair_times_two_by_two(TX, G)))
                rep.check(pair_eq(lhs, mid) and pair_eq(mid, pair_times_two_by_two(TX, G)),
                          f"(x,y)=({x},{y}) M={M} μ={mu} {tag}: 組の鎖 3 式", quiet=True)
            print(f"  (x,y)=({x},{y}) M={M} μ={mu}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）")

rep.finish()
