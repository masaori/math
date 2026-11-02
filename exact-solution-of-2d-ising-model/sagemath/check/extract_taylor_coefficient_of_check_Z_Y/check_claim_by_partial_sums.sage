# 対象ラベル: extract_taylor_coefficient_of_check_Z_Y
# 主張 (h1.z)・(h1.y)・(h2.z)・(h2.y) そのものを具体の値で確かめる。K_1 = 3/10、K_2^* = 7/10（2K_2^* = 7/5）、M_col = 2, 3, 4、全 μ で、
# 級数の部分和 S_N = Σ_{n=0}^{N} (1/n!)_C ad^n_G(W)（N = 60）を円分体 QQ(ζ_{4M}) の中で厳密に作り、主張の右辺との差のノルムが小さいことを確かめる。
# 右辺の cosh・sinh の値は QQ に収まらないので ℝ へ脱出し、本文の exp を囲むボール（one_by_one_matrix.sage の body_real_exp_ball。
# 本文の部分和に尾の評価を半径として足したもの。Arb の exp は使わない）から def_cosh_sinh の式で作る。円分体の元は、ζ_{4M} を
# QQbar の exp(2πi/(4M)) へ送る埋め込みで複素数のボールへ移す。ノルムは def_matrix_norm の成分の平方和の平方根。
import sys
load("_prelude.sage")

N_SUM = 60
PREC_ = 512
RBF_ = RealBallField(PREC_)
CBF_ = ComplexBallField(PREC_)
K1v, K2v = QQ(3) / 10, QQ(7) / 10
Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]


def cosh_b(x):
    return (body_real_exp_ball(x, prec=PREC_) + body_real_exp_ball(-x, prec=PREC_)) / 2


def sinh_b(x):
    return (body_real_exp_ball(x, prec=PREC_) - body_real_exp_ball(-x, prec=PREC_)) / 2


def cabs(z):
    return (z.real()^2 + z.imag()^2).sqrtpos()


def mnorm(Mb):
    return sum(cabs(Mb[p, q])^2 for p in range(Mb.nrows()) for q in range(Mb.ncols())).sqrtpos()


for M in Ms:
    S = Setting(M)
    L, zeta = S.L, S.zeta
    emb = [e for e in L.embeddings(QQbar) if e(zeta) == QQbar.zeta(4 * M)]
    assert len(emb) == 1
    emb = emb[0]
    toC = lambda z: CBF_(emb(z))
    sub = lambda A: matrix(L, A.nrows(), A.ncols(), lambda p, q: L(A[p, q](k1=K1v, k2=K2v)))
    toCm = lambda A: matrix(CBF_, A.nrows(), A.ncols(), lambda p, q: toC(A[p, q]))
    iL = S.iL
    G1 = sub(body_scalar(S.P(iL * QQ(1) / 2) * S.k1, S.H1))
    G2 = sub(body_scalar(S.P(iL) * S.k2, S.H2))
    ch1, sh1, ch2, sh2 = cosh_b(K1v), sinh_b(K1v), cosh_b(2 * K2v), sinh_b(2 * K2v)
    for mu in range(1, M + 1):
        Zc, Yc = sub(S.checkZ(mu)), sub(S.checkY(mu))
        em, ep = toC(L(S.ph(mu, -1))), toC(L(S.ph(mu, 1)))
        iC = toC(iL)
        Zb, Yb = toCm(Zc), toCm(Yc)
        cases = [
            ("h1.z", G1, Zc, Zb * CBF_(ch1) + Yb * ((iC * em) * CBF_(sh1)), Zb * CBF_(ch1) + Yb * ((-iC * em) * CBF_(sh1))),
            ("h1.y", G1, Yc, Zb * ((-iC * ep) * CBF_(sh1)) + Yb * CBF_(ch1), Zb * ((iC * ep) * CBF_(sh1)) + Yb * CBF_(ch1)),
            ("h2.z", G2, Zc, Zb * CBF_(ch2) + Yb * ((-iC) * CBF_(sh2)), Zb * CBF_(ch2) + Yb * (iC * CBF_(sh2))),
            ("h2.y", G2, Yc, Zb * (iC * CBF_(sh2)) + Yb * CBF_(ch2), Zb * ((-iC) * CBF_(sh2)) + Yb * CBF_(ch2)),
        ]
        for (name, G, W, rhs, wrong) in cases:
            T = W
            Ssum = matrix(L, W.nrows(), W.ncols())
            for n in range(N_SUM + 1):
                if n > 0:
                    T = comm_body(G, T)
                Ssum = body_sum(Ssum, body_scalar(L(QQ(1) / factorial(n)), T))
            d = mnorm(toCm(Ssum) - rhs)
            report(d < RBF_(10)^(-40), f"M={M} mu={mu} ({name}): ‖S_{N_SUM} - 右辺‖ < 1e-40（上端 {d.upper():.3e}）")
            report(mnorm(toCm(Ssum) - wrong) > RBF_(10)^(-3), f"M={M} mu={mu} ({name}): 対照 奇数側の係数の符号を逆にした式とは一致しない")
    print(f"M={M}: done")
print("RESULT: PASS")
