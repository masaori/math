# 対象ラベル: claim_qbar_repeated_sum_ne_zero


def repeated_sum(a, n):
    """同じ元 a を n 個足す有限和。"""
    return sum((a for _ in range(n)), QQbar(0))


def unit_sum(n):
    """体 QQbar の積の単位元 1 を n 個足す有限和。"""
    return sum((QQbar(1) for _ in range(n)), QQbar(0))


def main():
    samples = [
        QQbar(1),
        QQbar(-2),
        QQbar(3) / QQbar(7),
        QQbar(2).sqrt(),
        QQbar(-1).sqrt(),
        QQbar.zeta(5),
        QQbar(2).sqrt() - QQbar(1),
    ]

    print("1. 証明の鎖（積への分解・単位元の和の非零性・積の非零性）を確かめる")
    for a in samples:
        assert a != QQbar(0)
        for n in range(1, 9):
            s = repeated_sum(a, n)
            u = unit_sum(n)
            assert s == u * a
            assert u != QQbar(0)
            assert s != QQbar(0)
    print("   通過")

    print("2. a != 0 の仮定を外すと a = 0 で結論が破れる")
    for n in range(1, 9):
        assert repeated_sum(QQbar(0), n) == QQbar(0)
    print("   通過")

    print("3. n >= 1 の仮定を外すと n = 0 で結論が破れる")
    for a in samples:
        assert repeated_sum(a, 0) == QQbar(0)
    print("   通過")
    print("すべて通過")


main()
