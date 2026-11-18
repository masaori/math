# frobenius_inner_product_axioms Step 5 場合 1（‖B‖ = 0 で B = O）の u の鎖
#   u = Σ_{i=1}^{n}Σ_{j=1}^{n} conj(a_ij) b_ij      （u の定義と (0)）
#     = Σ_{i=1}^{n}Σ_{j=1}^{n} conj(a_ij)·0_ℂ       （B = O なので各成分 b_ij = 0_ℂ）
#     = Σ_{i=1}^{n}Σ_{j=1}^{n} 0_ℂ                  （complex_times_zero_is_zero (z → conj(a_ij)) を各項へ）
#     = Σ_{i=1}^{n} 0_ℂ                             （finite_sum_of_complex_zeros (m → n) を各 i の内側の和へ）
#     = 0_ℂ                                         （finite_sum_of_complex_zeros (m → n) を外側の和へ）
# を 1 行ずつ確かめる。和は def_finite_sum_of_complex_numbers のとおり添字 1..n の順に左から足す。
# ℂ の元はガウス有理数体 QQ[i] で厳密に扱う（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
zeroC = K(0)
assert tuple(zeroC.vector()) == (0, 0)                 # 0_ℂ = ι_{ℝ→ℂ}(0) = (0, 0)

def finite_sum(terms):                                 # def_finite_sum_of_complex_numbers: Σ_{j=1}^{1} x_j = x_1、Σ_{j=1}^{m+1} = (Σ_{j=1}^{m}) + x_{m+1}
    assert len(terms) >= 1
    s = terms[0]
    for t in terms[1:]:
        s = s + t
    return s

def inner(A, B):                                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)
    return (A.conjugate_transpose()*B).trace()

def conj(z):
    return z.conjugate()

set_random_seed(1406)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i

count = 0
for n in [1, 2, 3, 4]:
    for trial in range(5):
        A = matrix(K, n, n, lambda r, c: rnd())
        B = matrix(K, n, n, 0)                         # 場合 1 の B = O
        u = inner(A, B)
        rng = range(n)
        row0 = u
        row1 = finite_sum([finite_sum([conj(A[r, c])*B[r, c] for c in rng]) for r in rng])
        row2 = finite_sum([finite_sum([conj(A[r, c])*zeroC for c in rng]) for r in rng])
        row3 = finite_sum([finite_sum([zeroC for c in rng]) for r in rng])
        row4 = finite_sum([zeroC for r in rng])
        row5 = zeroC
        rows = [row0, row1, row2, row3, row4, row5]
        for k in range(1, len(rows)):
            assert rows[k-1] == rows[k], (n, trial, k)
            count += 1
        # 行ごとの根拠をその行の値で確かめる
        assert all(B[r, c] == zeroC for r in rng for c in rng)                     # B = O の各成分は 0_ℂ
        assert all(conj(A[r, c])*zeroC == zeroC for r in rng for c in rng)        # complex_times_zero_is_zero (z → conj(a_ij))
        assert all(finite_sum([zeroC for c in rng]) == zeroC for r in rng)        # finite_sum_of_complex_zeros (m → n) を内側の和へ
        assert finite_sum([zeroC for r in rng]) == zeroC                          # finite_sum_of_complex_zeros (m → n)
        count += 4

# 1 行目（u の定義と (0)）は B = O では両辺が 0_ℂ になるので、0 でない B でも確かめる
for n in [1, 2, 3, 4]:
    for trial in range(5):
        A = matrix(K, n, n, lambda r, c: rnd())
        B = matrix(K, n, n, lambda r, c: rnd())
        rng = range(n)
        assert inner(A, B) == finite_sum([finite_sum([conj(A[r, c])*B[r, c] for c in rng]) for r in rng])
        count += 1

# 否定コントロール（n = 1, 2, 3）: B ≠ O（(n,1) 成分だけが 1）のとき
#   (a) 2 行目（B = O を使って各成分を 0_ℂ に替える段）: 1 行目の値と 2 行目の値（= 0_ℂ）が異なる。
#       B = O を使うのはこの段だけなので、鎖の結論 u = 0_ℂ が B = O を要ることを表す
#   (b) complex_times_zero_is_zero の主張の形（右の因子が 0_ℂ）から外れると結論が偽: ā_{n1}·b_{n1} ≠ 0_ℂ
neg = 0
for n in [1, 2, 3]:
    A = matrix(K, n, n, lambda r, c: rnd() or K(1))   # 効くのは a_{n1} ≠ 0_ℂ（B の 0 でない成分の位置）だけ
    assert A[n - 1, 0] != zeroC
    B = matrix(K, n, n, 0); B[n - 1, 0] = K(1)
    rng = range(n)
    row1 = finite_sum([finite_sum([conj(A[r, c])*B[r, c] for c in rng]) for r in rng])
    row2 = finite_sum([finite_sum([conj(A[r, c])*zeroC for c in rng]) for r in rng])
    assert row1 != row2; neg += 1                                                  # (a)
    assert conj(A[n - 1, 0])*B[n - 1, 0] != zeroC; neg += 1                        # (b)

print("check_cauchy_schwarz_case1_zero_inner_product_chain: %d 判定 PASS（否定コントロール %d 件）" % (count, neg))
