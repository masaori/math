# 対象ラベル: T_V_plus_check_Z_Y
# 証明の (z)・(y) の 12 行の鎖と、2 列を並べる 8 行の鎖を、K_1 = 2 log y・K_2 = log x と選んで数体 F の中で厳密に確かめる
# （準備は calc_of_TxT_check_Z_Y の _prelude.sage と _shared/transfer_factor_actions_on_check_Z_Y.sage）。
# 共役 T_g(W) は def_T_g の (gW)g^{-1} を本文の積の成分の式（body_product）と Sage の inverse で作り、
# 行列の組と数の列の積・組と 2×2 行列の積は本文の二つの定義の成分の式で、Mat(2,ℂ) の元と数の列の積は mat_mult の成分の式で作る。
# 主張の左辺は、T_{(V^{(+)})} を経ずに V^{(+)} = S V_2 S（def_V_plus）の Sage の積と inverse で作った共役と比べる。
import sys
load("../calc_of_TxT_check_Z_Y/_prelude.sage")


def mat_mult_by_definition(P, v):
    """mat_mult の (Pv)_{ik} := Σ_j P_{ij} v_{jk}。"""
    return matrix(P.base_ring(), P.nrows(), v.ncols(),
                  lambda i, k: sum((P[i, j] * v[j, k] for j in range(P.ncols())), P.base_ring()(0)))


def col(w):
    return (w[0, 0], w[1, 0])


Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
samples = [(2, 2), (3, QQ(3) / 2)]

