# 対象ラベル: finite_sum_of_real_sums
# Σ_{j=1}^{m} (a_j + b_j) = (Σ a_j) + (Σ b_j) の帰納法の各行（m = 1 の 2 行、m → m+1 の 9 行）を
# m = 1,…,8 で確かめる。有限和は def_finite_sum_of_real_numbers のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（a_j, b_j は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
N = 9
P = PolynomialRing(QQ, [f"a{j}" for j in range(1, N + 1)] + [f"b{j}" for j in range(1, N + 1)])
a = P.gens()[:N]
b = P.gens()[N:]


def fsum(rs):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


# m = 1
lines1 = [fsum([a[0] + b[0]]), a[0] + b[0], fsum([a[0]]) + fsum([b[0]])]
for t in range(len(lines1) - 1):
    assert lines1[t] == lines1[t + 1], (1, t)
count = 2
for m in range(1, N):
    ab = [a[j] + b[j] for j in range(m + 1)]
    al = fsum(list(a[:m]))
    be = fsum(list(b[:m]))
    assert fsum(ab[:m]) == al + be                                    # 帰納法の仮定（m で成り立つ）
    am, bm = a[m], b[m]                                               # a_{m+1}, b_{m+1}（0 始まり）
    lines = [
        fsum(ab),                                                     # Σ^{m+1}(a_j + b_j)
        fsum(ab[:m]) + (am + bm),                                     # def_finite_sum_of_real_numbers
        (al + be) + (am + bm),                                        # 帰納法の仮定
        al + (be + (am + bm)),                                        # ℝ の加法の結合則
        al + ((be + am) + bm),                                        # ℝ の加法の結合則
        al + ((am + be) + bm),                                        # ℝ の加法の交換則
        al + (am + (be + bm)),                                        # ℝ の加法の結合則
        (al + am) + (be + bm),                                        # ℝ の加法の結合則
        (fsum(list(a[:m])) + am) + (fsum(list(b[:m])) + bm),          # α, β の置き方
        fsum(list(a[:m + 1])) + fsum(list(b[:m + 1])),                # def_finite_sum_of_real_numbers（2 か所）
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (m, t)
        count += 1
    assert sum(ab) == sum(a[:m + 1]) + sum(b[:m + 1])                 # 比べる側: Sage の sum（独立な経路）
    assert fsum(ab) != fsum(list(a[:m + 1])) + fsum(list(b[:m]))      # 対照: b_{m+1} を落とした右辺とは一致しない
print(f"m = 1 の 2 行と、帰納法の段 m → m+1（m = 1,…,{N - 1}）の各行を確かめた（{count} 段）")
print("RESULT: PASS")
