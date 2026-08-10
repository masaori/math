# 対象ラベル: claim_root_of_unity_divisor
#   併せて確かめる定義: def_algebraic_numbers / def_root_of_unity_set
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「約数を指数として 1 になる代数的数は、その倍数を指数としても 1 になる」
# （d | n ならば mu_d ⊂ mu_n）を、小さい d と n で総当たりに確かめる。
#
# 計算はすべて円分体 QQ(zeta_m) の中の厳密計算で行う（浮動小数点は使わない）。
# QQ(zeta_m) は QQbar の部分体であり、1 の m 乗根の全体 mu_m はこの中に収まる
# （x^m - 1 の根がすべて zeta_m の冪だからである）。したがって mu_d の全列挙が
# 有限個の厳密な元の列挙として行える。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. mu_d の作り方が定義どおりであること。zeta_d の冪として作った d 個の元が
#      ちょうど x^d - 1 の根の全体であり、どれも d 乗すると 1 になること。
#   2. 鎖の第 1 段。n = d k と取れること（d | n）。
#   3. 鎖の第 2〜4 段。z in mu_d について z^n = (z^d)^k = 1^k = 1 であること。
#      各段を別々の等式として確かめる（1 行ずつ突き合わせる）。
#   4. 主張そのもの。mu_d ⊂ mu_n。
#   5. 主張が空虚でないこと。mu_d が 2 元以上ある（1 だけではない）組が実際にあること。
#   6. 仮定 d | n が外せないこと。d が n を割らないときは、mu_d の中に z^n != 1 と
#      なる元が実際に存在すること。
#
# 走らせる範囲（打ち切りを隠さない）。
#   d = 1,...,8 と n = 1,...,24 のすべての組（192 組）について、d | n の組で 1〜4 を、
#   d が n を割らない組で 6 を確かめる。
#   本文の主張は任意の d, n についてのものなので、有限個で確かめたことは証明ではない。

D_MAX = 8
N_MAX = 24


def roots_of_unity(m):
    """1 の m 乗根の全体 mu_m を、円分体 QQ(zeta_m) の中で全列挙する。"""
    K = CyclotomicField(m) if m >= 3 else QQ
    if m == 1:
        return [QQ(1)]
    if m == 2:
        return [QQ(1), QQ(-1)]
    z = K.gen()
    return [z ** j for j in range(m)]


def check_pair(d, n):
    """d | n の組について、人手証明の各段を確かめる。"""
    assert n % d == 0, (d, n, '呼び出し側の前提が破れている')
    k = n // d

    # 2: 鎖の第 1 段。n = d k。
    assert n == d * k, (d, n, 'n = d k が破れた')

    mu_d = roots_of_unity(d)

    # 1: mu_d が定義どおりであること。
    assert len(mu_d) == d, (d, 'mu_d の元の個数が d と違う')
    assert len(set(mu_d)) == d, (d, 'mu_d に重複がある')
    for z in mu_d:
        assert z ** d == 1, (d, z, 'mu_d の元が d 乗して 1 にならない')

    for z in mu_d:
        # 3: 鎖の各段を 1 つずつ。
        assert z ** n == z ** (d * k), (d, n, z, '第 1 段が破れた')
        assert z ** (d * k) == (z ** d) ** k, (d, n, z, '第 2 段（指数法則）が破れた')
        assert (z ** d) ** k == 1 ** k, (d, n, z, '第 3 段（z^d = 1 の代入）が破れた')
        assert 1 ** k == 1, (k, '第 4 段（単位元の反復積）が破れた')
        # 4: 主張そのもの。z in mu_n。
        assert z ** n == 1, (d, n, z, '主張が破れた')

    return len(mu_d)


def check_not_dvd(d, n):
    """d が n を割らない組について、仮定が外せないことを確かめる。"""
    assert n % d != 0, (d, n, '呼び出し側の前提が破れている')
    mu_d = roots_of_unity(d)
    witnesses = [z for z in mu_d if z ** n != 1]
    assert witnesses, (d, n, 'd が n を割らないのに mu_d ⊂ mu_n が成り立ってしまった')
    return len(witnesses)


def main():
    n_dvd = 0
    n_not_dvd = 0
    sizes = {}
    for d in range(1, D_MAX + 1):
        for n in range(1, N_MAX + 1):
            if n % d == 0:
                sizes[d] = check_pair(d, n)
                n_dvd += 1
            else:
                check_not_dvd(d, n)
                n_not_dvd += 1

    # 5: 主張が空虚でないこと。
    assert any(size >= 2 for size in sizes.values()), (
        'mu_d が 2 元以上ある d が 1 つも無い（主張が空虚）')

    print(f'OK: d | n の組 {n_dvd} 件で mu_d ⊂ mu_n を確かめた')
    print(f'OK: d が n を割らない組 {n_not_dvd} 件で、'
          f'mu_d の中に n 乗して 1 にならない元があることを確かめた（仮定は外せない）')
    print()
    print('| d | mu_d の元の個数 |')
    print('|---|---|')
    for d in sorted(sizes):
        print(f'| {d} | {sizes[d]} |')


main()
