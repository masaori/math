# 対象ラベル: claim_qbar_poly_linear_factor_product_extract

R.<t> = PolynomialRing(QQbar)


def linear_factor_product(values):
    value = R.one()
    for w in values:
        value *= t - w
    return value


def extract_remaining_factor(samples, j, i):
    """本文の帰納法どおりに残りの因子 B を構成する（i < j を仮定する）。"""
    assert i < j
    if i == j - 1:
        # 場合 i = j-1（帰納法の一歩で「最後の因子」を取り出す場合）
        return linear_factor_product(samples[:j - 1])
    # 場合 i ≠ j-1: 帰納法の仮定で j-1 個の積から取り出し、最後の因子を掛ける
    return extract_remaining_factor(samples, j - 1, i) * (t - samples[j - 1])


def main():
    print("1. 帰納法の出発点と一歩を確かめる")
    samples = [QQbar(2), QQbar(-3), QQbar.zeta(3), QQbar(2), QQbar.zeta(5)]
    assert linear_factor_product([]) == 1
    for j in range(len(samples)):
        previous = linear_factor_product(samples[:j])
        current = linear_factor_product(samples[:j + 1])
        assert current == previous * (t - samples[j])
    print("   通過")

    print("2. 各番号の因子を先頭へ取り出せることを確かめる")
    for j in range(1, len(samples) + 1):
        product = linear_factor_product(samples[:j])
        for i in range(j):
            remaining = samples[:i] + samples[i + 1:j]
            B = linear_factor_product(remaining)
            assert product == (t - samples[i]) * B
    print("   通過")

    print("3. 本文の帰納法どおりに構成した残りの因子 B が分解を満たすことを確かめる")
    for j in range(1, len(samples) + 1):
        product = linear_factor_product(samples[:j])
        for i in range(j):
            B = extract_remaining_factor(samples, j, i)
            assert product == (t - samples[i]) * B
    print("   通過")

    print("4. 残りの因子 B の係数が番号 j-1 より上で零であることを確かめる")
    for j in range(1, len(samples) + 1):
        for i in range(j):
            B = extract_remaining_factor(samples, j, i)
            for l in range(j, j + 4):
                assert B[l] == 0
            # 上界が過大でないこと: 番号 j-1 の係数は 1（モニックな j-1 個の一次因子の積）
            assert B[j - 1] == 1
    print("   通過")
    print("すべて通過")


main()
