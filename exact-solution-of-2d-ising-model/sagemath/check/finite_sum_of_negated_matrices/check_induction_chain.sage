# 対象ラベル: finite_sum_of_negated_matrices
# Σ_{j=1}^{r} (-X_j) = -Σ_{j=1}^{r} X_j の帰納法の各行（r = 1 の 2 行、r → r+1 の 4 行）を、
# 正方でない形を含む (m, n) ∈ {1,2,3}^2、r = 1,…,4 で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

R_MAX = 5
count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, _, X = generic_ring([(f"X{j}", m, n) for j in range(1, R_MAX + 1)])
        neg = body_negation
        # r = 1
        lines1 = [body_finite_sum([neg(X[0])]), neg(X[0]), neg(body_finite_sum(X[:1]))]
        for t in range(len(lines1) - 1):
            assert lines1[t] == lines1[t + 1], (m, n, 1, t)
        assert sum(-Y for Y in X[:1]) == -sum(X[:1]) == lines1[0]   # 主張（r = 1）を Sage の行列演算と比べる
        # r → r+1（r = 1,…,R_MAX-1）
        for r in range(1, R_MAX):
            assert body_finite_sum([neg(Y) for Y in X[:r]]) == neg(body_finite_sum(X[:r]))   # 帰納法の仮定（r で成り立つ）
            lines = [
                body_finite_sum([neg(Y) for Y in X[:r + 1]]),                  # Σ_{j=1}^{r+1} (-X_j)
                body_sum(body_finite_sum([neg(Y) for Y in X[:r]]), neg(X[r])), # def_finite_sum_of_matrices（項 -X_j）
                body_sum(neg(body_finite_sum(X[:r])), neg(X[r])),              # 帰納法の仮定
                neg(body_sum(body_finite_sum(X[:r]), X[r])),                   # negation_distributes_over_matrix_sum
                neg(body_finite_sum(X[:r + 1])),                               # def_finite_sum_of_matrices
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (m, n, r, t)
            # 主張を Sage の行列演算（独立な経路）と比べる
            assert sum(-Y for Y in X[:r + 1]) == -sum(X[:r + 1]) == lines[0]
            # 対照: 最後の項だけ符号反転しなかった和とは一致しない
            assert lines[0] != body_sum(body_finite_sum([neg(Y) for Y in X[:r]]), X[r])
            count += 1
print(f"checked the base case and the induction steps r -> r+1 (r = 1,...,{R_MAX - 1}) for (m, n) in {{1,2,3}}^2 ({count} steps); the statement for r = 1,...,{R_MAX}")
print("RESULT: PASS")
