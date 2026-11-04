# 対象ラベル: trace_of_check_Vprime（Step 5 の 3 行の鎖と、Step 4 の最後の不等号）
#   tr(V̌') = Σ_ε (exp(ǧ(ε)))_C                     (Step 1 の tr(V̌') = Σ_ε (exp(ǧ(ε)))_C の鎖)
#   Σ_ε (exp(ǧ(ε)))_C = (Σ_ε exp(ǧ(ε)))_C          (real_inclusion_preserves_sum_over_binary_words)
#   (Σ_ε exp(ǧ(ε)))_C = (Π_μ 2cosh(γ_μ/2))_C       (Step 2 の Σ_ε exp(ǧ(ε)) = Π_μ 2cosh(γ_μ/2) の鎖)
#   Π_μ 2cosh(γ_μ/2) > 0                            (finite_product_of_positive_reals_is_positive。ℝ の不等号)
# ň_μ・γ_μ は ../eigenvalues_of_check_Vprime/_vprime_settings.sage の ball_settings から取る（check_step3_final_lines.sage と同じ。
# 既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と有理数 γ_μ、M_col = 2, 3, 4）。V̌' := exp(X̌)、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I) は
# Sage の球の行列の exp と def_exp の部分和の球（exp_ball_by_partial_sums）の二つの経路で作り、重なることを確かめてから使う。
# ǧ(ε) は def_finite_sum_of_real_numbers どおり左から足し、{0,1}^{M_col} の上の実数の和は def_sum_over_binary_words_of_real_numbers、
# 複素数の和は def_sum_over_binary_words_of_complex_numbers どおり組む（(·)_C は実数の球を虚部 0 の複素数の球へ移す）。
# 1 行目の左辺は行列の exp のトレース、3 行目の右辺は Sage の cosh で組むので、両端は独立な経路の比較になる。
# 不等号は実数の球（虚部を持たない）の全体が 0 より大きいことで確かめる。左から畳み込んだ各段の部分積も正であることを見る。
# 帰属: γ_μ・exp・cosh は ℝ、V̌'・トレースは ℂ の値を囲む球（ℝ への脱出: 実数の exp・cosh と行列の exp の値。いずれも極限で定まる）。
# 否定コントロール: (a) 2 行目の左辺で ε = (1, …, 1) の項を落とすと右辺と重ならない。(b) 3 行目の右辺を (Π_μ 2sinh(γ_μ/2))_C に
#   壊すと左辺と重ならない。(c) 1 行目の右辺を Σ_ε (exp(2ǧ(ε)))_C に壊すと tr(V̌') と重ならない。
#   (d) M_col が奇数のとき Π_μ 2sinh(−γ_μ/2) は 0 より大きくない（不等号の判定が符号を見分ける）。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")

tol = RBv(10) ** -80
count = 0
neg = 0
ineq = 0


def tr(A):
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


def finite_sum(xs):
    s = xs[0]
    for x in xs[1:]:
        s = s + x
    return s


def finite_prod(ys):
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


def bsum(r, f):
    # def_sum_over_binary_words_of_real_numbers・def_sum_over_binary_words_of_complex_numbers
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


def crad(z):
    return RBv(max(z.real().rad(), z.imag().rad()))


def same(a, b):
    return a.overlaps(b)


for (tag, M, F, ns, gams, to_cb, g1s) in ball_settings([2, 3, 4]):
    N = 2 ^ M
    IdC = identity_matrix(CBv, N)
    nC = [mat_to_cb(A, to_cb) for A in ns]
    X = sum(CBv(gams[mu]) * (nC[mu] - IdC / 2) for mu in range(M))
    V = X.exp()
    assert balls_overlap_mat(V, exp_ball_by_partial_sums(X)) and max_radius(V) < tol, (tag, "V̌' の二つの経路")
    half = RBv(1) / 2
    gcheck = lambda eps: finite_sum([RBv(gams[mu]) * (RBv(eps[mu]) - half) for mu in range(M)])
    prod_r = finite_prod([2 * (RBv(gams[mu]) / 2).cosh() for mu in range(M)])
    lines = [
        tr(V),
        bsum(M, lambda eps: CBv(gcheck(eps).exp())),
        CBv(bsum(M, lambda eps: gcheck(eps).exp())),
        CBv(prod_r),
    ]
    for x, y in zip(lines, lines[1:]):
        assert same(x, y), tag
        assert max(crad(x), crad(y)) < tol, tag
        count += 1
    # Step 4 の最後の不等号（ℝ）。部分積を左から畳み込み、各段が正であることを見る
    p = 2 * (RBv(gams[0]) / 2).cosh()
    assert p > 0, tag
    for mu in range(1, M):
        p = p * (2 * (RBv(gams[mu]) / 2).cosh())
        assert p > 0, tag
    assert p.overlaps(prod_r) and prod_r > 0, tag
    ineq += 1
    ones = tuple([1] * M)
    assert not same(bsum(M, lambda eps: CBv(0) if eps == ones else CBv(gcheck(eps).exp())), lines[2]), tag
    neg += 1
    assert not same(lines[2], CBv(finite_prod([2 * (RBv(gams[mu]) / 2).sinh() for mu in range(M)]))), tag
    neg += 1
    assert not same(bsum(M, lambda eps: CBv((2 * gcheck(eps)).exp())), lines[0]), tag
    neg += 1
    if M % 2 == 1:
        assert not (finite_prod([2 * (-RBv(gams[mu]) / 2).sinh() for mu in range(M)]) > 0), tag
        neg += 1
    print(f"  {tag}: 等号 {count} 個まで、不等号 {ineq} 個まで、否定コントロール {neg} 件まで", flush=True)

print(f"checked {count} equalities (the Step 5 chain), {ineq} inequalities (Step 4 の最後の不等号) and {neg} negative controls")
print("RESULT: PASS")
