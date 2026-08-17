# 対象ラベル: claim_quadratic_positive_cone_nat_mul
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


# 三つの条件をそれぞれ満たす正錐の元を含む（pow の検証と同じ代表）。
samples = [
    (QQ(1), QQ(0)),
    (QQ(2), QQ(1)),
    (QQ(3), QQ(-1)),
    (QQ(-1), QQ(1)),
]

# 零を含む自然数の代表。
nat_values = [0, 1, 2, 3, 5, 7]

checked = 0
for s in s_candidates:
    assert s * s == two
    for pair in samples:
        assert positive(*pair)
        xi = QQbar(pair[0]) + QQbar(pair[1]) * s

        for c in nat_values:
            # c の表示は (c, 0)。積の表示は representation_product で得る。
            prod_rep = representation_product((QQ(c), QQ(0)), pair)
            value = QQbar(c) * xi

            # c·ξ ∈ Q_s: 表示の値が Qbar の通常の積に一致する（証人の確認）。
            assert QQbar(prod_rep[0]) + QQbar(prod_rep[1]) * s == value

            if c == 0:
                # c = 0 の場合: 値は Qbar の零元で、表示は (0, 0)。
                assert value == QQbar(0)
                assert prod_rep == (QQ(0), QQ(0))
                assert not positive(*prod_rep)
            else:
                # 1 ≤ c の場合: c は正の有理数として正錐に入り、積も正錐に入る。
                assert QQ(c) > 0
                assert positive(QQ(c), QQ(0))
                assert positive(*prod_rep)
            checked += 1

assert checked == len(s_candidates) * len(samples) * len(nat_values)
print(f"OK: claim_quadratic_positive_cone_nat_mul ({checked} 組)")
