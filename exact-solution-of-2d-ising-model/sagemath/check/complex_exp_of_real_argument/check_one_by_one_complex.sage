# 対象ラベル: complex_exp_of_real_argument
# 1 行 1 列の複素行列の二つの事実を確かめる。
#   [u]_C - [v]_C = [([u]_C - [v]_C)_11]_C = [([u]_C)_11 - ([v]_C)_11]_C = [u - v]_C
#   ‖[w]_C‖ = √(Σ_{i,j=1}^{1} |([w]_C)_ij|^2) = √(|([w]_C)_11|^2) = √(|w|^2) = |w|
# 第一の事実は QQ(i)[u, v] の不定元で（行列の差は成分ごと、ℂ の差は体の差）。
# 第二の事実は具体の w ∈ QQ(i) で、|w| を abs_basic_properties (1) の √(x^2+y^2) として AA で厳密に取る。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/complex_as_real_pairs.sage")

R = PolynomialRing(GAUSSIAN, 'u,v')
u, v = R.gens()
U, V = one_by_one(R, u), one_by_one(R, v)
diff = U - V
chain = [diff, one_by_one(R, entry11(diff)), one_by_one(R, entry11(U) - entry11(V)), one_by_one(R, u - v)]
assert all(c == chain[0] for c in chain)
print("[u]_C - [v]_C = [([u]-[v])_11]_C = [([u])_11 - ([v])_11]_C = [u - v]_C が QQ(i)[u,v] で成り立つ")


def pair_of(w):
    """QQ(i) の元 w = p + q·ii を、definition_of_cc の対 (p, q) へ。"""
    return (QQ(w[0]), QQ(w[1]))


def body_norm_complex(A):
    """def_matrix_norm の ‖A‖ = √(Σ_i Σ_j |a_ij|^2)。|a_ij| は abs_basic_properties (1) の値。"""
    total = sum(cc_abs_aa(pair_of(entry(A, i, j)))^2 for i in range(1, A.nrows() + 1) for j in range(1, A.ncols() + 1))
    r = AA(total).sqrt()
    assert r >= 0 and r^2 == total
    return r


ii = GAUSSIAN.gen()
points = [GAUSSIAN(0), GAUSSIAN(1), -ii, 3 / 7 - 2 * ii, GAUSSIAN(-22) / 5, 10^30 * ii, -1 + ii]
for w in points:
    W = one_by_one(GAUSSIAN, w)
    absw = cc_abs_aa(pair_of(w))
    chain = [body_norm_complex(W), AA(cc_abs_aa(pair_of(entry11(W)))^2).sqrt(), AA(absw^2).sqrt(), absw]
    assert all(c == chain[0] for c in chain), w
    # √(|w|^2) = |w| は、|w| が |w|^2 の非負の平方根であり、それがただ一つだから。もう一つの平方根 -|w| は w ≠ 0 で負。
    assert absw >= 0 and (w == 0 or -absw < 0)
print("7 点の w ∈ QQ(i) で ‖[w]_C‖ = √(Σ|([w]_C)_ij|^2) = √(|([w]_C)_11|^2) = √(|w|^2) = |w| が AA で厳密に成り立つ")
print("RESULT: PASS")
