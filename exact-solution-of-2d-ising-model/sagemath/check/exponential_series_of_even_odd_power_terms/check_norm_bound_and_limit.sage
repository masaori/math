# 対象ラベル: exponential_series_of_even_odd_power_terms
# 中間目標「実数の評価」（各 5 行）・「ノルムの評価」（8 行）・ε の鎖（3 行）と主張そのものを、具体の点で確かめる。
# 等号の行のうち exp の性質を使わない「実数の四則」の行は、exp(x)・exp(-x) の値を QQ 上の独立な不定元 ex・emx に置いて厳密に確かめる。
# 不等号の行と主張は、実数の exp の値が QQ に収まらないので ℝ へ脱出し、本文の exp を囲むボール（hyperbolic_by_definition.sage の
# exp_ball。本文の部分和に尾の評価を半径として足したもの。Arb の exp は使わない）で確かめる。S_N・α_N・β_N・E_N は QQ・QQ(i) で厳密に作り、
# ノルム・絶対値を取るときだけボールへ移す（abs_basic_properties (1) の √(x^2+y^2)、def_matrix_norm の成分の平方和の平方根）。
# 等号の行は、両辺のボールが重なることを確かめる。不等号 l ≤ r の行は le_ball で確かめる。
load("_prelude.sage")

CBF_ = ComplexBallField(PREC)
ii = GAUSSIAN.gen()


def cb(z):
    a, b = GAUSSIAN(z).list()
    return CBF_(RBF512(a), RBF512(b))


def cabs(zb):
    """abs_basic_properties (1): |(a,b)| = √(a^2+b^2)。平方和は非負なので、ボールの負の部分を落として平方根を取る（sqrtpos）。"""
    return (zb.real()^2 + zb.imag()^2).sqrtpos()


def mnorm(Mb):
    """def_matrix_norm: 成分の絶対値の平方和の平方根。"""
    return sum(cabs(Mb[p, q])^2 for p in range(Mb.nrows()) for q in range(Mb.ncols())).sqrtpos()


def to_cbm(M):
    return matrix(CBF_, M.nrows(), M.ncols(), lambda p, q: cb(M[p, q]))


def eq_ball(l, r, label):
    report(l.overlaps(r), label + "（ボールが重なる）")


def le_ball(l, r, label):
    """l ≤ r の行。l の上端が r の下端以下（狭義に区別できる場合）、または両辺のボールが重なる（等号が成り立つ場合。
    三角不等式は二つの数の符号が逆なら等号になる）。重なるだけの場合は、ボールの半径の範囲で矛盾しないことしか言えない。"""
    strict = l.upper() <= r.lower()
    report(strict or l.overlaps(r), label + ("（左辺の上端 ≤ 右辺の下端）" if strict else "（等号の場合: ボールが重なる）"))


def E(y, N):
    return sum(QQ(y)^n / factorial(n) for n in range(N + 1))


# 実数の四則の行（exp の値を不定元に置いて厳密に）
Q = PolynomialRing(QQ, ['EN', 'ENm', 'ex', 'emx'])
EN, ENm, ex, emx = Q.gens()
report((EN + ENm) / 2 - (ex + emx) / 2 == ((EN - ex) + (ENm - emx)) / 2, "実数の評価 α: 「実数の四則」の行")
report((EN - ENm) / 2 - (ex - emx) / 2 == ((EN - ex) - (ENm - emx)) / 2, "実数の評価 β: 「実数の四則」の行")
report((EN + ENm) / 2 - (ex + emx) / 2 != ((EN - ex) - (ENm - emx)) / 2, "対照: α の行の符号を β のものにすると一致しない")

POINTS = [
    (QQ(1) / 3, matrix(GAUSSIAN, [[1, ii], [2, -1]]), matrix(GAUSSIAN, [[0, 1], [1 - ii, 3]]), 2 + ii),
    (QQ(-3) / 2, matrix(GAUSSIAN, [[ii, 0], [0, -ii]]), matrix(GAUSSIAN, [[1, 2], [3, 4]]), -ii),
    (QQ(2), matrix(GAUSSIAN, [[1, 1, 0], [0, 1, ii], [1, 0, 0]]), matrix(GAUSSIAN, [[0, 0, 1], [ii, 0, 0], [0, 2, 0]]), QQ(1) / 2 - ii),
]

