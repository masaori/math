# 対象ラベル: claim_root_of_unity_power_sum_multiple_value
#
# 主張: n >= 1、n | m ならば S_{n,m} = sum_{z in mu_n} z^m = n（n は QQbar の元と見る）。
# 人手証明の鎖
#   S_{n,m} = sum z^m = sum 1 = sum_{i<n} 1 = n
# を QQbar で一段ずつ確かめる。浮動小数点は使わない。


def roots_of_unity(n):
    return [QQbar.zeta(n) ** j for j in range(n)]


def check_power_sum_multiple_value(nmax, kmax):
    one = QQbar(1)
    count = 0
    for n in range(1, nmax + 1):
        mu = roots_of_unity(n)
        # 準備: 列の長さだけでなく、相異性・根への所属・全根の被覆を判定する。
        polynomial_ring = PolynomialRing(QQbar, "t")
        t = polynomial_ring.gen()
        assert all(z ** n == one for z in mu)
        assert len(set(mu)) == len(mu) == n
        assert set(mu) == set((t ** n - 1).roots(multiplicities=False))
        for k in range(kmax + 1):
            m = n * k
            # 第 1 の等号: S_{n,m} の定義
            S = sum(z ** m for z in mu)
            # 第 2 の等号: 各項が 1（claim_root_of_unity_power_of_multiple）
            for z in mu:
                assert z ** m == one
            assert S == sum(one for z in mu)
            # 第 3 の等号: 全単射 e(i) = zeta_n^i による添字の取り替え
            assert sum(one for z in mu) == sum(one for i in range(n))
            # 第 4 の等号: 単位元の n 個の有限和は n（claim_qbar_unit_sum_eq_rational）
            assert sum(one for i in range(n)) == QQbar(n)
            # 結論
            assert S == QQbar(n)
            count += 1
    print(
        "claim_root_of_unity_power_sum_multiple_value: %d 組ですべて通過"
        % count
    )


check_power_sum_multiple_value(8, 12)
