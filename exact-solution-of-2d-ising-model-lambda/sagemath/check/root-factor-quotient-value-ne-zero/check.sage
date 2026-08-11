# 対象ラベル: claim_root_factor_quotient_value_ne_zero


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
    print("1. 準備の 3 つの非零性（w、w^(n-1)、同じ元 n 個の有限和）を確かめる")
    for n in range(1, 9):
        for j in range(n):
            w = QQbar.zeta(n)^j
            assert w^n == 1
            assert w != 0
            assert w^(n - 1) != 0
            assert sum(w^(n - 1) for i in range(n)) != 0
    print("   通過")

    print("2. 鎖の各行（aev_w(g)=aev_w(K_n(w))=n 個の w^(n-1) の和）を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for j in range(n):
            w = QQbar.zeta(n)^j
            g = factor_quotient(f, w, n)
            assert g(w) == K(w, n)(w)
            assert K(w, n)(w) == sum(w^(n - 1) for i in range(n))
    print("   通過")

    print("3. 主張（aev_w(g) が零でないこと）を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for j in range(n):
            w = QQbar.zeta(n)^j
            g = factor_quotient(f, w, n)
            assert g(w) != 0
    print("   通過")
    print("すべて通過")


main()
