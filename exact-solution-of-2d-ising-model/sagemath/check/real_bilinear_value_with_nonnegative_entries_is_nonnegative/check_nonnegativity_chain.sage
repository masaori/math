# real_bilinear_value_with_nonnegative_entries_is_nonnegative
# P ∈ Mat(n,ℝ)、x, y ∈ ℝ^n の成分がすべて非負なら x^T P y ≥ 0 の、準備の 2 つの不等式・各 p の 2 行の鎖・本体の 3 行の鎖を、
# 成分を非負の有理数（QQ）に取った 200 組（n = 1,…,5 を各 40 組）で厳密に確かめる。
# x^T P y は def_real_bilinear_value のとおり Σ_k Σ_l (x_k P_kl) y_l を左から順に足して組む。
# 帰属: QQ。浮動小数点は使わない。一般の非負の実数は人手証明の鎖が担う。

set_random_seed(20261107)


def lsum(terms):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    terms = list(terms)
    s = terms[0]
    for q in terms[1:]:
        s = s + q
    return s


def bilin(x, P, y):
    """def_real_bilinear_value の x^T P y。"""
    n = len(x)
    return lsum(lsum((x[k] * P[k][l]) * y[l] for l in range(n)) for k in range(n))


def nonneg_rational():
    return QQ(ZZ.random_element(0, 20)) / QQ(ZZ.random_element(1, 10))


count = 0
for n in [1, 2, 3, 4, 5]:
    N = range(n)
    for trial in range(40):
        P = [[nonneg_rational() for l in N] for k in N]
        xs = [nonneg_rational() for k in N]
        ys = [nonneg_rational() for k in N]
        # 準備の 2 つの不等式（項の非負性。人手の p, q は Python の k, l）
        for k in N:
            for l in N:
                assert xs[k] * P[k][l] >= 0
                assert (xs[k] * P[k][l]) * ys[l] >= 0
                count += 2
        # 行の和の非負性の 2 行の鎖（人手の p は Python の k、添字 1 は Python の 0）
        row = [lsum((xs[k] * P[k][l]) * ys[l] for l in N) for k in N]
        for k in N:
            assert row[k] >= (xs[k] * P[k][0]) * ys[0]
            assert (xs[k] * P[k][0]) * ys[0] >= 0
            count += 2
        # 本体の 3 行の鎖
        lines = [bilin(xs, P, ys), lsum(row), row[0]]
        assert lines[0] == lines[1]
        assert lines[1] >= lines[2]
        assert lines[2] >= 0
        count += 3
        # 両端を Sage の vector * matrix * vector（本文の式とは別の経路）と比べる
        assert lines[0] == vector(QQ, xs) * matrix(QQ, P) * vector(QQ, ys)
# 否定コントロール: x の成分に負のものを許すと主張は崩れる
assert bilin([QQ(-1)], [[QQ(1)]], [QQ(1)]) < 0
print(f"準備の不等式・行の和の鎖・本体の鎖を n = 1,…,5 の 200 組で確かめた（{count} 段）。負の成分を許すと主張が崩れることも確かめた")
print("RESULT: PASS")
