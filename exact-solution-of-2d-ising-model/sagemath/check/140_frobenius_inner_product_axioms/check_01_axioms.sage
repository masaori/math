# <def_frobenius_inner_product> + <frobenius_inner_product_axioms>
# 主張の (0)〜(5) と Cauchy--Schwarz の等号（B = cA）を、乱数の行列で確かめる。
# ℂ の元はガウス有理数体 QQ[i]、ℝ の元は QQ と AA（成分の絶対値の 2 乗の和は QQ、絶対値 |z| とノルム ‖A‖ = √(Σ_iΣ_j|a_ij|²) は
# 代数的実数体 AA の平方根）で厳密に扱う（浮動小数点は使わない。(4)(5) の不等号と等号は AA の中で厳密に判定する）。
K.<i> = QuadraticField(-1)
def conj(z):                           # def_complex_conjugate: (x, y) ↦ (x, -y)
    x, y = z.vector()
    return K(x) - K(y)*i
def abs2(z):                           # |z|² = x² + y²。値は ℝ の元（QQ）
    x, y = z.vector()
    return QQ(x)**2 + QQ(y)**2
def absAA(z):                          # def_abs_arg の絶対値 |z| = √(x² + y²) ∈ AA
    return AA(abs2(z)).sqrt()
def iota(r):                           # inclusion_rr_to_cc: r ↦ (r, 0)
    z = K(r)
    assert tuple(z.vector()) == (QQ(r), 0)
    return z
def inner(A, B):                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)
    return (A.conjugate_transpose()*B).trace()
def norm2(A):                          # Σ_iΣ_j |a_ij|² ∈ QQ_{≥0}
    return sum(abs2(A[r, c]) for r in range(A.nrows()) for c in range(A.ncols()))
def norm(A):                           # def_matrix_norm: ‖A‖ = √(Σ_iΣ_j |a_ij|²) ∈ AA
    return AA(norm2(A)).sqrt()

set_random_seed(109)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i

count = 0
def check(cond, what):
    global count
    assert cond, what
    count += 1

neg_count = 0
strict_count = 0
for n in [1, 2, 3, 5]:
    R = range(n)
    for trial in range(20):
        A = matrix(K, n, n, lambda r, c: rnd())
        B = matrix(K, n, n, lambda r, c: rnd())
        C = matrix(K, n, n, lambda r, c: rnd())
        lam = rnd()
        tag = (n, trial)
        # (0) 成分表示: tr(A^*B) = Σ_iΣ_j ā_ij b_ij
        check(inner(A, B) == sum(sum(conj(A[r, c])*B[r, c] for c in R) for r in R), ("(0)", tag))
        # (1) 共役対称性
        check(inner(B, A) == conj(inner(A, B)), ("(1)", tag))
        # (2) 第 2 変数の線型性・第 1 変数の共役線型性
        check(inner(A, B + C) == inner(A, B) + inner(A, C), ("(2) 第2変数の加法性", tag))
        check(inner(A, lam*B) == lam*inner(A, B), ("(2) 第2変数の斉次性", tag))
        check(inner(A + B, C) == inner(A, C) + inner(B, C), ("(2) 第1変数の加法性", tag))
        check(inner(lam*A, B) == conj(lam)*inner(A, B), ("(2) 第1変数の共役斉次性", tag))
        # (3) 正定値性: ⟨A,A⟩ = (Σ|a_ij|²)_ℂ = (‖A‖²)_ℂ、非負実数の像、A ≠ O なら ≠ 0_ℂ
        check(inner(A, A) == iota(norm2(A)), ("(3) 成分の和", tag))
        check(norm2(A) >= 0, ("(3) 非負", tag))
        check(inner(A, A) == iota(QQ(norm(A)**2)), ("(3) ノルムの2乗", tag))
        check((inner(A, A) == 0) == (A == 0), ("(3) ⟨A,A⟩ = 0_ℂ ⟺ A = O", tag))
        # (4) Cauchy--Schwarz: |⟨A,B⟩| ≤ ‖A‖‖B‖（AA の中の厳密な比較）
        check(absAA(inner(A, B)) <= norm(A)*norm(B), ("(4)", tag))
        # (5) 三角不等式: ‖A+B‖ ≤ ‖A‖ + ‖B‖
        check(norm(A + B) <= norm(A) + norm(B), ("(5)", tag))
        # 否定コントロール: 共役を落とした和 Σ a_ij b_ij は (1) の共役対称性を満たさない標本がある
        wrong = lambda X, Y: sum(X[r, c]*Y[r, c] for r in R for c in R)
        if wrong(B, A) != conj(wrong(A, B)):
            neg_count += 1
    # (3) の A = O の側
    O = matrix(K, n, n, 0)
    check(inner(O, O) == 0 and norm(O) == 0, ("<O,O> = 0", n))
    # Cauchy--Schwarz の等号（B = cA）
    A = matrix(K, n, n, lambda r, c: rnd())
    c = K(17/10) - K(2/5)*i
    check(absAA(inner(A, c*A)) == norm(A)*norm(c*A), ("B = cA で等号", n))
    # 等号の判定が自明でないことの確認: 乱数の B で (4) が狭義の不等号になる標本がある
    B = matrix(K, n, n, lambda r, c: rnd())
    if absAA(inner(A, B)) < norm(A)*norm(B):
        strict_count += 1
assert neg_count > 0 and strict_count > 0
print("判定の数:", count, "否定コントロールの数:", neg_count, "狭義の不等号の標本の数:", strict_count)
print("ALL PASS")
print("RESULT: PASS")
