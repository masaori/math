# 対象ラベル: rayleigh_bounds_operator_norm
# 証明の行を、実対称で半正定値な P（本文では P = W_ℝ。def_W_real）・その上限 c = c(M_col)・x ∈ ℝ^n について一行ずつ確かめる。
# 等号は QQ と AA の厳密な等号、不等号は AA の厳密な比較である。

n_steps = 0
n_ineq = 0
n_neg = 0
n_zero_side = 0
n_positive_side = 0


def eq(a, b, what):
    global n_steps
    assert a == b, what
    n_steps += 1


def le(a, b, what):
    global n_ineq
    assert a <= b, what
    n_ineq += 1


def check_proof_lines(P, c, x, K, what):
    """P は QQ の実対称で半正定値、c は rayleigh_sup_exact(P)、x は QQ の数ベクトル、K は冪の主張を確かめる最大の k。"""
    n = P.nrows()
    PA = P.change_ring(AA)
    y = matvec(P, x)                                    # y := Wx（成分は実数。mat_mult の成分の式）
    y_builtin = P * x                                   # 同じ積を Sage の組み込みの行列・ベクトル積で作る（別の経路）
    eq(y, y_builtin, f"{what}: y = Wx の成分の式と組み込みの積")
    nx = norm_exact(x)
    ny = norm_exact(y)
    # W の半正定値性（W_real_is_positive_semidefinite。psd_cauchy_schwarz の仮定）と上限の評価（def_rayleigh_sup）を、この x, y で
    le(0, bil(y, P, y), f"{what}: 0 ≤ y^⊤Wy")
    le(bil(x, P, x), c * nx**2, f"{what}: x^⊤Wx ≤ c‖x‖^2")
    le(bil(y, P, y), c * ny**2, f"{what}: y^⊤Wy ≤ c‖y‖^2")
    # 一つ目の鎖: ‖Wx‖^2 = Σ_k |y_k|^2 = Σ_k y_k y_k = Σ_k y_k Σ_l W_kl x_l = Σ_k Σ_l y_k W_kl x_l = y^⊤Wx
    l1 = ny**2
    l2 = AA(sum(abs(a)**2 for a in y))
    l3 = sum(y[k] * y[k] for k in range(n))
    l4 = sum(y_builtin[k] * sum(P[k, l] * x[l] for l in range(n)) for k in range(n))   # 左の因子は組み込みの積の y
    l5 = sum(y[k] * P[k, l] * x[l] for k in range(n) for l in range(n))
    l6 = bil(y, P, x)
    l6_builtin = (y.row() * P * x.column())[0, 0]       # y^⊤Wx を組み込みの行列積で（別の経路）
    eq(l1, l2, f"{what}: 鎖1 2→3（def_matrix_norm と (√a)^2 = a）")
    eq(l2, l3, f"{what}: 鎖1 3→4（実数の絶対値の平方）")
    eq(l3, l4, f"{what}: 鎖1 4→5（y = Wx の成分）")
    eq(l4, l5, f"{what}: 鎖1 5→6（分配則）")
    eq(l5, l6, f"{what}: 鎖1 6→7（def_real_bilinear_value）")
    eq(l6, l6_builtin, f"{what}: def_real_bilinear_value と組み込みの行列積")
    # 二つ目の鎖
    m1 = ny**4
    m2 = (ny**2)**2
    m3 = l6**2
    m4 = bil(x, P, x) * bil(y, P, y)
    m5 = (c * nx**2) * bil(y, P, y)
    m6 = (c * nx**2) * (c * ny**2)
    m7 = c**2 * nx**2 * AA(y_builtin.dot_product(y_builtin)).sqrt()**2   # ‖Wx‖ を組み込みの積と内積で作り直す
    eq(m1, m2, f"{what}: 鎖2 1→2")
    eq(m2, m3, f"{what}: 鎖2 2→3（一つ目の鎖）")
    le(m3, m4, f"{what}: 鎖2 3→4（psd_cauchy_schwarz）")
    le(0, c * nx**2, f"{what}: 0 ≤ c‖x‖^2")
    le(m4, m5, f"{what}: 鎖2 4→5（x^⊤Wx ≤ c‖x‖^2 と 0 ≤ y^⊤Wy）")
    le(m5, m6, f"{what}: 鎖2 5→6（y^⊤Wy ≤ c‖y‖^2 と 0 ≤ c‖x‖^2）")
    eq(m6, m7, f"{what}: 鎖2 6→7（y = Wx と乗法の可換則・結合則）")
    # 場合分けと割り算・平方根
    global n_zero_side, n_positive_side
    if ny == 0:
        le(0, c * nx, f"{what}: ‖Wx‖ = 0 のとき 0 ≤ c‖x‖")
        n_zero_side += 1
    else:
        assert ny**2 > 0
        n_positive_side += 1
        eq(m1 / ny**2, ny**2, f"{what}: 左辺 ‖Wx‖^4 を ‖Wx‖^2 で割ると ‖Wx‖^2")
        eq(m7 / ny**2, c**2 * nx**2, f"{what}: 右辺 c^2‖x‖^2‖Wx‖^2 を ‖Wx‖^2 で割ると c^2‖x‖^2")
        le(0, ny, f"{what}: ‖Wx‖ ≥ 0")
        le(ny**2, c**2 * nx**2, f"{what}: ‖Wx‖^2 ≤ c^2‖x‖^2（‖Wx‖^2 > 0 で割る）")
        eq((c * nx)**2, c**2 * nx**2, f"{what}: c^2‖x‖^2 = (c‖x‖)^2（冪の指数法則）")
        le(ny**2, (c * nx)**2, f"{what}: ‖Wx‖^2 ≤ (c‖x‖)^2（nonnegative_real_order_from_squares に渡す形）")
        le(0, c * nx, f"{what}: c‖x‖ ≥ 0")
    le(ny, c * nx, f"{what}: 主張 ‖Wx‖ ≤ c‖x‖")
    # 冪: k = 0 と、帰納法の段の鎖 ‖W^{k+1}x‖ = ‖(W^kW)x‖ = ‖W^k(Wx)‖ ≤ c^k‖Wx‖ ≤ c^k(c‖x‖) = c^{k+1}‖x‖
    eq(power_by_def_exp(P, 0), identity_matrix(QQ, n), f"{what}: W^0 = I（Sage の単位行列）")
    eq(matvec(identity_matrix(QQ, n), x), x, f"{what}: Ix = x")
    eq(norm_exact(matvec(power_by_def_exp(P, 0), x)), nx, f"{what}: ‖W^0x‖ = ‖x‖")
    eq(nx, c**0 * nx, f"{what}: ‖x‖ = c^0‖x‖")
    for k in range(K):
        Wk = power_by_def_exp(P, k)
        Wk1 = power_by_def_exp(P, k + 1)
        eq(Wk1, P**(k + 1), f"{what}: def_exp (1) の冪と Sage の冪（別の実装）")
        eq(Wk1, body_product(Wk, P), f"{what}: W^{k+1} = W^kW（def_exp (1)）")
        p1 = norm_exact(matvec(P**(k + 1), x))
        p2 = norm_exact(matvec(body_product(Wk, P), x))
        p3 = norm_exact(matvec(Wk, matvec(P, x)))
        p4 = c**k * ny
        p5 = c**k * (c * nx)
        p6 = c**(k + 1) * nx
        eq(p1, p2, f"{what}: 冪の鎖 1→2（k = {k}）")
        eq(p2, p3, f"{what}: 冪の鎖 2→3（結合律, k = {k}）")
        le(p3, p4, f"{what}: 冪の鎖 3→4（帰納法の仮定を Wx に, k = {k}）")
        le(0, c**k, f"{what}: 0 ≤ c^k（k = {k}）")
        le(p4, p5, f"{what}: 冪の鎖 4→5（‖Wx‖ ≤ c‖x‖ と c^k ≥ 0, k = {k}）")
        eq(p5, p6, f"{what}: 冪の鎖 5→6（k = {k}）")
        le(p1, p6, f"{what}: 主張 ‖W^{k+1}x‖ ≤ c^{k+1}‖x‖")
