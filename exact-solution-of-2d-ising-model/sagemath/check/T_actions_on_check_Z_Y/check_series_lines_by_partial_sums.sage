# 対象ラベル: T_actions_on_check_Z_Y
# 四本の鎖の「(exp(G)W)exp(-G) = Σ_{n≥0} (1/n!)_C ad^n_G(W)」の行（exp_X_Y_exp_-X の当てはめ）を部分和で確かめる。
# G_1 = (i/2)((K_1)_C H_1^(+)) は K_1 = 2 log y のとき (log y)·(iH_1^(+))、G_2 = i((K_2^*)_C H_2) は K_2^* = -(1/2) log t のとき
# K_2^*·(iH_2) なので（この書き換えは check_preparation_and_scalar_lines.sage が不定元で確かめる）、
# A_n := ad^n_{iH}(W) を F の中で厳密に作り、部分和 S_N := Σ_{n=0}^{N} (ℓ^n/n!) A_n を複素数のボールで作る。
# ℓ = log y・-(1/2) log t は標本の選び方から来る実数で、Arb の log のボールで持つ（ℝ への脱出: 実対数）。
# 左辺 (exp(G)W)exp(-G) は _prelude.sage の厳密な値（固有値の射影に y^{±λ}・(√t)^{∓λ} を掛けたもの）を埋め込みで移す。
# 級数の極限そのもの（全ての N）は確かめられないので、‖S_N - 左辺‖ が小さいことと、N を増やすと差が減ることで確かめる。
import sys
load("_prelude.sage")

PREC_ = 512
RBF_ = RealBallField(PREC_)
CBF_ = ComplexBallField(PREC_)
N_SUM = 90
Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
samples = [(2, 2), (3, QQ(3) / 2)]


def cabs(w):
    return (w.real()**2 + w.imag()**2).sqrtpos()


def mnorm(Mb):
    """def_matrix_norm の成分の平方和の平方根。"""
    return sum(cabs(Mb[p, q])**2 for p in range(Mb.nrows()) for q in range(Mb.ncols())).sqrtpos()


for M in Ms:
    for (x, y) in samples:
        f = Factors(M, x, y)
        F = f.F
        emb = embedding_to_qqbar(f)
        toCm = lambda A: matrix(CBF_, A.nrows(), A.ncols(), lambda p, q: CBF_(emb(A[p, q])))
        iH1 = f.kg_to_F(body_scalar(i_K, H1_plus(M)))
        iH2 = f.kg_to_F(body_scalar(i_K, H2(M)))
        report(iH1 == matrix(F, f.S1) and iH2 == matrix(F, f.S2), f"M={M}: iH_1^(+)・iH_2 は exp の射影に使った整数行列に等しい")
        l1 = RBF_(f.y).log()
        l2 = -RBF_(f.t).log() / 2
        tag = f"M={M} x={x} y={y}"
        for mu in range(1, M + 1):
            for (name, W) in [("Ž", f.Zc[mu]), ("Y̌", f.Yc[mu])]:
                for (gname, iH, ell, E, Em) in [("G_1", iH1, l1, f.expX, f.expmX), ("G_2", iH2, l2, f.expY, f.expmY)]:
                    lhs = toCm(body_product(body_product(E, W), Em))
                    A = W
                    Ssum = matrix(CBF_, f.n, f.n)
                    diffs = {}
                    for nn in range(N_SUM + 1):
                        if nn > 0:
                            A = comm_body(iH, A)
                        Ssum = Ssum + (ell**nn / factorial(nn)) * toCm(A)
                        if nn in (10, 30, N_SUM):
                            diffs[nn] = mnorm(Ssum - lhs)
                    report(diffs[N_SUM] < RBF_(10)**(-40),
                           f"{tag} mu={mu} {gname},{name}: ‖S_{N_SUM} - (exp(G)W)exp(-G)‖ < 1e-40（上端 {diffs[N_SUM].upper():.3e}）")
                    report(diffs[30].upper() < diffs[10].lower() or diffs[10].upper() < RBF_(10)**(-40),
                           f"{tag} mu={mu} {gname},{name}: 部分和の差は N = 10 から 30 で減る")
                    # 対照: 共役の向きを逆にした (exp(-G)W)exp(G) とは離れる（Ž・Y̌ は ad_{iH} で動くので）
                    wrong = toCm(body_product(body_product(Em, W), E))
                    report(mnorm(Ssum - wrong) > RBF_(10)**(-3), f"{tag} mu={mu} {gname},{name}: 対照 (exp(-G)W)exp(G) とは一致しない")
        print(f"{tag}: done")
print("RESULT: PASS")
