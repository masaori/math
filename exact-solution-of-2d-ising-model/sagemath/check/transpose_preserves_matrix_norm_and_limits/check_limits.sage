# 対象ラベル: transpose_preserves_matrix_limits
# 各 N での ‖A_N^⊤ - A^⊤‖ = ‖(A_N - A)^⊤‖ = ‖A_N - A‖ を、
# 成分の式（不定元の対）と具体の列 A_N := A + (1/(N+1)) C（成分は QQ(i)）の AA で厳密に確かめる。
# N → ∞ の極限そのものは有限の計算では確かめられない（overview.md）。
load("_prelude.sage")

# 1 行目の根拠 transpose_of_matrix_difference: A_N^⊤ - A^⊤ = (A_N - A)^⊤ を不定元で（成分ごと）
for n in SIZES:
    P, (AN, A) = generic_pairs(n, ["AN", "A"])
    lhs = body_diff(body_transpose(AN), body_transpose(A), P)
    rhs = body_transpose(body_diff(AN, A, P))
    assert lhs == rhs, n
    # 比べる側: Sage の transpose と差（QQ(i) 係数の多項式行列）
    PK = PolynomialRing(K, P.variable_names())
    g = lambda X: matrix(PK, n, n, lambda k, l: PK(X[k][l][0]) + i_K * PK(X[k][l][1]))
    assert g(lhs) == g(AN).transpose() - g(A).transpose() == (g(AN) - g(A)).transpose()
print("1 行目の A_N^⊤ - A^⊤ = (A_N - A)^⊤ を、n = 1,…,4 の不定元で、Sage の transpose・差とも比べて確かめた")

set_random_seed(41)
count = 0
for n in SIZES:
    rnd = lambda: K(ZZ.random_element(-5, 6)) + i_K * K(ZZ.random_element(-5, 6))
    gA = matrix(K, n, n, lambda r, s: rnd())
    gC = matrix(K, n, n, lambda r, s: rnd())
    A = to_pairs(gA)
    prev = None
    for N in range(0, 30):
        AN = to_pairs(gA + (QQ(1) / (N + 1)) * gC)
        v = [
            norm_aa(body_diff(body_transpose(AN), body_transpose(A), QQ)),   # ‖A_N^⊤ - A^⊤‖
            norm_aa(body_transpose(body_diff(AN, A, QQ))),                   # ‖(A_N - A)^⊤‖   (transpose_of_matrix_difference)
            norm_aa(body_diff(AN, A, QQ)),                                   # ‖A_N - A‖       (transpose_preserves_matrix_norm)
        ]
        assert v[0] == v[1] == v[2], (n, N)
        assert v[2] == frob(gC) / (N + 1)
        if prev is not None:
            assert v[0] < prev
        prev = v[0]
        count += 2
print(f"具体の列 A_N = A + C/(N+1)（n = 1,…,4、N = 0,…,29）で、各 N の 2 個の等号を AA で厳密に確かめた（{count} 段）")

# 否定コントロール: 転置の差を逆向きの差 A^⊤ - A_N^⊤ と取り違えても、ノルムは等しい（符号はノルムに効かない）が、
# 行列としては (A_N - A)^⊤ と一致しない
gA = matrix(K, 2, 2, [1, i_K, 0, 2]); gB = matrix(K, 2, 2, [0, 1, 1, 0])
assert gB.transpose() - gA.transpose() != (gA - gB).transpose()
print("否定コントロール 1 件: A^⊤ - A_N^⊤ は (A_N - A)^⊤ と一致しない")
print("RESULT: PASS")
