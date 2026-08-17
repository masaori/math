# 対象ラベル: claim_quadratic_positive_cone_pow_closed
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

two = QQbar(2)
R = PolynomialRing(QQbar, "t")
t = R.gen()
s_candidates = (t**2 - two).roots(multiplicities=False)


def representation_product(left, right):
    a, b = left
    c, d = right
    return (a * c + 2 * b * d, a * d + b * c)


def positive(a, b):
    return (
        (a >= 0 and b >= 0 and (a, b) != (QQ(0), QQ(0)))
        or (a > 0 and b < 0 and 2 * b * b < a * a)
        or (a < 0 and b > 0 and a * a < 2 * b * b)
    )


# 三つの条件をそれぞれ満たす正錐の元を含む。
samples = [
    (QQ(1), QQ(0)),
    (QQ(2), QQ(1)),
    (QQ(3), QQ(-1)),
    (QQ(-1), QQ(1)),
]

checked = 0
for s in s_candidates:
    assert s * s == two
    for pair in samples:
        assert positive(*pair)
        xi = QQbar(pair[0]) + QQbar(pair[1]) * s
        rep = (QQ(1), QQ(0))

        # 出発点 xi^0 = 1 と、その表示 (1,0) の正値性。
        assert xi**0 == QQbar(1)
        assert positive(*rep)

        for m in range(0, 9):
            assert QQbar(rep[0]) + QQbar(rep[1]) * s == xi**m
            assert positive(*rep)

            # 一歩: rep(xi^(m+1)) は積の表示で得られ、値は通常の冪と一致する。
            next_rep = representation_product(rep, pair)
            assert QQbar(next_rep[0]) + QQbar(next_rep[1]) * s == xi ** (m + 1)
            assert positive(*next_rep)
            rep = next_rep
            checked += 1

assert checked == len(s_candidates) * len(samples) * 9
print(f"OK: claim_quadratic_positive_cone_pow_closed ({checked} 帰納法ステップ)")
