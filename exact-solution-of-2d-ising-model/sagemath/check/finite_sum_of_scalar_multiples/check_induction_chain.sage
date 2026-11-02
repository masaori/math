# 対象ラベル: finite_sum_of_scalar_multiples
# Σ_{j=1}^{r} (cX_j) = cΣ_{j=1}^{r} X_j の帰納法の各行（r = 1 の 2 行、r → r+1 の 4 行）を、
# 正方でない形を含む (m, n) ∈ {1,2,3}^2、r = 1,…,4 で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（c と X_j の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

R_MAX = 5
count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, (c,), X = generic_ring([(f"X{j}", m, n) for j in range(1, R_MAX + 1)], scalars=["s_c"])
        sc = lambda Y: body_scalar(c, Y)
        # r = 1
        lines1 = [body_finite_sum([sc(X[0])]), sc(X[0]), sc(body_finite_sum(X[:1]))]
        for t in range(len(lines1) - 1):
            assert lines1[t] == lines1[t + 1], (m, n, 1, t)
        assert sum(c * Y for Y in X[:1]) == c * sum(X[:1]) == lines1[0]   # 主張（r = 1）を Sage の行列演算と比べる
        # r → r+1（r = 1,…,R_MAX-1）
        for r in range(1, R_MAX):
            assert body_finite_sum([sc(Y) for Y in X[:r]]) == sc(body_finite_sum(X[:r]))   # 帰納法の仮定（r で成り立つ）
            lines = [
                body_finite_sum([sc(Y) for Y in X[:r + 1]]),                  # Σ_{j=1}^{r+1} (cX_j)
                body_sum(body_finite_sum([sc(Y) for Y in X[:r]]), sc(X[r])),  # def_finite_sum_of_matrices（項 cX_j）
                body_sum(sc(body_finite_sum(X[:r])), sc(X[r])),               # 帰納法の仮定
                sc(body_sum(body_finite_sum(X[:r]), X[r])),                   # scalar_multiple_distributes_over_matrix_sum（右辺から左辺へ）
                sc(body_finite_sum(X[:r + 1])),                               # def_finite_sum_of_matrices
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (m, n, r, t)
            # 主張を Sage の行列演算（独立な経路）と比べる
            assert sum(c * Y for Y in X[:r + 1]) == c * sum(X[:r + 1]) == lines[0]
            # 対照: 最後の項だけ c 倍しなかった和とは一致しない
            assert lines[0] != body_sum(body_finite_sum([sc(Y) for Y in X[:r]]), X[r])
            count += 1
print(f"checked the base case and the induction steps r -> r+1 (r = 1,...,{R_MAX - 1}) for (m, n) in {{1,2,3}}^2 ({count} steps); the statement for r = 1,...,{R_MAX}")
print("RESULT: PASS")
