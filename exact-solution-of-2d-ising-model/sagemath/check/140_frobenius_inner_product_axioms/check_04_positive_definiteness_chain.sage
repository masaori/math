# frobenius_inner_product_axioms Step 4（(3) の ⟨A,A⟩ = (‖A‖²)_ℂ）の 6 等号の鎖を 1 行ずつ確かめる。
# ℂ の元はガウス有理数体 QQ[i]、ℝ の元は QQ、‖A‖ = √(Σ_iΣ_j|a_ij|²) は代数的実数体 AA で厳密に扱う（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
def conj(z):                           # def_complex_conjugate: (x, y) ↦ (x, -y)
    x, y = z.vector()
    return K(x) - K(y)*i
def abs2(z):                           # |z|² = x² + y²（abs_basic_properties (2)）。値は ℝ の元（QQ）
    x, y = z.vector()
    return QQ(x)**2 + QQ(y)**2
def iota(r):                           # inclusion_rr_to_cc: r ↦ (r, 0)
    z = K(r)
    assert tuple(z.vector()) == (QQ(r), 0)
    return z
def inner(A, B):                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)
    return (A.conjugate_transpose()*B).trace()

set_random_seed(1404)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i
count = 0
neg_count = 0
for n in [1, 2, 3]:
    for trial in range(6):
        A = matrix(K, n, n, lambda r, c: rnd())
        R = range(n)
        s = sum(abs2(A[r, c]) for r in R for c in R)               # Σ_iΣ_j |a_ij|² ∈ ℝ_{≥0}
        # def_matrix_norm の ‖A‖ を、|a_ij| を QQbar の絶対値（abs2 とは別の経路）で取って作る
        normA = AA(sum(QQbar(K.embeddings(QQbar)[0](A[r, c])).abs()**2 for r in R for c in R)).sqrt()
        assert normA >= 0 and normA**2 == AA(s)                     # y ≥ 0 かつ y² = x
        assert s >= 0 and normA == AA(s).sqrt()                     # 根号の中は非負で、‖A‖ = √(Σ_iΣ_j|a_ij|²)（def_matrix_norm）
        chain = [inner(A, A),
                 sum(sum(conj(A[r, c])*A[r, c] for c in R) for r in R),          # (0)
                 sum(sum(iota(abs2(A[r, c])) for c in R) for r in R),            # Step 0 の z̄z = (|z|²)_ℂ
                 sum(iota(sum(abs2(A[r, c]) for c in R)) for r in R),            # 内側の和へ real_inclusion_preserves_finite_sum
                 iota(sum(sum(abs2(A[r, c]) for c in R) for r in R)),            # 外側の和へ real_inclusion_preserves_finite_sum
                 iota(QQ(AA(s).sqrt()**2)),                                      # definition_of_sqrt_r_positive の y² = x を右辺から左辺へ
                 iota(QQ(normA**2))]                                             # def_matrix_norm を右辺から左辺へ
        for k in range(1, len(chain)):
            assert chain[k] == chain[k-1], (n, trial, k)
            count += 1
        # 否定コントロール: 共役を落とした Σ a_ij a_ij は、成分に虚部があれば一般に (‖A‖²)_ℂ と異なる
        wrong = sum(A[r, c]*A[r, c] for r in R for c in R)
        if wrong != chain[-1]:
            neg_count += 1
assert neg_count > 0
print("判定した等号の数:", count, "否定コントロールの数:", neg_count)
print("ALL PASS")
