# 対象ラベル: claim_root_polynomial_factor_quotient


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
    print("1. 因数定理の有限和と K_n(w) の一致を確かめる")
    for n in range(1, 9):
        f = t^n - 1
        for j in range(n):
            w = QQbar.zeta(n)^j
            assert w^n == 1
            g = factor_quotient(f, w, n)
            assert g == K(w, n)
            assert f == (t - w) * g
    print("   通過")

    print("2. 有限和のうち番号 n の項だけが K_n(w) として残ることを確かめる")
    for n in range(1, 9):
        f = t^n - 1
        w = QQbar.zeta(n)
        terms = [R(f[k]) * K(w, k) for k in range(n + 1)]
        assert terms[n] == K(w, n)
        assert all(terms[k] == 0 for k in range(n))
    print("   通過")
    print("すべて通過")


main()
