# 対象ラベル: end_agrees_with_matrix_vector_product
# 主張の式変形（左辺と 11 本の等号）と主張そのものを確かめる。
#   ((end A)(f))_{ν(L)}
#   = ((end(Σ A_{ν(I),ν(J)} E_{I,J}))(f))_{ν(L)}
#   = ((Σ A_{ν(I),ν(J)} Θ_{I,J})(f))_{ν(L)}
#   = (Σ A_{ν(I),ν(J)} Θ_{I,J}(f))_{ν(L)}
#   = (Σ A_{ν(I),ν(J)} Θ_{I,J}(Σ_K f_{ν(K)} f_K))_{ν(L)}
#   = (Σ A_{ν(I),ν(J)} Σ_K f_{ν(K)} Θ_{I,J}(f_K))_{ν(L)}
#   = (Σ A_{ν(I),ν(J)} Σ_K f_{ν(K)} δ_{J,K} f_I)_{ν(L)}
#   = (Σ A_{ν(I),ν(J)} f_{ν(J)} f_I)_{ν(L)}
#   = Σ A_{ν(I),ν(J)} f_{ν(J)} (f_I)_{ν(L)}
#   = Σ A_{ν(I),ν(J)} f_{ν(J)} δ_{I,L}
#   = Σ_J A_{ν(L),ν(J)} f_{ν(J)}
#   = Σ_{l=1}^{2^M} A_{ν(L),l} f_l
# 本文の数ベクトル v をここでは f と書く。左辺の end(A)(f) は _shared/end_by_definition.sage が定義の文言どおりに作る
# （基底の座標は基底を並べた行列の逆行列から Sage の線型代数で求める。end の値が行列と数ベクトルの積に等しいという、
# 検算対象の主張は使わない）。右辺は本文 mat_mult の和の式と Sage の A*f。
# 帰属: 成分は QQ(i) 上の多項式環の独立な不定元。M = 1, 2, 3。全て厳密。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/end_by_definition.sage")


def delta(a, b):
    return 1 if a == b else 0


for M in [1, 2, 3]:
    n = 2^M
    idx = multi_indices(M)
    R = PolynomialRing(GAUSSIAN, [f"a{p}_{q}" for p in range(1, n + 1) for q in range(1, n + 1)] + [f"x{p}" for p in range(1, n + 1)])
    gens = R.gens()
    A = matrix(R, n, n, gens[:n * n])
    f = vector(R, gens[n * n:])
    E = EndByDefinition(M)
    fb = f_basis(R, M)
    EbR = E_basis(R, M)
    zero = vector(R, [0] * n)
    a = lambda I, J: A[nu(I) - 1, nu(J) - 1]
    expansion_A = sum(a(I, J) * EbR[(I, J)] for I in idx for J in idx)
    expansion_f = sum(f[nu(K) - 1] * fb[K] for K in idx)

    v1 = E.apply(A, f)
    v2 = E.apply(expansion_A, f)
    # 第三行: 線型写像 Σ A Θ_{I,J} を基底 f_K 上の値で作り、f の座標で線型に広げる
    combo_on_basis = {K: sum((a(I, J) * E.theta(I, J, fb[K]) for I in idx for J in idx), zero) for K in idx}
    dK = E.coords_of_vector(f)
    v3 = sum((dK[K] * combo_on_basis[K] for K in idx), zero)
    v4 = sum((a(I, J) * E.theta(I, J, f) for I in idx for J in idx), zero)
    v5 = sum((a(I, J) * E.theta(I, J, expansion_f) for I in idx for J in idx), zero)
    theta_on_basis = {(I, J, K): E.theta(I, J, fb[K]) for I in idx for J in idx for K in idx}
    v6 = sum((a(I, J) * sum((f[nu(K) - 1] * theta_on_basis[(I, J, K)] for K in idx), zero) for I in idx for J in idx), zero)
    v7 = sum((a(I, J) * sum((f[nu(K) - 1] * delta(J, K) * fb[I] for K in idx), zero) for I in idx for J in idx), zero)
    v8 = sum((a(I, J) * f[nu(J) - 1] * fb[I] for I in idx for J in idx), zero)
    assert v1 == v2 == v3 == v4 == v5 == v6 == v7 == v8, M
    for L in idx:
        k = nu(L)
        s9 = sum(a(I, J) * f[nu(J) - 1] * fb[I][k - 1] for I in idx for J in idx)
        s10 = sum(a(I, J) * f[nu(J) - 1] * delta(I, L) for I in idx for J in idx)
        s11 = sum(a(L, J) * f[nu(J) - 1] for J in idx)
        s12 = sum(A[k - 1, l - 1] * f[l - 1] for l in range(1, n + 1))
        assert v8[k - 1] == s9 == s10 == s11 == s12, (M, L)
    # 主張: すべての k で ((end A)(f))_k = Σ_l A_kl f_l。Sage の行列と数ベクトルの積とも一致する
    assert v1 == A * f
    assert all(v1[k - 1] == sum(A[k - 1, l - 1] * f[l - 1] for l in range(1, n + 1)) for k in range(1, n + 1))
    # 定義の確認: end(E_{I,J}) が基底 f_K に Θ_{I,J} として作用する
    for I in idx:
        for J in idx:
            for K in idx:
                assert E.apply(EbR[(I, J)], fb[K]) == (fb[I] if K == J else zero)
print("M = 1, 2, 3 で、主張の式変形（左辺と 11 本の等号）と主張 (end(A)(f))_k = Σ_l A_kl f_l が QQ(i) 上の不定元で厳密に成り立つ")

# 対照: 主張の右辺を転置した行列の積 Σ_l A_lk f_l に替えると、M = 2 で一致しない（検算が添字の向きを見分けること）
R = PolynomialRing(GAUSSIAN, [f"a{p}_{q}" for p in range(1, 5) for q in range(1, 5)] + [f"x{p}" for p in range(1, 5)])
A = matrix(R, 4, 4, R.gens()[:16])
f = vector(R, R.gens()[16:])
assert EndByDefinition(2).apply(A, f) != A.transpose() * f
print("対照: 右辺を転置した行列の積に替えると、M = 2 で end(A)(f) と一致しない")
print("RESULT: PASS")
