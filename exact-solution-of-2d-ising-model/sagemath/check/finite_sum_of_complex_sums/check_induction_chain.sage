# 対象ラベル: finite_sum_of_complex_sums
# Σ_{j=1}^{n} (a_j + b_j) = (Σ a_j) + (Σ b_j) の証明の各行（n = 0 の鎖、n = 1 の 2 行、n → n+1 の 8 行）を
# n = 1,…,8 で確かめる。有限和は def_finite_sum_of_complex_numbers のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（a_j, b_j は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
N = 9
P = PolynomialRing(QQ, [f"a{j}" for j in range(1, N + 1)] + [f"b{j}" for j in range(1, N + 1)])
a = P.gens()[:N]
b = P.gens()[N:]


def fsum(zs):
    """def_finite_sum_of_complex_numbers: Σ_{j=1}^{0} z_j := 0_ℂ、Σ_{j=1}^{1} z_j := z_1、Σ_{j=1}^{m+1} z_j := (Σ_{j=1}^{m} z_j) + z_{m+1}。"""
    if len(zs) == 0:
        return P(0)
    s = zs[0]
    for z in zs[1:]:
        s = s + z
    return s


# n = 0（項の無い族）
lines0 = [
    fsum([]),                                                     # Σ^{0}(a_j + b_j)
    P(0),                                                         # def_finite_sum_of_complex_numbers の Σ^{0} := 0_ℂ（z_j → a_j + b_j）
    P(0) + P(0),                                                  # complex_numbers_form_a_field の加法の単位元 z + 0_ℂ = z（z → 0_ℂ）を右辺から左辺へ
    fsum([]) + fsum([]),                                          # def_finite_sum_of_complex_numbers の Σ^{0} := 0_ℂ（z_j → a_j; z_j → b_j）を右辺から左辺へ 2 か所同時適用
]
for t in range(len(lines0) - 1):
    assert lines0[t] == lines0[t + 1], (0, t)
print("n = 0 の 3 行を確かめた")

# n = 1
lines1 = [fsum([a[0] + b[0]]), a[0] + b[0], fsum([a[0]]) + fsum([b[0]])]
for t in range(len(lines1) - 1):
    assert lines1[t] == lines1[t + 1], (1, t)
count = 1
for n in range(1, N):
    ab = [a[j] + b[j] for j in range(n + 1)]
    al = fsum(list(a[:n]))
    be = fsum(list(b[:n]))
    assert fsum(ab[:n]) == al + be                                    # 帰納法の仮定（n で成り立つ）
    an, bn = a[n], b[n]                                               # a_{n+1}, b_{n+1}（0 始まり）
    lines = [
        fsum(ab),                                                     # Σ^{n+1}(a_j + b_j)
        fsum(ab[:n]) + (an + bn),                                     # def_finite_sum
        (al + be) + (an + bn),                                        # 帰納法の仮定
        al + (be + (an + bn)),                                        # 結合律
        al + ((be + an) + bn),                                        # 結合律
        al + ((an + be) + bn),                                        # 交換律
        al + (an + (be + bn)),                                        # 結合律
        (al + an) + (be + bn),                                        # 結合律
        fsum(list(a[:n + 1])) + fsum(list(b[:n + 1])),                # def_finite_sum（2 か所）
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 比べる側: Sage の sum（独立な経路）
    assert sum(ab) == sum(a[:n + 1]) + sum(b[:n + 1])
    # 対照: b_{n+1} を落とした右辺とは一致しない
    assert fsum(ab) != fsum(list(a[:n + 1])) + fsum(list(b[:n]))
    count += 1
print(f"n = 1,…,{N} の {count} 通りで帰納法の各行を確かめた")
print("RESULT: PASS")
