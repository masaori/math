# 対象ラベル: claim_qbar_repeated_sum_factorization


def repeated_sum(a, n):
    """同じ元 a を n 個足す有限和（空の和は 0）。"""
    total = QQbar(0)
    for _ in range(n):
        total = total + a
    return total


def main():
    values = [QQbar(1), QQbar(-1), QQbar(2), QQbar(1) / 3, QQbar.gen(), QQbar(-1).sqrt()]

    print("1. 出発点: 空の有限和は 0 であり、0 = 0*a")
    for a in values:
        assert repeated_sum(a, 0) == 0
        assert QQbar(0) * a == 0
        assert repeated_sum(a, 0) == repeated_sum(QQbar(1), 0) * a
    print("   通過")

    print("2. 帰納法の一歩: 各行の等号を n = 0..8 で確かめる")
    for a in values:
        for n in range(0, 9):
            s_a = repeated_sum(a, n)
            s_1 = repeated_sum(QQbar(1), n)
            # 有限和から添字 i=n の項を分ける
            assert repeated_sum(a, n + 1) == s_a + a
            # 帰納法の仮定（n の段の主張）
            assert s_a == s_1 * a
            # 1 は積の単位元
            assert s_1 * a + a == s_1 * a + QQbar(1) * a
            # 分配則
            assert s_1 * a + QQbar(1) * a == (s_1 + QQbar(1)) * a
            # 有限和へ添字 i=n の項を合わせる
            assert s_1 + QQbar(1) == repeated_sum(QQbar(1), n + 1)
    print("   通過")

    print("3. 主張: sum_{i<n} a = (sum_{i<n} 1) * a を n = 0..9 で確かめる")
    for a in values:
        for n in range(0, 10):
            assert repeated_sum(a, n) == repeated_sum(QQbar(1), n) * a
    print("   通過")
    print("すべて通過")


main()
