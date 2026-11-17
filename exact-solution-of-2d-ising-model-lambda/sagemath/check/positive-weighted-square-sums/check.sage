# 対象ラベル: def_positive_weighted_square_sums, claim_positive_weighted_square_sums_is_precone
# QQ の厳密計算だけを使う。浮動小数点を使わない。
# 本文の証明の各段を、次の二つのモデルで行ごとに確かめる。
#   モデル A: F = QQ ⊆ E = Q_s（s*s = 2）、C_F = 正の有理数。
#   モデル B: F = E = Q_s、C_F = P_s（def_quadratic_positive_cone の三つの有理条件）。
# Q_s の元 a + b*s は組 (a, b) で表す。
# あわせて、和・積の式変形を多項式環 QQ[c, y, d, w] の恒等式として確かめる（有限の添字の大きさごと）。
# 普遍量化された主張の証明ではない。

from itertools import product

set_random_seed(20261117)

RATIONAL_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def q_add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def q_mul(x, y):
    return (x[0] * y[0] + 2 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


ZERO = (QQ(0), QQ(0))
ONE = (QQ(1), QQ(0))
NEG_ONE = (QQ(-1), QQ(0))


def P_s(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0)) or
            (0 < a and b < 0 and 2 * b * b < a * a) or
            (a < 0 and 0 < b and a * a < 2 * b * b))


def C_rational(ab):
    return ab[1] == 0 and ab[0] > 0


def weighted_square_sum(c, y):
    # sum_{i in I} c(i) * (y(i) * y(i))。I が空なら零元。
    total = ZERO
    for ci, yi in zip(c, y):
        total = q_add(total, q_mul(ci, q_mul(yi, yi)))
    return total


def random_q():
    return (QQ(randint(-9, 9)) / randint(1, 5), QQ(randint(-9, 9)) / randint(1, 5))


def random_cone_element(C):
    while True:
        z = random_q()
        if C(z):
            return z


def check_one_in_cone():
    # 1 ∈ F、三分法のうち 1 ≠ 0、(-1)(-1) = 1
    assert ONE != ZERO
    assert q_mul(NEG_ONE, NEG_ONE) == ONE
    assert C_rational(ONE) and P_s(ONE)
    assert not C_rational(NEG_ONE) and not P_s(NEG_ONE)
    print("単位元の所属: 1 ≠ 0、(-1)·(-1) = 1、二つのモデルで 1 ∈ C_F", flush=True)


def check_model(name, C, trials):
    for _ in range(trials):
        n = randint(0, 3)
        m = randint(0, 3)
        c = [random_cone_element(C) for _ in range(n)]
        y = [random_q() for _ in range(n)]
        d = [random_cone_element(C) for _ in range(m)]
        w = [random_q() for _ in range(m)]
        z1 = weighted_square_sum(c, y)
        z2 = weighted_square_sum(d, w)
        # 和: 互いに素な和集合 K 上の e, v
        e = c + d
        v = y + w
        assert q_add(z1, z2) == weighted_square_sum(e, v)
        # 積: 二重和を経て直積 I × J 上の e', v'
        double_sum = ZERO
        for i in range(n):
            for j in range(m):
                double_sum = q_add(double_sum, q_mul(q_mul(c[i], q_mul(y[i], y[i])), q_mul(d[j], q_mul(w[j], w[j]))))
        assert q_mul(z1, z2) == double_sum
        e2 = [q_mul(c[i], d[j]) for i in range(n) for j in range(m)]
        v2 = [q_mul(y[i], w[j]) for i in range(n) for j in range(m)]
        assert all(C(x) for x in e2)
        assert q_mul(z1, z2) == weighted_square_sum(e2, v2)
    # 平方の条件と正錐の包含（一元集合）
    for _ in range(trials):
        y0 = random_q()
        assert q_mul(y0, y0) == weighted_square_sum([ONE], [y0])
        c0 = random_cone_element(C)
        assert c0 == weighted_square_sum([c0], [ONE])
    # 空の和は零元
    assert weighted_square_sum([], []) == ZERO
    print("%s: 無作為の族 %d 組で和・積の式変形、%d 点で平方と正錐の包含が通過" % (name, trials, trials), flush=True)


def check_polynomial_identities():
    for n, m in product(range(4), repeat=2):
        names = ['c%d' % i for i in range(n)] + ['y%d' % i for i in range(n)] + \
                ['d%d' % j for j in range(m)] + ['w%d' % j for j in range(m)] + ['dummy']
        R = PolynomialRing(QQ, names)
        g = R.gens()
        c = g[0:n]
        y = g[n:2 * n]
        d = g[2 * n:2 * n + m]
        w = g[2 * n + m:2 * n + 2 * m]
        z1 = sum((c[i] * (y[i] * y[i]) for i in range(n)), R(0))
        z2 = sum((d[j] * (w[j] * w[j]) for j in range(m)), R(0))
        assert z1 + z2 == sum((ci * (vi * vi) for ci, vi in zip(list(c) + list(d), list(y) + list(w))), R(0))
        line2 = sum((sum(((c[i] * (y[i] * y[i])) * (d[j] * (w[j] * w[j])) for j in range(m)), R(0)) for i in range(n)), R(0))
        line4 = sum(((c[i] * d[j]) * ((y[i] * w[j]) * (y[i] * w[j])) for i in range(n) for j in range(m)), R(0))
        assert z1 * z2 == line2
        assert line2 == line4
    print("多項式環の恒等式: 添字の大きさ 0〜3 の全 16 通りで和と積の式変形が恒等的に成立", flush=True)


check_one_in_cone()
check_model("モデル A（F = QQ、C_F = 正の有理数、E = Q_s）", C_rational, 200)
check_model("モデル B（F = E = Q_s、C_F = P_s）", P_s, 200)
check_polynomial_identities()
print("def_positive_weighted_square_sums / claim_positive_weighted_square_sums_is_precone: 全検査通過")
