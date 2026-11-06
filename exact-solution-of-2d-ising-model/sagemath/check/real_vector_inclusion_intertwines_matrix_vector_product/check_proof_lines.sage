# 対象ラベル: real_vector_inclusion_intertwines_matrix_vector_product
# 証明の 7 行の鎖 (ι^m(B_ℝx))_i = ((B_ℝx)_i)_ℂ = (Σ_j (B_ℝ)_ij x_j)_ℂ = Σ_j ((B_ℝ)_ij x_j)_ℂ
#   = Σ_j ((B_ℝ)_ij)_ℂ (x_j)_ℂ = Σ_j B_ij (x_j)_ℂ = Σ_j B_ij (ι^n(x))_j = (B ι^n(x))_i と
#   主張 ι^m(B_ℝx) = B ι^n(x) を、ランダムな大きさと実数の成分で厳密に確かめる。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。r_ℂ := (r, 0) は QQbar(r)。浮動小数点は使わない。
# 和は def_finite_sum_of_real_numbers・def_finite_sum_of_complex_numbers のとおり添字の小さい順に左から足す。


def lsum(terms):
    """有限和: 1 項目から順に左から足す（項は 1 つ以上）。"""
    terms = list(terms)
    assert len(terms) >= 1
    s = terms[0]
    for t in terms[1:]:
        s = s + t
    return s


def incl(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ = (r, 0)。"""
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


def iota(x):
    """def_real_vector_inclusion: (ι^n(x))_i := (x_i)_ℂ。"""
    return vector(QQbar, [incl(xi) for xi in x])


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の B の (B_ℝ)_pq は B_pq = r_ℂ を満たす r。"""
    for z in B.list():
        assert z.imag() == 0
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


def real_matvec(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j。"""
    return vector(AA, [lsum(P[i, j] * x[j] for j in range(P.ncols())) for i in range(P.nrows())])


def cmatvec(A, a):
    """mat_mult の行列と数ベクトルの積: (Aa)_i := Σ_j A_ij a_j。"""
    return vector(QQbar, [lsum(A[i, j] * a[j] for j in range(A.ncols())) for i in range(A.nrows())])


set_random_seed(20261106)
cands = [AA(-3), AA(-1)/2, AA(0), AA(2)/3, AA(5), AA(2).sqrt(), -AA(3).sqrt()]
pick = lambda: cands[randint(0, len(cands) - 1)]
count = 0
for trial in range(30):
    m, n = randint(1, 4), randint(1, 4)
    B = matrix(QQbar, m, n, lambda p, q: incl(pick()))         # 成分がすべて実数の複素行列
    x = vector(AA, [pick() for _ in range(n)])
    BR = rho(B)
    for p in range(m):
        for q in range(n):
            assert incl(BR[p, q]) == B[p, q]                    # ((B_ℝ)_pq)_ℂ = B_pq
    BRx = real_matvec(BR, x)
    lhs, rhs = iota(BRx), cmatvec(B, iota(x))
    for i in range(m):
        l1 = lhs[i]
        l2 = incl(BRx[i])
        l3 = incl(lsum(BR[i, j] * x[j] for j in range(n)))
        l4 = lsum(incl(BR[i, j] * x[j]) for j in range(n))
        l5 = lsum(incl(BR[i, j]) * incl(x[j]) for j in range(n))
        l6 = lsum(B[i, j] * incl(x[j]) for j in range(n))
        l7 = lsum(B[i, j] * iota(x)[j] for j in range(n))
        l8 = rhs[i]
        assert l1 == l2 == l3 == l4 == l5 == l6 == l7 == l8, (trial, i)
        count += 1
    assert lhs == rhs                                           # 主張
    assert lhs == B * iota(x)                                   # Sage の組み込みの積（別の実装）とも比べる
# 否定コントロール: 転置した行列を掛けると一般に一致しない
B = matrix(QQbar, 2, 2, [1, 2, 0, 1]); x = vector(AA, [1, 0])
assert iota(real_matvec(rho(B), x)) != cmatvec(B.transpose(), iota(x))
print(f"{count} 個の成分で 7 行の鎖と (ι^m(B_ℝx))_i = (Bι^n(x))_i を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
