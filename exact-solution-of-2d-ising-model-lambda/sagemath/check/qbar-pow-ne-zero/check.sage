# 対象ラベル: claim_qbar_pow_ne_zero


def main():
    values = [QQbar(1), QQbar(-1), QQbar(2), QQbar(1) / 3, QQbar.gen(), QQbar(-1).sqrt()]

    print("1. 出発点: w^0 = 1 != 0")
    for w in values:
        assert w != 0
        assert w**0 == 1
        assert w**0 != 0
    print("   通過")

    print("2. 帰納法の一歩: w^k*w = w^(k+1)、左因子が非零なら右因子は零にならない")
    for w in values:
        for k in range(0, 9):
            assert w**k != 0
            assert w**k * w == w ** (k + 1)
            assert w ** (k + 1) != 0
    print("   通過")

    print("3. 主張: 零でない代数的数の自然数冪は零でない")
    for w in values:
        for n in range(0, 10):
            assert w**n != 0
    print("   通過")
    print("すべて通過")


main()
