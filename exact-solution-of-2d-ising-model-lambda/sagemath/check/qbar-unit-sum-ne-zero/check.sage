# 対象ラベル: claim_qbar_unit_sum_ne_zero


def unit_sum(n):
    """体 QQbar の積の単位元 1 を n 個足す有限和。"""
    return sum((QQbar(1) for _ in range(n)), QQbar(0))


def main():
    print("1. 前段の等式と非零性への鎖を n = 1..12 で確かめる")
    for n in range(1, 13):
        s = unit_sum(n)
        assert s == QQbar(n)
        assert QQ(n) != QQ(0)
        assert QQbar(n) != QQbar(0)
        assert s != QQbar(0)
    print("   通過")

    print("2. n >= 1 の仮定を外すと n = 0 で結論が破れる")
    assert unit_sum(0) == QQbar(0)
    print("   通過")
    print("すべて通過")


main()
