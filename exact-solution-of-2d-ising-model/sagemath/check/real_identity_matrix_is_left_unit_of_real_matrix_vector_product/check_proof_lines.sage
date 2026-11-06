# 対象ラベル: real_identity_matrix_is_left_unit_of_real_matrix_vector_product
# 証明の三つの鎖を一行ずつ確かめる。
#   j ≠ i: (r_j)_ℂ = (I_ijx_j)_ℂ = (0·x_j)_ℂ = (0)_ℂ = 0_ℂ
#   j = i: r_i = I_iix_i = 1·x_i = x_i
#   ((Ix)_i)_ℂ = (Σ_j I_ijx_j)_ℂ = (Σ_j r_j)_ℂ = Σ_j (r_j)_ℂ = (r_i)_ℂ = (x_i)_ℂ、単射性で (Ix)_i = x_i、主張 Ix = x
# 帰属: ℝ の元は AA、ℂ の元は QQbar（r ↦ r_ℂ は AA → QQbar）。浮動小数点は使わない。


def rsum(terms):
    """def_finite_sum_of_real_numbers: 1 項目から順に左から足す（項は 1 つ以上）。"""
    terms = list(terms)
    assert len(terms) >= 1
    s = terms[0]
    for t in terms[1:]:
        s = s + t
    return s


csum = rsum   # def_finite_sum_of_complex_numbers も同じく左から足す


def iota(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ。"""
    return QQbar(r)


def real_identity(n):
    """def_real_identity_matrix: (I)_st := 1 (s = t)、0 (s ≠ t)。"""
    return matrix(AA, n, n, lambda s, t: AA(1) if s == t else AA(0))


def matvec(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j。"""
    return vector(AA, [rsum(P[i, j] * x[j] for j in range(P.ncols())) for i in range(P.nrows())])


set_random_seed(20261106)
cands = [AA(-3), AA(-1)/2, AA(0), AA(2)/3, AA(5), AA(2).sqrt(), -AA(3).sqrt()]
count = 0
for trial in range(30):
    n = randint(1, 6)
    I = real_identity(n)
    x = vector(AA, [cands[randint(0, len(cands) - 1)] for _ in range(n)])
    Ix = matvec(I, x)
    for i in range(n):
        r = [I[i, j] * x[j] for j in range(n)]
        for j in range(n):
            if j != i:
                assert iota(r[j]) == iota(I[i, j] * x[j]) == iota(0 * x[j]) == iota(AA(0)) == QQbar(0), (trial, i, j)
        assert r[i] == I[i, i] * x[i] == 1 * x[i] == x[i], (trial, i)
        c1 = iota(Ix[i])
        c2 = iota(rsum(I[i, j] * x[j] for j in range(n)))
        c3 = iota(rsum(r))
        c4 = csum(iota(rj) for rj in r)
        c5 = iota(r[i])
        c6 = iota(x[i])
        assert c1 == c2 == c3 == c4 == c5 == c6, (trial, i)
        assert Ix[i] == x[i]                                  # inclusion_rr_to_cc_is_injective
        count += 1
    assert Ix == x                                            # 主張 Ix = x
    assert identity_matrix(AA, n) * x == x                    # Sage の組み込みの単位行列と積（別の実装）とも比べる
# 否定コントロール: 対角成分を 2 にした行列では Px ≠ x になる
P = matrix(AA, 2, 2, [2, 0, 0, 1]); x = vector(AA, [1, 1])
assert matvec(P, x) != x
print(f"{count} 個の成分で三つの鎖と (Ix)_i = x_i を確かめた（n = 1 を含む）。否定コントロール 1 件")
print("RESULT: PASS")
