# 対象ラベル: claim_root_of_unity_power_of_multiple
#
# 主張: n >= 1、n | m、w in mu_n ならば w^m = 1。
# 人手証明の 3 段 w^(nk) = (w^n)^k = 1^k = 1 を QQbar で一段ずつ確かめる。
# 浮動小数点は使わない。


def roots_of_unity(n):
    return [QQbar.zeta(n) ** j for j in range(n)]


def check_power_of_multiple(nmax, kmax):
    one = QQbar(1)
    count = 0
    for n in range(1, nmax + 1):
        for k in range(kmax + 1):
            m = n * k
            for w in roots_of_unity(n):
                assert w ** m == w ** (n * k)
                assert w ** (n * k) == (w ** n) ** k
                assert (w ** n) ** k == one ** k
                assert one ** k == one
                assert w ** m == one
                count += 1
    print("claim_root_of_unity_power_of_multiple: %d 組ですべて通過" % count)


check_power_of_multiple(8, 12)
