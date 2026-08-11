# 対象ラベル: claim_qbar_no_zero_divisors
#
# 主張: a, b を代数的数とし、a b = 0 かつ a ≠ 0 とすると b = 0 である。
#
# 人手証明の鎖（b = 1 b = (a^{-1} a) b = a^{-1}(a b) = a^{-1} 0 = 0）の各段に対応させて、
# 厳密計算（QQbar・2 次整数行列環）で確かめる。浮動小数点は使わない。


def check_chain(samples, nmax_unused=None):
    print("1. 鎖の各段（b = 1 b = (a^{-1} a) b = a^{-1}(a b) = a^{-1} 0 = 0）: QQbar")
    one = QQbar(1)
    zero = QQbar(0)
    for a in samples:
        if a == zero:
            continue
        ainv = one / a
        # 準備。a ≠ 0 なので a^{-1} a = 1。
        assert ainv * a == one
        for b in samples:
            if a * b != zero:
                continue
            # 第 1 段。1 は積の単位元。
            assert b == one * b
            # 第 2 段。準備で取った a^{-1} の性質。
            assert one * b == (ainv * a) * b
            # 第 3 段。積の結合則。
            assert (ainv * a) * b == ainv * (a * b)
            # 第 4 段。仮定 a b = 0。
            assert ainv * (a * b) == ainv * zero
            # 第 5 段。零元との積は零元。
            assert ainv * zero == zero
            # 主張そのもの。
            assert b == zero
    print("   通過")


def check_claim(samples):
    print("2. 主張そのもの（a b = 0 かつ a ≠ 0 ならば b = 0）: QQbar")
    zero = QQbar(0)
    count = 0
    for a in samples:
        for b in samples:
            if a != zero and a * b == zero:
                assert b == zero
                count += 1
    print("   通過（仮定を満たす組 %d 件）" % count)


def check_needs_hypothesis(samples):
    print("3. 仮定 a ≠ 0 が要ること: QQbar")
    zero = QQbar(0)
    # a = 0 なら a b = 0 はどんな b でも成り立つので、b = 0 は出ない。
    witnesses = [b for b in samples if b != zero and QQbar(0) * b == zero]
    assert len(witnesses) > 0
    print("   通過（a = 0 のとき a b = 0 だが b ≠ 0 である反例が %d 件）" % len(witnesses))


def check_noncommutative():
    print("4. 必要十分版の仮定の裏取り（可換でない環でも、左逆元を持つ a については通ること）")
    R = MatrixSpace(ZZ, 2, 2)
    one = R.one()
    zero = R.zero()
    # 左逆元を持つ元（行列式が ±1 なので整数行列の中で逆元を持つ）。
    invertibles = [
        R([[0, -1], [1, 0]]),
        R([[1, 1], [0, 1]]),
        R([[2, 1], [1, 1]]),
    ]
    assert invertibles[0] * invertibles[1] != invertibles[1] * invertibles[0]
    others = [zero, one, R([[1, 0], [0, 0]]), R([[0, 1], [0, 0]])]
    for a in invertibles:
        ainv = a.inverse()
        assert ainv * a == one
        for b in invertibles + others:
            if a * b == zero:
                assert b == zero
    print("   通過（2 次整数行列環）")


def check_zero_divisor_ring():
    print("5. 左逆元が無いと結論が出ないこと（零因子を持つ環での反例）")
    R = MatrixSpace(ZZ, 2, 2)
    zero = R.zero()
    a = R([[1, 0], [0, 0]])   # 左逆元を持たない（行列式 0）
    b = R([[0, 0], [0, 1]])
    assert a * b == zero
    assert a != zero and b != zero
    print("   通過（a b = 0 かつ a ≠ 0 でも b ≠ 0 でありうる）")


print("=== claim_qbar_no_zero_divisors ===")
QBAR_SAMPLES = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(1) / QQbar(3),
    QQbar.zeta(3),
    QQbar.zeta(5) ** 2,
    QQbar(2).sqrt(),
    QQbar(-1).sqrt(),
    QQbar.zeta(3) - QQbar(1),
]
check_chain(QBAR_SAMPLES)
check_claim(QBAR_SAMPLES)
check_needs_hypothesis(QBAR_SAMPLES)
check_noncommutative()
check_zero_divisor_ring()
print("すべて通過")