for M in Ms:
    for (x, y) in samples:
        f = Factors(M, x, y)
        F, i = f.F, f.i
        tag = f"M={M} x={x} y={y}"
        S, S_inv = f.expX, f.expX.inverse()
        V2, V2_inv = f.V2, f.V2.inverse()
        TS = lambda W: body_product(body_product(S, W), S_inv)
        TV2 = lambda W: body_product(body_product(V2, W), V2_inv)
        Vp = S * V2 * S                                   # def_V_plus（Sage の積）
        Vp_inv = Vp.inverse()
        B2 = B2_by_definition(f)
        for mu in range(1, M + 1):
            Zc, Yc = f.Zc[mu], f.Yc[mu]
            ep, em = f.phase(mu, 1), f.phase(mu, -1)
            B1 = B1_by_definition(f, ep, em)
            beta = {1: matrix(F, 2, 1, [f.ch1, (i * em) * f.sh1]),           # 準備の β_1 の置き方
                    2: matrix(F, 2, 1, [((-i) * ep) * f.sh1, f.ch1])}       # 準備の β_2 の置き方
            lab = f"{tag} mu={mu}"
            for j in (1, 2):
                report(all(beta[j][l, 0] == B1[l, j - 1] for l in range(2)), f"{lab}: 準備 (β_{j})_{{l1}} = (B_1(θ̃))_{{l{j}}}")
            ends = {}
            for (name, X, j, t_actions) in [
                ("(z)", Zc, 1, body_sum(body_scalar(f.ch1, Zc), body_scalar((i * em) * f.sh1, Yc))),
                ("(y)", Yc, 2, body_sum(body_scalar(((-i) * ep) * f.sh1, Zc), body_scalar(f.ch1, Yc))),
            ]:
                b = beta[j]
                w = mat_mult_by_definition(B2, b)
                rows = [
                    TS(TV2(TS(X))),                                                          # 1 行目 def_T_V_plus
                    TS(TV2(t_actions)),                                                      # 2 行目 T_actions_on_check_Z_Y の左の等号
                    TS(TV2(body_sum(body_scalar(b[0, 0], Zc), body_scalar(b[1, 0], Yc)))),  # 3 行目 β_j の置き方
                    TS(body_sum(body_scalar(b[0, 0], TV2(Zc)), body_scalar(b[1, 0], TV2(Yc)))),  # 4 行目 linearity_of_T_V2
                    TS(pair_times_column(TV2(Zc), TV2(Yc), *col(b))),                        # 5 行目 def_pair_..._column
                    TS(pair_times_column(*pair_times_two_by_two(Zc, Yc, B2), *col(b))),     # 6 行目 calc_of_TxT 第 2 式
                    TS(pair_times_column(Zc, Yc, *col(w))),                                  # 7 行目 結合律の主張
                    TS(body_sum(body_scalar(w[0, 0], Zc), body_scalar(w[1, 0], Yc))),       # 8 行目 def_pair_..._column
                    body_sum(body_scalar(w[0, 0], TS(Zc)), body_scalar(w[1, 0], TS(Yc))),   # 9 行目 linearity_of_T_on_check_Z_Y
                    pair_times_column(TS(Zc), TS(Yc), *col(w)),                              # 10 行目 def_pair_..._column
                    pair_times_column(*pair_times_two_by_two(Zc, Yc, B1), *col(w)),         # 11 行目 calc_of_TxT 第 1 式
                    pair_times_column(Zc, Yc, *col(mat_mult_by_definition(B1, w))),         # 12 行目 結合律の主張
                ]
                start = (Vp * X) * Vp_inv
                report(start == rows[0], f"{lab} {name}: T_(V+)(X)（V^(+) の Sage の積と inverse）= 1 行目")
                for n in range(1, len(rows)):
                    report(rows[n - 1] == rows[n], f"{lab} {name}: {n} 行目 = {n + 1} 行目")
                ends[j] = rows[-1]
                # 対照: B_2 の転置で作った 6 行目は 5 行目と一致しない
                report(rows[4] != TS(pair_times_column(*pair_times_two_by_two(Zc, Yc, B2.transpose()), *col(b))),
                       f"{lab} {name}: 対照 6 行目の B_2 を転置すると 5 行目と一致しない")
            # 2 列を並べる鎖
            C = mat_mult_by_definition(B1, B2)            # B_1(θ̃) B_2（mat_mult）
            Q = mat_mult_by_definition(C, B1)             # (B_1(θ̃) B_2) B_1(θ̃)
            final = [
                (ends[1], ends[2]),                                                                         # 1 行目
                tuple(pair_times_column(Zc, Yc, *col(mat_mult_by_definition(C, beta[j]))) for j in (1, 2)),  # 2 行目
                tuple(pair_times_column(Zc, Yc, mat_mult_by_definition(C, beta[j])[0, 0],
                                        mat_mult_by_definition(C, beta[j])[1, 0]) for j in (1, 2)),       # 3 行目（成分を取る約束）
                tuple(pair_times_column(Zc, Yc, sum(C[0, l] * beta[j][l, 0] for l in range(2)),
                                        sum(C[1, l] * beta[j][l, 0] for l in range(2))) for j in (1, 2)),   # 4 行目
                tuple(pair_times_column(Zc, Yc, sum(C[0, l] * B1[l, j - 1] for l in range(2)),
                                        sum(C[1, l] * B1[l, j - 1] for l in range(2))) for j in (1, 2)),    # 5 行目
                tuple(pair_times_column(Zc, Yc, Q[0, j - 1], Q[1, j - 1]) for j in (1, 2)),                  # 6 行目
                pair_times_two_by_two(Zc, Yc, Q),                                                           # 7 行目
            ]
            start = ((Vp * Zc) * Vp_inv, (Vp * Yc) * Vp_inv)
            report(start == final[0], f"{lab}: 2 列を並べる鎖の始点（Sage の共役）= 1 行目")
            for n in range(1, len(final)):
                report(final[n - 1] == final[n], f"{lab}: 2 列を並べる鎖 {n} 行目 = {n + 1} 行目")
            report(Q == (B1 * B2) * B1, f"{lab}: (B_1 B_2) B_1 を mat_mult の成分で組んだものが Sage の積と一致")
            # 8 行目の A(θ̃) への置き換えは factorization_of_A_theta_general の検算が確かめる。ここでは 7 行目が
            # 主張の右辺の形 (Ž, Y̌)G（G = (B_1B_2)B_1）であり、G の成分の順序の対照（転置）で一致しないことを見る。
            if Q != Q.transpose():
                report(pair_times_two_by_two(Zc, Yc, Q.transpose()) != start, f"{lab}: 対照 G の転置では一致しない")
            else:
                print(f"SKIP: {lab}: G が対称なので転置の対照は意味を持たない")
        print(f"{tag}: done")
print("RESULT: PASS")
