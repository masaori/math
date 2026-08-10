# 対象ラベル: claim_qbar_shift_transfer_commute
#   併せて引く定義・主張: def_shift_matrix, def_transfer_matrix, def_matrix_product,
#                         def_qbar_matrix, def_qbar_matrix_product, def_qbar_matrix_eval,
#                         claim_qbar_matrix_eval_product, theorem_shift_matrix_commutes
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「評価で運んだシフト行列と転送行列は可換である」
# （Ev_xi(U) Ev_xi(T) = Ev_xi(T) Ev_xi(U)）を、小さい L で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 添字集合と 2 つの行列。R_L が 2^L 元で、U と T の成分が定義どおりであること。
#   2. Z[x] の側の可換性 UT = TU（theorem_shift_matrix_commutes。この段が運ぶ元の事実）。
#   3. 鎖の 3 段。
#        Ev_xi(U) Ev_xi(T) = Ev_xi(UT)          （評価が積を保つことを右辺から左辺へ）
#                          = Ev_xi(TU)          （UT = TU）
#                          = Ev_xi(T) Ev_xi(U)  （評価が積を保つこと）
#   4. 主張そのもの。Ev_xi(U) Ev_xi(T) = Ev_xi(T) Ev_xi(U)。
#   5. **この結論が自明でないこと。** Ev_xi は積を保つので、Z[x] の側で可換でない 2 つの
#      行列を運ぶと Qbar の側でも可換にならないこと（可換性が U と T について効いていること）。
#   6. **評価が積を保つことが効いていること。** 成分ごとに勝手な値を返す（積を保たない）
#      写像で運ぶと、Z[x] の側が可換でも Qbar の側の可換性が破れうること。

Ls = [1, 2, 3, 4, 5]

Rx = ZZ["x"]
x = Rx.gen()

# 代入する点 xi。転送行列の成分は x の冪なので、値は xi に依存する。
xis = [QQbar(2), QQbar(-1) / QQbar(3), QQbar(2).sqrt(), QQbar(-1).sqrt(), QQbar(0)]


def row_configs(L):
    """行配位の全体 R_L（長さ L の +1/-1 の並び）を、実行のたび同じ順序で返す。"""
    return [tuple(1 if (mask >> y) & 1 == 0 else -1 for y in range(L))
            for mask in range(2 ** L)]


def shift(tau):
    """巡回シフト S(tau)(y) = tau(y + 1 mod L)。"""
    L = len(tau)
    return tuple(tau[(y + 1) % L] for y in range(L))


def intra(tau):
    """行内破れ数 b_h(tau) = #{ y | tau(y) != tau(y+1) }。"""
    L = len(tau)
    return sum(1 for y in range(L) if tau[y] != tau[(y + 1) % L])


def inter(tau, tau_next):
    """行間破れ数 b_v(tau, tau') = #{ y | tau(y) != tau'(y) }。"""
    return sum(1 for y in range(len(tau)) if tau[y] != tau_next[y])


def shift_matrix_poly(L):
    """シフト行列 U（成分は Z[x] の定数多項式 kappa(1) / kappa(0)）。"""
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    M = matrix(Rx, len(taus), len(taus), lambda i, j: Rx(0))
    for tau in taus:
        M[idx[tau], idx[shift(tau)]] = Rx(1)
    return M


def transfer_matrix_poly(L):
    """転送行列 T_{tau,tau'} = x^{b_h(tau) + b_v(tau,tau')}（成分は Z[x]）。"""
    taus = row_configs(L)
    return matrix(Rx, len(taus), len(taus),
                  lambda i, j: x ** (intra(taus[i]) + inter(taus[i], taus[j])))


def evaluate(M, xi):
    """成分ごとの評価 Ev_xi（Z[x] の行列を Qbar の行列へ運ぶ）。"""
    n = M.nrows()
    return matrix(QQbar, n, n, lambda i, j: QQbar(M[i, j](xi)))


