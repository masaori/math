# 対象ラベル: finite_sum_of_matrices_distributes_in_left_factor
# (Σ_{j=1}^{r} X_j)C = Σ_{j=1}^{r} (X_jC) の帰納法の各行（r = 1 の 2 行、r → r+1 の 4 行）を、
# 正方でない形を含む (m, n, p) ∈ {1,2,3}^3、r = 1,…,4 で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（X_j と C の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

R_MAX = 5
count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        for p in [1, 2, 3]:
            shapes = [(f"X{j}", m, n) for j in range(1, R_MAX + 1)] + [("C", n, p)]
            P, _, mats = generic_ring(shapes)
            X, C = mats[:R_MAX], mats[R_MAX]
            pr = lambda Y: body_product(Y, C)
            # r = 1
            lines1 = [body_product(body_finite_sum(X[:1]), C), pr(X[0]), body_finite_sum([pr(X[0])])]
            for t in range(len(lines1) - 1):
                assert lines1[t] == lines1[t + 1], (m, n, p, 1, t)
            assert sum(X[:1]) * C == sum(Y * C for Y in X[:1]) == lines1[0]   # 主張（r = 1）を Sage の行列演算と比べる
            # r → r+1（r = 1,…,R_MAX-1）
            for r in range(1, R_MAX):
                assert body_product(body_finite_sum(X[:r]), C) == body_finite_sum([pr(Y) for Y in X[:r]])   # 帰納法の仮定
                lines = [
                    body_product(body_finite_sum(X[:r + 1]), C),                    # (Σ_{j=1}^{r+1} X_j)C
                    body_product(body_sum(body_finite_sum(X[:r]), X[r]), C),        # def_finite_sum_of_matrices
                    body_sum(body_product(body_finite_sum(X[:r]), C), pr(X[r])),    # mat_mult_distributes_over_sum_in_left_factor
                    body_sum(body_finite_sum([pr(Y) for Y in X[:r]]), pr(X[r])),    # 帰納法の仮定
                    body_finite_sum([pr(Y) for Y in X[:r + 1]]),                    # def_finite_sum_of_matrices（項 X_jC）を右辺から左辺へ
                ]
                for t in range(len(lines) - 1):
                    assert lines[t] == lines[t + 1], (m, n, p, r, t)
                assert sum(X[:r + 1]) * C == sum(Y * C for Y in X[:r + 1]) == lines[0]   # 独立な経路
                # 対照: 最後の項に C を掛けなかった和とは一致しない（形が合うときだけ）
                if n == p:
                    assert lines[0] != body_sum(body_finite_sum([pr(Y) for Y in X[:r]]), X[r])
                count += 1
print(f"checked the base case and the induction steps r -> r+1 (r = 1,...,{R_MAX - 1}) for (m, n, p) in {{1,2,3}}^3 ({count} steps)")
print("RESULT: PASS")
