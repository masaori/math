# 対象ラベル: matrix_conjugation_preserves_finite_sum
# T_B(Σ_{j=1}^{r} X_j) = Σ_{j=1}^{r} T_B(X_j) の帰納法の各行（r = 1 の 2 行、r → r+1 の 4 行）を、
# n = 1, 2, 3、r = 1,…,4 で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# T_B(X) = (BX)B^{-1} の B^{-1} は、鎖のどの行も B^{-1}B = I を使わないので、B と独立な不定元の行列 Bi に置いた。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

R_MAX = 5
count = 0
for n in [1, 2, 3]:
    shapes = [("B", n, n), ("Bi", n, n)] + [(f"X{j}", n, n) for j in range(1, R_MAX + 1)]
    P, _, mats = generic_ring(shapes)
    B, Bi, X = mats[0], mats[1], mats[2:]

    def T(Y):
        """mat_conj の T_B: (BY)B^{-1}。"""
        return body_product(body_product(B, Y), Bi)

    # r = 1
    lines1 = [T(body_finite_sum(X[:1])), T(X[0]), body_finite_sum([T(X[0])])]
    for t in range(len(lines1) - 1):
        assert lines1[t] == lines1[t + 1], (n, 1, t)
    # r → r+1（r = 1,…,R_MAX-1）
    for r in range(1, R_MAX):
        assert T(body_finite_sum(X[:r])) == body_finite_sum([T(Y) for Y in X[:r]])   # 帰納法の仮定（r で成り立つ）
        lines = [
            T(body_finite_sum(X[:r + 1])),                                            # T_B(Σ_{j=1}^{r+1} X_j)
            T(body_sum(body_finite_sum(X[:r]), X[r])),                                 # def_finite_sum_of_matrices
            body_sum(T(body_finite_sum(X[:r])), T(X[r])),                              # mat_conj の和を保つこと
            body_sum(body_finite_sum([T(Y) for Y in X[:r]]), T(X[r])),                 # 帰納法の仮定
            body_finite_sum([T(Y) for Y in X[:r + 1]]),                                # def_finite_sum_of_matrices
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (n, r, t)
        # 主張を Sage の行列演算（独立な経路）と比べる
        assert T(sum(X[:r + 1])) == sum(B * Y * Bi for Y in X[:r + 1])
        # 対照: 最後の項を落とした和とは一致しない
        assert T(body_finite_sum(X[:r + 1])) != body_finite_sum([T(Y) for Y in X[:r]])
        count += 1
print(f"checked the induction chain for n = 1, 2, 3 and r = 1,...,{R_MAX} ({count} steps)")
print("RESULT: PASS")