def evaluate_broken(M, xi):
    """積を保たない写像。成分ごとに値を 1 ずらして運ぶ（比較のためだけに置く）。"""
    n = M.nrows()
    return matrix(QQbar, n, n, lambda i, j: QQbar(M[i, j](xi)) + QQbar(1))


print("== 評価で運んだシフト行列と転送行列は可換である ==")

for L in Ls:
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    n = len(taus)

    # ---- 1. 添字集合と 2 つの行列 -----------------------------------------
    assert n == 2 ** L, "R_L の元の個数が 2^L でない"
    Upoly = shift_matrix_poly(L)
    Tpoly = transfer_matrix_poly(L)
    for tau in taus:
        for tau1 in taus:
            expected_U = Rx(1) if tau1 == shift(tau) else Rx(0)
            assert Upoly[idx[tau], idx[tau1]] == expected_U, "U の成分が定義と違う"
            assert Tpoly[idx[tau], idx[tau1]] == x ** (intra(tau) + inter(tau, tau1)), \
                "T の成分が定義と違う"

    # ---- 2. Z[x] の側の可換性（この段が運ぶ元の事実） ----------------------
    UT = Upoly * Tpoly
    TU = Tpoly * Upoly
    assert UT == TU, "Z[x] の側で UT = TU が成り立たない"

    broken_seen = 0
    for xi in xis:
        A = evaluate(Upoly, xi)
        B = evaluate(Tpoly, xi)

        # ---- 3. 鎖の 3 段 ------------------------------------------------
        # 第 1 段: 評価が積を保つことを右辺から左辺へ使う。
        assert A * B == evaluate(UT, xi), "鎖の第 1 段が成り立たない"
        # 第 2 段: Z[x] の側の可換性を評価の中で使う。
        assert evaluate(UT, xi) == evaluate(TU, xi), "鎖の第 2 段が成り立たない"
        # 第 3 段: 評価が積を保つこと。
        assert evaluate(TU, xi) == B * A, "鎖の第 3 段が成り立たない"

        # ---- 4. 主張そのもの ---------------------------------------------
        assert A * B == B * A, "Ev_xi(U) と Ev_xi(T) が可換でない"

        # ---- 6. 評価が積を保つことが効いていること ------------------------
        # 積を保たない写像で運ぶと、Z[x] の側が可換でも Qbar の側で破れうる。
        Ab = evaluate_broken(Upoly, xi)
        Bb = evaluate_broken(Tpoly, xi)
        if Ab * Bb != Bb * Ab:
            broken_seen += 1

    # ---- 5. この結論が自明でないこと ---------------------------------------
    # Z[x] の側で可換でない 2 つの行列を取ると、運んだ先でも可換でない。
    # 行列単位 E_{0,1} と E_{1,0} を取る（L >= 1 なら n >= 2 なので必ず取れる）。
    P = matrix(Rx, n, n, lambda i, j: Rx(1) if (i, j) == (0, 1) else Rx(0))
    Q = matrix(Rx, n, n, lambda i, j: Rx(1) if (i, j) == (1, 0) else Rx(0))
    assert P * Q != Q * P, "比較のために取った 2 つの行列が Z[x] の側で可換になっている"
    noncomm_seen = 0
    for xi in xis:
        if evaluate(P, xi) * evaluate(Q, xi) != evaluate(Q, xi) * evaluate(P, xi):
            noncomm_seen += 1
    assert noncomm_seen == len(xis), "可換でない行列を運んだ先で可換になった xi がある"

    print(
        "L=%d: R_L は %d 元。Z[x] の側で UT = TU。xi %d 個すべてで鎖の 3 段と主張が成り立つ。"
        "可換でない行列は運んだ先でも可換でない（xi %d 個すべて）。"
        "積を保たない写像で運ぶと可換性が破れる xi が %d 個"
        % (L, n, len(xis), noncomm_seen, broken_seen)
    )

print("すべて通過")
