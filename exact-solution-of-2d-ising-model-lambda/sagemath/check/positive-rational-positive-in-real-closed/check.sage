# 対象ラベル: claim_positive_rational_positive_in_real_closed
#
# R のモデルを AA（実代数的数体）に取り、本文の各段を厳密に検査する。
# 浮動小数点は使わない。


def main():
    # 帰納法の各段: n = c·c（c ≠ 0）から n+1 = c·c + 1·1 = e·e（e ≠ 0）。
    c = AA(1)
    assert c != AA(0)
    assert AA(1) == c * c
    for n in range(1, 33):
        e = (c * c + AA(1) * AA(1)).sqrt()
        assert e * e == c * c + AA(1) * AA(1)
        assert e * e == AA(n + 1)
        assert e != AA(0)
        c = e

    # 正の有理数の標本: q = a/b を a = c·c, b = d·d, w = c/d で表し、
    # q = w·w、w ≠ 0、したがって 0 <_R q（差 q−0 が零元でない平方）。
    positive_samples = [QQ(1), QQ(1) / 2, QQ(2) / 3, QQ(5), QQ(7) / 4, QQ(100) / 7]
    for q in positive_samples:
        a = QQ(q.numerator())
        b = QQ(q.denominator())
        assert a >= 1 and b >= 1
        c = AA(a).sqrt()
        d = AA(b).sqrt()
        assert c * c == AA(a)
        assert d * d == AA(b)
        assert c != AA(0) and d != AA(0)
        w = c * (1 / d)
        assert w != AA(0)
        assert AA(q) == w * w
        assert AA(q) - AA(0) == w * w
        assert AA(q) > 0

    # 反例側: 非正の有理数は「零元でない平方」の形にならない
    # （q = 0 は証人が零元になり、q < 0 は −q 側が平方なので三分法の排他性による）。
    assert AA(0) == AA(0) * AA(0)  # 0 の平方表示の証人は 0 しかない
    for q in [QQ(-1), QQ(-3) / 2, QQ(-9)]:
        minus = AA(-q).sqrt()
        assert minus * minus == AA(-q)
        assert minus != AA(0)
        assert AA(q) < 0

    print("正の有理数は実閉部分体で正である: 帰納法の各段と標本を AA で厳密検査して通過", flush=True)


main()
