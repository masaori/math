# 対象ラベル: epsilon_projector_commutes_with_epsilon_commuting_matrix
# 主張 P^{(+)}X = XP^{(+)} を、ε と可換な行列の全体（ε の固有空間の分解から Sage の right_kernel で求めた、
# XE - EX = 0 の解空間の基底）の各元について、Sage の `*` で厳密に確かめる。本文の鎖とは独立な経路である。
# 解空間の次元が 2 * (n/2)^2（ε の ±1 固有空間がともに n/2 次元）であることも確かめる。M_col = 1..4。
load("_prelude.sage")
for M in range(1, 5):
    n = 2 ** M
    E = epsilon(M)
    P = (identity_matrix(KG, n) + E) / 2
    # vec(XE - EX) = (E^T ⊗ I - I ⊗ E) vec(X)（列ごとに並べた vec）
    L = E.transpose().tensor_product(identity_matrix(KG, n)) - identity_matrix(KG, n).tensor_product(E)
    basis = L.right_kernel().basis()
    assert len(basis) == 2 * (n // 2) ** 2
    for v in basis:
        X = matrix(KG, n, n, lambda r, c: v[c * n + r])
        assert E * X == X * E
        assert P * X == X * P
    print(f"  M_col={M}: ε と可換な行列の空間（次元 {len(basis)}）の基底のすべてで P^(+)X = XP^(+)")
print("RESULT: PASS")
