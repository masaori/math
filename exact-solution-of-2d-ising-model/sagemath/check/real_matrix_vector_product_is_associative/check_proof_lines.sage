# 対象ラベル: real_matrix_vector_product_is_associative
# 証明の 10 行の鎖 ((PQ)x)_i = Σ_k (PQ)_ik x_k = Σ_k (Σ_j P_ijQ_jk) x_k = Σ_k x_k(Σ_j P_ijQ_jk) = Σ_k Σ_j x_k(P_ijQ_jk)
#   = Σ_k Σ_j (P_ijQ_jk)x_k = Σ_k Σ_j P_ij(Q_jkx_k) = Σ_j Σ_k P_ij(Q_jkx_k) = Σ_j P_ij(Σ_k Q_jkx_k) = Σ_j P_ij(Qx)_j = (P(Qx))_i
#   と主張 (PQ)x = P(Qx) を、ランダムな大きさと実数の成分で厳密に確かめる。
# 帰属: ℝ の元は AA。浮動小数点は使わない。和は def_finite_sum_of_real_numbers のとおり添字の小さい順に左から足す。


def rsum(terms):
    """def_finite_sum_of_real_numbers: 1 項目から順に左から足す（項は 1 つ以上）。"""
    terms = list(terms)
    assert len(terms) >= 1
    s = terms[0]
    for t in terms[1:]:
        s = s + t
    return s


def matprod(P, Q):
    """def_real_matrix_product: (PQ)_ik := Σ_j P_ij Q_jk。"""
    return matrix(AA, P.nrows(), Q.ncols(), lambda i, k: rsum(P[i, j] * Q[j, k] for j in range(P.ncols())))


def matvec(P, x):
    """def_real_matrix_vector_product: (Px)_i := Σ_j P_ij x_j。"""
    return vector(AA, [rsum(P[i, j] * x[j] for j in range(P.ncols())) for i in range(P.nrows())])


set_random_seed(20261106)
cands = [AA(-3), AA(-1)/2, AA(0), AA(2)/3, AA(5), AA(2).sqrt(), -AA(3).sqrt()]
pick = lambda: cands[randint(0, len(cands) - 1)]
count = 0
for trial in range(30):
    m, n, p = randint(1, 4), randint(1, 4), randint(1, 4)
    P = matrix(AA, m, n, lambda i, j: pick())
    Q = matrix(AA, n, p, lambda j, k: pick())
    x = vector(AA, [pick() for _ in range(p)])
    PQ = matprod(P, Q)
    Qx = matvec(Q, x)
    lhs, rhs = matvec(PQ, x), matvec(P, Qx)
    for i in range(m):
        l1 = lhs[i]
        l2 = rsum(PQ[i, k] * x[k] for k in range(p))
        l3 = rsum(rsum(P[i, j] * Q[j, k] for j in range(n)) * x[k] for k in range(p))
        l4 = rsum(x[k] * rsum(P[i, j] * Q[j, k] for j in range(n)) for k in range(p))
        l5 = rsum(rsum(x[k] * (P[i, j] * Q[j, k]) for j in range(n)) for k in range(p))
        l6 = rsum(rsum((P[i, j] * Q[j, k]) * x[k] for j in range(n)) for k in range(p))
        l7 = rsum(rsum(P[i, j] * (Q[j, k] * x[k]) for j in range(n)) for k in range(p))
        l8 = rsum(rsum(P[i, j] * (Q[j, k] * x[k]) for k in range(p)) for j in range(n))
        l9 = rsum(P[i, j] * rsum(Q[j, k] * x[k] for k in range(p)) for j in range(n))
        l10 = rsum(P[i, j] * Qx[j] for j in range(n))
        l11 = rhs[i]
        assert l1 == l2 == l3 == l4 == l5 == l6 == l7 == l8 == l9 == l10 == l11, (trial, i)
        count += 1
    assert lhs == rhs                                         # 主張 (PQ)x = P(Qx)
    assert lhs == (P * Q) * x == P * (Q * x)                  # Sage の組み込みの積（別の実装）とも比べる
# 否定コントロール: 積の順を入れ替えた (QP)x は一般に (PQ)x と異なる（正方の場合）
P = matrix(AA, 2, 2, [1, 2, 0, 1]); Q = matrix(AA, 2, 2, [1, 0, 3, 1]); x = vector(AA, [1, 0])
assert matvec(matprod(P, Q), x) != matvec(matprod(Q, P), x)
print(f"{count} 個の成分で 10 行の鎖と ((PQ)x)_i = (P(Qx))_i を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
