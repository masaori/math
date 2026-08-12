# 対象ラベル: claim_root_of_unity_power_sum_zero
#
# 主張: n ≥ 1、m を自然数とし、w ∈ μ_n が w^m ≠ 1 を満たすならば
#       S_{n,m} = Σ_{z ∈ μ_n} z^m = 0 である。
#
# 人手証明は準備 2 つ（μ_n の有限性・w^m - 1 ≠ 0）と 4 段の鎖
# (w^m - 1) S_{n,m} = w^m S - 1·S = w^m S - S = S - S = 0、
# そこへ「積が零元ならば零元でない方で割れる」を当てる段からなる。
# 各段に対応させて厳密計算（QQbar）で確かめる。浮動小数点は使わない。


def roots_of_unity(n):
    """1 の n 乗根の全体 μ_n を QQbar の中で厳密に列挙する。"""
    return [QQbar.zeta(n) ** k for k in range(n)]


def power_sum(n, m):
    """S_{n,m} = Σ_{z ∈ μ_n} z^m。"""
    total = QQbar(0)
    for z in roots_of_unity(n):
        total += z ** m
    return total


def check_preparation(nmax, mmax):
    print("0. 準備（w^m ≠ 1 ならば w^m - 1 ≠ 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    count = 0
    for n in range(1, nmax + 1):
        for m in range(mmax + 1):
            for w in roots_of_unity(n):
                if w ** m == one:
                    continue
                assert w ** m - one != zero
                count += 1
    print("   通過（n = 1..%d, m = 0..%d, 該当する (n, m, w) %d 組）" % (nmax, mmax, count))


def check_chain(nmax, mmax):
    print("1. 鎖の各段（(w^m-1)S = w^m S - 1·S = w^m S - S = S - S = 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    count = 0
    for n in range(1, nmax + 1):
        for m in range(mmax + 1):
            s = power_sum(n, m)
            for w in roots_of_unity(n):
                if w ** m == one:
                    continue
                # 第 1 段。分配則。
                assert (w ** m - one) * s == w ** m * s - one * s
                # 第 2 段。1 は積の単位元。
                assert w ** m * s - one * s == w ** m * s - s
                # 第 3 段。冪の和の不変性（claim_root_of_unity_power_sum_invariant）。
                assert w ** m * s == s
                assert w ** m * s - s == s - s
                # 第 4 段。同じ元どうしの差は零元。
                assert s - s == zero
                count += 1
    print("   通過（n = 1..%d, m = 0..%d, 該当する (n, m, w) %d 組）" % (nmax, mmax, count))


def check_conclusion(nmax, mmax):
    print("2. 結論（w^m ≠ 1 なる w ∈ μ_n があるとき S_{n,m} = 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    vanishing = 0
    for n in range(1, nmax + 1):
        for m in range(mmax + 1):
            s = power_sum(n, m)
            witnesses = [w for w in roots_of_unity(n) if w ** m != one]
            if witnesses:
                assert s == zero
                vanishing += 1
            else:
                # 対照: 全部の元の m 乗が 1 のとき（n | m のとき）は和は n であり 0 でない。
                assert s == QQbar(n)
                assert n >= 1 and s != zero
    print("   通過（n = 1..%d, m = 0..%d, S = 0 となる (n, m) %d 組）" % (nmax, mmax, vanishing))


def check_hypothesis_needed(nmax, mmax):
    print("3. 仮定が外せないこと（w^m ≠ 1 なる w が無い (n, m) では S = n ≠ 0）: QQbar")
    one = QQbar(1)
    count = 0
    for n in range(1, nmax + 1):
        for m in range(mmax + 1):
            witnesses = [w for w in roots_of_unity(n) if w ** m != one]
            if not witnesses:
                assert m % n == 0
                assert power_sum(n, m) == QQbar(n) != QQbar(0)
                count += 1
    print("   通過（該当する (n, m) %d 組。いずれも m は n の倍数）" % count)


NMAX = 8
MMAX = 17

check_preparation(NMAX, MMAX)
check_chain(NMAX, MMAX)
check_conclusion(NMAX, MMAX)
check_hypothesis_needed(NMAX, MMAX)
print("すべて通過")
