# 対象ラベル: epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors
# def_epsilon_real の ε_ℝ := ϱ(ε) を ε の成分から作り（((ε_ℝ)_kl)_ℂ = ε_kl を全成分で確かめる）、
# 証明の (⇒) の 2 行の鎖 ει(x) = ι(ε_ℝx) = ι(x) と、(⇐) の 2 行の鎖 ι(ε_ℝx) = ει(x) = ι(x) と単射性による結び、
# 主張 ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)} を、M_col ∈ {1, 2, 3} で候補の値から作った実数のベクトルについて厳密に確かめる。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。r_ℂ := (r, 0) は QQbar(r)。浮動小数点は使わない。
import itertools

sigma_x = matrix(QQbar, [[0, 1], [1, 0]])


def incl(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ = (r, 0)。"""
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


def iota(x):
    """def_real_vector_inclusion: (ι^n(x))_i := (x_i)_ℂ。"""
    return vector(QQbar, [incl(xi) for xi in x])


def epsilon(M):
    """epsilon_square_and_eigenvalues の証明の表示 ε = σ^x ⊠ ⋯ ⊠ σ^x（M 個の因子、先頭因子が最上位）。"""
    result = matrix(QQbar, [[1]])
    for _ in range(M):
        result = result.tensor_product(sigma_x)
    return result


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ（成分 w_pq(B) ∈ ℝ）。"""
    rows = []
    for p in range(B.nrows()):
        row = []
        for q in range(B.ncols()):
            z = B[p, q]
            assert z.imag() == 0                                  # epsilon_is_real_symmetric の成分の実性
            row.append(AA(z.real()))
        rows.append(row)
    return matrix(AA, rows)


def rmatvec(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j（左から足す）。"""
    out = []
    for i in range(P.nrows()):
        s = AA(0)
        for j in range(P.ncols()):
            s = s + P[i, j] * x[j]
        out.append(s)
    return vector(AA, out)


def cmatvec(A, a):
    """mat_mult の行列と数ベクトルの積 (Aa)_i := Σ_j A_ij a_j（左から足す）。"""
    out = []
    for i in range(A.nrows()):
        s = QQbar(0)
        for j in range(A.ncols()):
            s = s + A[i, j] * a[j]
        out.append(s)
    return vector(QQbar, out)


cands = [AA(-1), AA(0), AA(2).sqrt(), AA(8).sqrt() / 2]          # √8/2 は √2 と別の式で書いた同じ実数
count_fixed = 0
count_not_fixed = 0
for M in range(1, 4):
    d = 2 ** M
    eps = epsilon(M)
    eps_R = rho(eps)                                              # def_epsilon_real
    for k in range(d):
        for l in range(d):
            assert incl(eps_R[k, l]) == eps[k, l]                 # ((ε_ℝ)_kl)_ℂ = ε_kl
    if M <= 2:
        vecs = [vector(AA, v) for v in itertools.product(cands, repeat=d)]
    else:
        vecs = [vector(AA, v) for v in itertools.product([AA(-1), AA(0), AA(2).sqrt()], repeat=d)
                if sum(1 for t in v if t != 0) <= 3]
    for x in vecs:
        # 準備の交換 ει(x) = ι(ε_ℝx) は仮定に依らないので、すべてのベクトルで確かめる
        assert cmatvec(eps, iota(x)) == iota(rmatvec(eps_R, x)), (M, x)
        lhs = rmatvec(eps_R, x) == x                              # ε_ℝx = x
        rhs = cmatvec(eps, iota(x)) == iota(x)                    # ι(x) ∈ 𝓕^{(+)}（def_even_eigenvectors_of_epsilon）
        if lhs:
            # (⇒) の鎖
            l1 = cmatvec(eps, iota(x))
            l2 = iota(rmatvec(eps_R, x))
            l3 = iota(x)
            assert l1 == l2 == l3, (M, x)
            count_fixed += 1
        if rhs:
            # (⇐) の鎖と単射性
            m1 = iota(rmatvec(eps_R, x))
            m2 = cmatvec(eps, iota(x))
            m3 = iota(x)
            assert m1 == m2 == m3, (M, x)
            assert rmatvec(eps_R, x) == x                         # real_vector_inclusion_is_injective の結論
        else:
            count_not_fixed += 1
        assert lhs == rhs, (M, x)                                 # 主張
    # 否定コントロール: ε の代わりに単位行列でない置換を誤って使うと同値が崩れる例がある
    if M >= 2:
        wrong = matrix(QQbar, d, d, lambda r, c: 1 if c == (r + 1) % d else 0)
        x = vector(AA, [AA(1)] + [AA(0)] * (d - 1))
        x[d - 1] = AA(1)                                          # x_1 = x_d = 1（ε で固定される）
        assert rmatvec(eps_R, x) == x
        assert cmatvec(wrong, iota(x)) != iota(x)
assert count_fixed > 0 and count_not_fixed > 0
print(f"ε_ℝx = x を満たす {count_fixed} 個と満たさない {count_not_fixed} 個のベクトルで、2 本の鎖と同値を確かめた")
print("RESULT: PASS")
