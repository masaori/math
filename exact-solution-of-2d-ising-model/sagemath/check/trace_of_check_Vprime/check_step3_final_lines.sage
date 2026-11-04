# 対象ラベル: trace_of_check_Vprime（Step 3 のトレースの鎖の最後の 3 行）
#   (Π_μ 2cosh(γ_μ/2))_C = (Σ_ε exp(ǧ(ε)))_C      (Step 2 の Σ_ε exp(ǧ(ε)) = Π_μ 2cosh(γ_μ/2) の鎖を右辺から左辺へ)
#   (Σ_ε exp(ǧ(ε)))_C = Σ_ε (exp(ǧ(ε)))_C          (real_inclusion_preserves_sum_over_binary_words を右辺から左辺へ)
#   Σ_ε (exp(ǧ(ε)))_C = tr(V̌')                     (Step 1 の tr(V̌') = Σ_ε (exp(ǧ(ε)))_C の鎖を右辺から左辺へ)
# ň_μ・γ_μ は ../eigenvalues_of_check_Vprime/_vprime_settings.sage の ball_settings から取る（check_claim_statement.sage と同じ。
# 既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と有理数 γ_μ、M_col = 2, 3, 4）。V̌' := exp(X̌)、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I) は
# Sage の球の行列の exp と def_exp の部分和の球（exp_ball_by_partial_sums）の二つの経路で作り、重なることを確かめてから使う。
# ǧ(ε) は def_finite_sum_of_real_numbers どおり左から足し、{0,1}^{M_col} の上の実数の和は def_sum_over_binary_words_of_real_numbers、
# 複素数の和は def_sum_over_binary_words_of_complex_numbers どおり組む（(·)_C は実数の球を虚部 0 の複素数の球へ移す）。
# 1 行目の左辺は Sage の cosh、右辺は exp だけで組むので、比較は独立な経路の比較になる。3 行目の右辺は行列の exp のトレースである。
# 帰属: γ_μ・exp・cosh は ℝ、V̌'・トレースは ℂ の値を囲む球（ℝ への脱出: 実数の exp・cosh と行列の exp の値。いずれも極限で定まる）。
# 否定コントロール: (a) 1 行目の右辺を Σ_ε exp(2ǧ(ε)) に壊すと左辺と重ならない。(b) 3 行目の左辺を Σ_ε (exp(ǧ(ε)/2))_C に壊すと
#   tr(V̌') と重ならない。(c) 21 行目の右辺で ε = (1, …, 1) の項を落とすと左辺と重ならない。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")

tol = RBv(10) ** -80
count = 0
neg = 0


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
    lines = [
        CBv(finite_prod([2 * (RBv(gams[mu]) / 2).cosh() for mu in range(M)])),
        CBv(bsum(M, lambda eps: gcheck(eps).exp())),
        bsum(M, lambda eps: CBv(gcheck(eps).exp())),
        tr(V),
    ]
    for x, y in zip(lines, lines[1:]):
        assert same(x, y), tag
        assert max(crad(x), crad(y)) < tol, tag
        count += 1
    assert not same(lines[0], CBv(bsum(M, lambda eps: (2 * gcheck(eps)).exp()))), tag
    neg += 1
    ones = tuple([1] * M)
    assert not same(bsum(M, lambda eps: CBv(0) if eps == ones else CBv(gcheck(eps).exp())), lines[1]), tag
    neg += 1
    assert not same(bsum(M, lambda eps: CBv((gcheck(eps) / 2).exp())), lines[3]), tag
    neg += 1
    print(f"  {tag}: 等号 {count} 個まで、否定コントロール {neg} 件まで", flush=True)

print(f"checked {count} equalities (the last 3 lines of the Step 3 trace chain) and {neg} negative controls")
print("RESULT: PASS")
