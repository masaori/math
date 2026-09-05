# 対象ラベル: claim_root_polynomial_remaining_factor_value_ne_zero


R.<t> = PolynomialRing(QQbar)


def K(w, n):
    """本文の K_0(w)=0、K_{n+1}(w)=K_n(w)w+t^n。"""
    value = R.zero()
    for k in range(n):
        value = value * w + t^k
    return value


def factor_quotient(f, w, n):
    """因数定理で構成した商。"""
    return sum((R(f[k]) * K(w, k) for k in range(n + 1)), R.zero())


def main():
    print("1. 準備の 2 つの検査（f の係数上界と根の条件）を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for k in range(n + 1, n + 5):
            assert f[k] == (t^n)[k] + R(-1)[k]
            assert (t^n)[k] + R(-1)[k] == QQbar(0) + R(-1)[k]
            assert QQbar(0) + R(-1)[k] == QQbar(0) + QQbar(0)
            assert QQbar(0) + QQbar(0) == QQbar(0)
            assert f[k] == 0
        for j in range(n):
            w = QQbar.zeta(n)^j
            assert w^n == 1
            assert f(w) == (t^n)(w) + R(-1)(w)
            assert (t^n)(w) + R(-1)(w) == w^n + R(-1)(w)
            assert w^n + R(-1)(w) == w^n + QQbar(-1)
            assert w^n + QQbar(-1) == QQbar(1) + QQbar(-1)
            assert QQbar(1) + QQbar(-1) == QQbar(0)
            assert f(w) == w^n + QQbar(-1)
            assert f(w) == 0
    print("   通過")

    print("2. 鎖の各行（(t-w)B = f = (t-w)g、消去による B = g、値の一致）を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for j in range(n):
            w = QQbar.zeta(n)^j
            # 仮定を満たす B（f を一次因子で割った商）。仮定の検査:
            B = f // (t - w)
            assert f == (t - w) * B
            assert all(B[k] == 0 for k in range(n + 1, n + 5))
            g = factor_quotient(f, w, n)
            # 1 行目: (t-w)B = f（本主張の仮定）
            assert (t - w) * B == f
            # 2 行目: f = (t-w)g（因数定理）
            assert f == (t - w) * g
            # 商の係数の上界（n 以上の番号で零）
            assert all(g[k] == 0 for k in range(n, n + 5))
            # 消去: B = g
            assert B == g
            # 値の鎖: aev_w(B) = aev_w(g)
            assert B(w) == g(w)
            assert g(w) != 0
    print("   通過")

    print("3. 主張（aev_w(B) が零でないこと）を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for j in range(n):
            w = QQbar.zeta(n)^j
            B = f // (t - w)
            assert B(w) != 0
    print("   通過")
    print("すべて通過")


main()
