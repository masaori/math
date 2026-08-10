# 対象ラベル: claim_qbar_transfer_preserves_shift_eigenspace
#   併せて引く定義・主張: def_qbar_matrix, def_qbar_vector, def_qbar_matrix_product,
#                         def_qbar_matrix_action, def_qbar_vector_smul, def_qbar_zero_vector,
#                         def_qbar_eigenspace, def_shift_matrix, def_transfer_matrix,
#                         def_qbar_matrix_eval, claim_qbar_commuting_preserves_eigenspace,
#                         claim_qbar_shift_transfer_commute
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「転送行列はシフト行列の各固有空間をそれ自身へ写す」
# （v ∈ E_{Ev_xi(U)}(z) ならば Ev_xi(T)·v ∈ E_{Ev_xi(U)}(z)）を、小さい L で確かめる。
#
# この段は組み立てだけである。すなわち、可換な行列が固有空間を保つこと
# （claim_qbar_commuting_preserves_eigenspace）を A = Ev_xi(U)、B = Ev_xi(T) に当て、
# その仮定 AB = BA を評価で運んだ 2 つの行列の可換性
# （claim_qbar_shift_transfer_commute）で埋めたものである。
# したがってここで確かめるのは、当てはめの 2 つの入力が実際に成り立つことと、
# 当てはめた結論が成り立つことである。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合と 2 つの行列。R_L が 2^L 元で、U と T の成分が定義どおりであること。
#   2. 当てはめの入力その 1。Ev_xi(U) Ev_xi(T) = Ev_xi(T) Ev_xi(U)（可換性）。
#   3. 当てはめの入力その 2。各軌道から作った v が E_{Ev_xi(U)}(z) に属し、零ベクトルでないこと
#      （主張が空虚でないこと）。
#   4. 主張そのもの。Ev_xi(U)·(Ev_xi(T)·v) = z⊙(Ev_xi(T)·v)。
#   5. 固有空間が実際に閉じていること。固有空間の元を任意に取っても（軌道の上の 1 本だけでなく、
#      その Qbar 上のスカラー倍と和で作った元でも）転送行列の像がその固有空間に留まること。
#   6. 転送行列であることが効いている範囲。Ev_xi(U) と可換でない行列に取り替えると結論が
#      実際に破れること（L >= 2）。
#   7. v = o_L（零ベクトル）の場合も主張が成り立つこと（固有空間は零ベクトルを含む）。

Ls = [1, 2, 3, 4]

Rx = ZZ["x"]
x = Rx.gen()

# 代入する点 xi。転送行列の成分は x の冪なので、値は xi に依存する。
xis = [QQbar(2), QQbar(-1) / QQbar(3), QQbar(2).sqrt(), QQbar(-1).sqrt()]


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


def orbit_of(tau):
    o = [tau]
    s = shift(tau)
    while s != tau:
        o.append(s)
        s = shift(s)
    return o


def orbits(L):
    seen = set()
    out = []
    for tau in row_configs(L):
        if tau in seen:
            continue
        o = orbit_of(tau)
        seen.update(o)
        out.append(o)
    return out


def eigenvector_on_orbit(L, orbit, zeta):
    """軌道の上で v(S^[r](tau0)) := zeta^{-r}、軌道の外で 0 と置いた列ベクトル。"""
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    v = vector(QQbar, [QQbar(0)] * len(taus))
    for r, tau in enumerate(orbit):
        v[idx[tau]] = zeta ** (-r)
    return v


print("== 転送行列はシフト行列の各固有空間をそれ自身へ写す ==")

for L in Ls:
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    n = len(taus)
    zero = vector(QQbar, [QQbar(0)] * n)

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

    checked = 0
    combos = 0
    for xi in xis:
        A = evaluate(Upoly, xi)     # Ev_xi(U)
        B = evaluate(Tpoly, xi)     # Ev_xi(T)

        # ---- 2. 当てはめの入力その 1（可換性） ---------------------------
        assert A * B == B * A, "Ev_xi(U) と Ev_xi(T) が可換でない"

        # 固有値ごとに、その固有空間に属する元をいくつか作る。
        by_eigenvalue = {}
        for o in orbits(L):
            e = len(o)
            zeta = QQbar.zeta(e)      # 1 の原始 e 乗根（厳密な代数的数）
            z = zeta ** (-1)          # 固有値
            v = eigenvector_on_orbit(L, o, zeta)

            # ---- 3. 当てはめの入力その 2 ------------------------------
            assert v != zero, "取った v が零ベクトルである"
            assert A * v == z * v, "v が E_{Ev_xi(U)}(z) に属していない"

            # ---- 4. 主張そのもの --------------------------------------
            assert A * (B * v) == z * (B * v), \
                "Ev_xi(T)·v が E_{Ev_xi(U)}(z) に属していない"
            checked += 1

            by_eigenvalue.setdefault(z, []).append(v)

        # ---- 5. 固有空間が閉じていること（和とスカラー倍で作った元でも） ----
        # 同じ固有値に属する元どうしの和と、Qbar のスカラー倍を取って確かめる。
        for z, vs in by_eigenvalue.items():
            for i in range(len(vs)):
                for j in range(len(vs)):
                    w = vs[i] + QQbar(3) * vs[j]
                    assert A * w == z * w, "作った w が固有空間に属していない"
                    assert A * (B * w) == z * (B * w), \
                        "固有空間が転送行列の作用で閉じていない"
                    combos += 1

        # ---- 7. v = o_L の場合 -------------------------------------------
        z0 = QQbar(1)
        assert A * zero == z0 * zero, "零ベクトルが固有空間に属していない"
        assert A * (B * zero) == z0 * (B * zero), "零ベクトルの像が固有空間に属していない"

    # ---- 6. 可換性が効いていること ----------------------------------------
    # Ev_xi(U) と可換でない行列（行列単位）に取り替えると結論が破れることを見る。
    A0 = evaluate(Upoly, QQbar(2))
    broken = False
    for o in orbits(L):
        e = len(o)
        zeta = QQbar.zeta(e)
        z = zeta ** (-1)
        v = eigenvector_on_orbit(L, o, zeta)
        for i in range(n):
            for j in range(n):
                Bad = matrix(QQbar, n, n, lambda a, b: QQbar(0))
                Bad[i, j] = QQbar(1)
                if A0 * Bad == Bad * A0:
                    continue
                if A0 * (Bad * v) != z * (Bad * v):
                    broken = True
                    break
            if broken:
                break
        if broken:
            break
    if L >= 2:
        assert broken, "可換でない行列で結論が破れる例が見つからなかった"

    print("L=%d: R_L は %d 元。xi %d 個 × 軌道 %d 個の %d 通りで主張が成り立ち、"
          "和とスカラー倍で作った %d 通りでも固有空間に留まる。"
          "可換でない行列では結論が破れる（L>=2）。v = o_L の場合も成り立つ"
          % (L, n, len(xis), len(orbits(L)), checked, combos))

print("すべて通過")
