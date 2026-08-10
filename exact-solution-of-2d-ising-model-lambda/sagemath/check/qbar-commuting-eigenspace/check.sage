# 対象ラベル: claim_qbar_commuting_preserves_eigenspace
#   併せて引く定義・主張: def_qbar_matrix, def_qbar_vector, def_qbar_matrix_product,
#                         def_qbar_matrix_action, def_qbar_vector_smul, def_qbar_zero_vector,
#                         def_qbar_eigenspace, def_shift_matrix, def_transfer_matrix,
#                         def_qbar_matrix_eval, claim_qbar_action_product,
#                         claim_qbar_action_smul, theorem_shift_matrix_commutes
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「可換な行列は固有空間を保つ」（AB = BA かつ v ∈ E_A(z) ならば B·v ∈ E_A(z)）を、
# 小さい L で確かめる。
#
# 行列には、この章が実際に使う 2 つを取る。A にはシフト行列 U を代数的数 xi で評価した
# Ev_xi(U)、B には転送行列 T を同じ xi で評価した Ev_xi(T) である。この 2 つが可換なのは
# theorem_shift_matrix_commutes（UT = TU）が Ev_xi で運ばれるためであり、そのことも
# ここで確かめる（主張の仮定が実際に満たされること）。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 添字集合と 2 つの行列。R_L が 2^L 元で、U と T の成分が定義どおりであること。
#   2. 仮定が満たされること。Ev_xi(U) Ev_xi(T) = Ev_xi(T) Ev_xi(U)。
#   3. 主張が空虚でないこと。Ev_xi(U) の固有空間に零でない元 v があること。
#   4. 鎖の 5 段。A·(B·v) = (AB)·v = (BA)·v = B·(A·v) = B·(z⊙v) = z⊙(B·v)。
#   5. 主張そのもの。B·v が E_A(z) に属すること（A·(B·v) = z⊙(B·v)）。
#   6. 仮定 AB = BA が効いていること。可換でない行列 B' を取ると結論が実際に破れること。
#   7. 固有ベクトルではなく固有空間について述べた理由。B·v が零ベクトルになる場合があり、
#      そのときも E_A(z) には属すること（B に零行列を取って確かめる）。

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


def eigenvector_on_orbit(L, orbit, zeta):
    """軌道の上で v(S^[r](tau0)) := zeta^{-r}、軌道の外で 0 と置いた列ベクトル。"""
    taus = row_configs(L)
    idx = {tau: i for i, tau in enumerate(taus)}
    v = vector(QQbar, [QQbar(0)] * len(taus))
    for r, tau in enumerate(orbit):
        v[idx[tau]] = zeta ** (-r)
    return v


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


print("== 可換な行列は固有空間を保つ ==")

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

    checked = 0
    for xi in xis:
        A = evaluate(Upoly, xi)
        B = evaluate(Tpoly, xi)

        # ---- 2. 仮定が満たされること（UT = TU が Ev_xi で運ばれる） ---------
        assert A * B == B * A, "Ev_xi(U) と Ev_xi(T) が可換でない"

        for o in orbits(L):
            e = len(o)
            zeta = QQbar.zeta(e)          # 1 の原始 e 乗根（厳密な代数的数）
            z = zeta ** (-1)              # 固有値
            v = eigenvector_on_orbit(L, o, zeta)
            zero = vector(QQbar, [QQbar(0)] * n)

            # ---- 3. 主張が空虚でないこと ---------------------------------
            assert v != zero, "取った v が零ベクトルである"
            assert A * v == z * v, "v が E_A(z) に属していない"

            # ---- 4. 鎖の 5 段 -------------------------------------------
            c1 = A * (B * v)              # 出発点
            c2 = (A * B) * v              # 第 1 段（作用の積、右辺から左辺へ）
            c3 = (B * A) * v              # 第 2 段（仮定 AB = BA）
            c4 = B * (A * v)              # 第 3 段（作用の積）
            c5 = B * (z * v)              # 第 4 段（v ∈ E_A(z)）
            c6 = z * (B * v)              # 第 5 段（作用がスカラー倍を保つ）
            assert c1 == c2 == c3 == c4 == c5 == c6, "鎖のどこかで値が変わった"

            # ---- 5. 主張そのもの ----------------------------------------
            assert A * (B * v) == z * (B * v), "B·v が E_A(z) に属していない"
            checked += 1

    # ---- 6. 仮定 AB = BA が効いていること ---------------------------------
    # A と可換でない行列 B' を 1 つ作り、結論が実際に破れることを見る。
    A0 = evaluate(shift_matrix_poly(L), QQbar(2))
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

    # ---- 7. B·v が零ベクトルになる場合（固有空間について述べた理由） -------
    Zero = matrix(QQbar, n, n, lambda a, b: QQbar(0))
    o0 = orbits(L)[0]
    zeta0 = QQbar.zeta(len(o0))
    z0 = zeta0 ** (-1)
    v0 = eigenvector_on_orbit(L, o0, zeta0)
    assert A0 * Zero == Zero * A0, "零行列が可換でない"
    assert Zero * v0 == vector(QQbar, [QQbar(0)] * n), "零行列の作用が零ベクトルでない"
    assert A0 * (Zero * v0) == z0 * (Zero * v0), "零ベクトルが E_A(z) に属していない"

    print("L=%d: R_L は %d 元。xi %d 個 × 軌道 %d 個の %d 通りで鎖の 5 段と主張が成り立つ。"
          "可換でない行列では結論が破れる（L>=2）。B·v = o_L の場合も E_A(z) に属する"
          % (L, n, len(xis), len(orbits(L)), checked))

print("すべて通過")
