# 対象ラベル: claim_integer_polynomial_qbar_lift_evaluation
#
# 主張: f in ZZ[x]（f = sum_{m=0}^{n} a_m x^m）と xi in QQbar について
#   aev_xi(f^F) = Ev^F_xi(f)
# である（f^F は def_integer_polynomial_qbar_lift の持ち上げ、aev は def_qbar_poly_evaluation、
# Ev^F は def_qbar_polynomial_evaluation）。人手証明の三段の鎖を ZZ[x]・QQbar[t] の厳密計算で
# 確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

Rt.<t> = PolynomialRing(QQbar)


def qbar_pow_rec(a, k):
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def lift_F(f):
    # def_integer_polynomial_qbar_lift: ac_k(f^F) = a_k (k <= n), 0 (n < k)
    n = f.degree() if f.degree() >= 0 else 0
    g = Rt.zero()
    for k in range(n + 1):
        g = g + Rt(QQbar(f[k])) * t ** k
    return g


def aev(w, g):
    # def_qbar_poly_evaluation: 係数が零でない項だけの有限和
    total = QQbar(0)
    for k in g.dict():
        total = total + g[k] * qbar_pow_rec(w, k)
    return total


def ev_F(xi, f):
    # def_qbar_polynomial_evaluation: sum_{m=0}^{n} a_m xi^m
    n = f.degree() if f.degree() >= 0 else 0
    total = QQbar(0)
    for m in range(n + 1):
        total = total + QQbar(f[m]) * qbar_pow_rec(xi, m)
    return total


SAMPLE_XI = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(sqrt(2)) - QQbar(1),
    QQbar(I),
    QQbar(-3) / QQbar(2),
    QQbar(sqrt(-3)),
]


def check_claim():
    ZZx = PolynomialRing(ZZ, 'x')
    x = ZZx.gen()
    polys = [partition_polynomial(L) for L in range(1, 4)]
    polys += [ZZx.zero(), ZZx.one(), x, x ** 2 - 1, 3 * x ** 4 - 2 * x + 7]
    count = 0
    for f in polys:
        n = f.degree() if f.degree() >= 0 else 0
        g = lift_F(f)
        # 準備: n < k で ac_k(f^F) = 0
        for k in range(n + 1, n + 4):
            assert g[k] == QQbar(0)
        # 持ち上げの係数（k <= n で a_k）
        for k in range(n + 1):
            assert g[k] == QQbar(f[k])
        for xi in SAMPLE_XI:
            # 第 1 段: aev_xi(f^F) = sum_{k=0}^{n} ac_k(f^F) xi^k（claim_qbar_evaluation_coefficient_sum）
            lhs = aev(xi, g)
            s1 = sum((g[k] * qbar_pow_rec(xi, k) for k in range(n + 1)), QQbar(0))
            assert lhs == s1
            # 第 2 段: = sum_{k=0}^{n} a_k xi^k（ac_k(f^F) = a_k）
            s2 = sum((QQbar(f[k]) * qbar_pow_rec(xi, k) for k in range(n + 1)), QQbar(0))
            assert s1 == s2
            # 第 3 段: = Ev^F_xi(f)
            assert s2 == ev_F(xi, f)
            # 主張そのもの
            assert lhs == ev_F(xi, f)
            count += 1
    # 帰結: Fisher 零点では両辺とも 0
    zero_count = 0
    for L in range(1, 4):
        Z = partition_polynomial(L)
        g = lift_F(Z)
        for xi in Z.roots(QQbar, multiplicities=False):
            assert ev_F(xi, Z) == 0
            assert aev(xi, g) == 0
            zero_count += 1
    assert zero_count > 0
    print("claim_integer_polynomial_qbar_lift_evaluation: 多項式 %d 個 × 標本 %d 個 = %d 検査、Fisher 零点 %d 個で両辺 0。すべて通過"
          % (len(polys), len(SAMPLE_XI), count, zero_count))


check_claim()
