# 対象ラベル: finite_sum_of_negated_real_numbers
# Σ_{j=1}^{m} (−x_j) = −Σ_{j=1}^{m} x_j の帰納法の各行（m = 1 の 2 行、m → m+1 の 4 行）を
# m = 1,…,8 で確かめる。有限和は def_finite_sum_of_real_numbers のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（x_j は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
N = 9
P = PolynomialRing(QQ, [f"x{j}" for j in range(1, N + 1)])
x = P.gens()


def fsum(rs):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


# m = 1
lines1 = [fsum([-x[0]]), -x[0], -fsum([x[0]])]
for t in range(len(lines1) - 1):
    assert lines1[t] == lines1[t + 1], (1, t)
count = 2
broken = 0
for m in range(1, N):
    neg = [-x[j] for j in range(m + 1)]
    assert fsum(neg[:m]) == -fsum(list(x[:m]))                        # 帰納法の仮定（m で成り立つ）
    xm = x[m]                                                         # x_{m+1}（0 始まり）
    lines = [
        fsum(neg),                                                    # Σ^{m+1}(−x_j)
        fsum(neg[:m]) + (-xm),                                        # def_finite_sum_of_real_numbers
        (-fsum(list(x[:m]))) + (-xm),                                 # 帰納法の仮定
        -(fsum(list(x[:m])) + xm),                                    # ℝ で (−a) + (−b) = −(a + b)
        -fsum(list(x[:m + 1])),                                       # def_finite_sum_of_real_numbers を右辺から左辺へ
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (m, t)
        count += 1
    assert sum(neg) == -sum(x[:m + 1])                                # 比べる側: Sage の sum（独立な経路）
    if fsum(neg) != -fsum(list(x[:m])) + xm:                          # 対照: 最後の項の符号を反転し忘れた右辺
        broken += 1
assert broken == N - 1
print(f"m = 1 の 2 行と、帰納法の段 m → m+1（m = 1,…,{N - 1}）の各行を確かめた（{count} 段）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
