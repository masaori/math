# 対象ラベル: claim_qbar_unit_sum_eq_rational


def unit_sum(n):
    """体 QQbar の積の単位元 1 を n 個足す有限和（空の和は 0）。"""
    total = QQbar(0)
    for _ in range(n):
        total = total + QQbar(1)
    return total


def main():
    print("1. 出発点: 空の有限和は QQbar の加法の単位元であり、自然数 0 に一致する")
    assert unit_sum(0) == QQbar(0)
    assert QQbar(0) == QQbar(QQ(0))
    assert QQ(0) == 0
    print("   通過")

    print("2. 帰納法の一歩: 各行の等号を n = 0..8 で確かめる")
    for n in range(0, 9):
        s = unit_sum(n)
        # 有限和から添字 i=n の項を分ける
        assert unit_sum(n + 1) == s + QQbar(1)
        # 帰納法の仮定（n の段の主張）
        assert s == QQbar(n)
        # QQbar の加法は部分体 QQ の加法の制限であり、自然数の和と一致する
        assert QQbar(n) + QQbar(1) == QQbar(QQ(n) + QQ(1))
        assert QQ(n) + QQ(1) == QQ(n + 1)
    print("   通過")

    print("3. 主張: sum_{i<n} 1 = n を n = 0..12 で確かめる")
    for n in range(0, 13):
        assert unit_sum(n) == QQbar(n)
    print("   通過")
    print("すべて通過")


main()