for (x, A, B, c) in POINTS:
    d = A.nrows()
    tag0 = f"x={x} d={d} c={c}"
    exb, emxb = exp_ball(x), exp_ball(-x)
    chb, shb = cosh_ball(x), sinh_ball(x)
    T = lambda n: (x^n) * A if n % 2 == 0 else (c * x^n) * B
    Lb = matrix(CBF_, d, d, lambda p, q: CBF_(chb) * cb(A[p, q]) + cb(c) * CBF_(shb) * cb(B[p, q]))
    kappa = mnorm(to_cbm(A)) + cabs(cb(c)) * mnorm(to_cbm(B))
    prev_bound = None
    for N in [0, 1, 2, 5, 10, 20, 40]:  # N ≥ 80 では差がボールの半径を下回り、不等号の行が確かめられないので含めない
        tag = f"{tag0} N={N}"
        S = body_finite_sum([body_scalar(QQ(1) / factorial(n), T(n)) for n in range(N + 1)])
        alpha = (E(x, N) + E(-x, N)) / 2
        beta = (E(x, N) - E(-x, N)) / 2
        u = (RBF512(E(x, N)) - exb).abs()
        v = (RBF512(E(-x, N)) - emxb).abs()
        # 実数の評価（α・β）: 定義の行と def_cosh_sinh の行をボールで、最後の不等号
        for (name, val, hyp, sgn) in [("α", alpha, chb, 1), ("β", beta, shb, -1)]:
            report(val == (E(x, N) + sgn * E(-x, N)) / 2, f"{tag} 実数の評価 {name}: 定義の行（QQ で厳密）")
            l0 = (RBF512(val) - hyp).abs()
            l0b = (RBF512((E(x, N) + sgn * E(-x, N)) / 2) - hyp).abs()
            l1 = (RBF512((E(x, N) + sgn * E(-x, N)) / 2) - (exb + sgn * emxb) / 2).abs()
            l2 = (((RBF512(E(x, N)) - exb) + sgn * (RBF512(E(-x, N)) - emxb)) / 2).abs()
            l3 = ((RBF512(E(x, N)) - exb) + sgn * (RBF512(E(-x, N)) - emxb)).abs() / 2
            eq_ball(l0, l0b, f"{tag} 実数の評価 {name}: 定義の行")
            eq_ball(l0b, l1, f"{tag} 実数の評価 {name}: def_cosh_sinh の行")
            eq_ball(l1, l2, f"{tag} 実数の評価 {name}: 実数の四則の行")
            eq_ball(l2, l3, f"{tag} 実数の評価 {name}: 絶対値と 2 で割ることの交換の行")
            le_ball(l3, (u + v) / 2, f"{tag} 実数の評価 {name}: 三角不等式の行")
        # ノルムの評価
        Db = to_cbm(S) - Lb
        n0 = mnorm(Db)
        X1 = to_cbm(body_scalar(1, A)) * CBF_(RBF512(alpha) - chb)
        X2 = to_cbm(B) * (cb(c) * CBF_(RBF512(beta) - shb))
        n1 = mnorm(X1 + X2)
        n2 = mnorm(X1) + mnorm(X2)
        n3 = cabs(CBF_(RBF512(alpha) - chb)) * mnorm(to_cbm(A)) + cabs(cb(c) * CBF_(RBF512(beta) - shb)) * mnorm(to_cbm(B))
        n4 = cabs(CBF_(RBF512(alpha) - chb)) * mnorm(to_cbm(A)) + (cabs(cb(c)) * cabs(CBF_(RBF512(beta) - shb))) * mnorm(to_cbm(B))
        n5 = (RBF512(alpha) - chb).abs() * mnorm(to_cbm(A)) + (cabs(cb(c)) * (RBF512(beta) - shb).abs()) * mnorm(to_cbm(B))
        n6 = (u + v) / 2 * mnorm(to_cbm(A)) + (cabs(cb(c)) * (u + v) / 2) * mnorm(to_cbm(B))
        n6b = (u + v) / 2 * (mnorm(to_cbm(A)) + cabs(cb(c)) * mnorm(to_cbm(B)))
        n7 = (u + v) / 2 * kappa
        eq_ball(n0, n1, f"{tag} ノルム: 差の中間目標の行")
        le_ball(n1, n2, f"{tag} ノルム: 三角不等式 (3) の行")
        eq_ball(n2, n3, f"{tag} ノルム: 斉次性 (2) の行")
        eq_ball(n3, n4, f"{tag} ノルム: abs_basic_properties (4) の行")
        eq_ball(n4, n5, f"{tag} ノルム: abs_basic_properties (6) の行")
        le_ball(n5, n6, f"{tag} ノルム: 実数の評価を代入する行")
        eq_ball(n6, n6b, f"{tag} ノルム: 実数の四則の行")
        eq_ball(n6b, n7, f"{tag} ノルム: κ の定義の行")
        le_ball(n0, n7, f"{tag}: ‖S_N - L‖ ≤ ((u_N+v_N)/2) κ")
        if prev_bound is not None:
            report(n7.upper() <= prev_bound, f"{tag}: 評価 ((u_N+v_N)/2) κ の上端は N とともに減る")
        prev_bound = n7.upper()
    # ε の鎖: ε = 10^{-40} に対し u_N, v_N < ε/(κ+1) となる N を取り、((u+v)/2)C ≤ (ε/(κ+1))C < ε
    eps = RBF512(10)^(-40)
    N = next(N for N in range(0, 400) if ((RBF512(E(x, N)) - exb).abs() < eps / (kappa + 1)) and ((RBF512(E(-x, N)) - emxb).abs() < eps / (kappa + 1)))
    u = (RBF512(E(x, N)) - exb).abs()
    v = (RBF512(E(-x, N)) - emxb).abs()
    le_ball((u + v) / 2 * kappa, eps / (kappa + 1) * kappa, f"{tag0}: ε = 1e-40 の鎖の一つ目の不等号（N = {N}）")
    report((eps / (kappa + 1) * kappa) < eps, f"{tag0}: ε = 1e-40 の鎖の二つ目の不等号")
    # 主張: S_150 と L の差のノルムが 1e-60 未満。対照: c の符号を逆にした L' とは離れる
    S = body_finite_sum([body_scalar(QQ(1) / factorial(n), T(n)) for n in range(151)])
    report(mnorm(to_cbm(S) - Lb) < RBF512(10)^(-60), f"{tag0}: 主張 ‖S_150 - L‖ < 1e-60")
    Lw = matrix(CBF_, d, d, lambda p, q: CBF_(chb) * cb(A[p, q]) - cb(c) * CBF_(shb) * cb(B[p, q]))
    report(mnorm(to_cbm(S) - Lw) > RBF512(10)^(-3), f"{tag0}: 対照 c の符号を逆にした式とは一致しない")
print("RESULT: PASS")
