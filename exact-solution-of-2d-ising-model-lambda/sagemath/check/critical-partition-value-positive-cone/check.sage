# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 帰属: ZZ / QQ / QQbar の厳密計算。浮動小数点を使わない。


def positive(a, b):
    return (
        (a >= 0 and b >= 0 and (a, b) != (QQ(0), QQ(0)))
        or (a > 0 and b < 0 and 2 * b * b < a * a)
        or (a < 0 and b > 0 and a * a < 2 * b * b)
    )


def broken_bond_count(config, L):
    def spin(i, j):
        return config[(i % L) * L + (j % L)]

    return sum(
        spin(i, j) != spin(i + 1, j)
        for i in range(L) for j in range(L)
    ) + sum(
        spin(i, j) != spin(i, j + 1)
        for i in range(L) for j in range(L)
    )


checked = 0
for L in (1, 2, 3):
    multiplicities = [ZZ(0)] * (2 * L * L + 1)
    for mask in range(2 ** (L * L)):
        config = tuple(1 if (mask >> k) & 1 else -1 for k in range(L * L))
        multiplicities[broken_bond_count(config, L)] += 1

    assert multiplicities[0] >= 1
    for s in (QQbar(2).sqrt(), -QQbar(2).sqrt()):
        xc = -1 + s
        partial_a = QQ(0)
        partial_b = QQ(0)
        direct = QQbar(0)
        power = QQbar(1)
        for m, coefficient in enumerate(multiplicities):
            term = coefficient * power
            direct += term
            # QQbar.polynomial is not a representation in the basis (1,s), so
            # obtain that representation by expanding (-1+s)^m in QQ[y]/(y^2-2).
            R = PolynomialRing(QQ, "y")
            y = R.gen()
            reduced = (ZZ(coefficient) * (-1 + y) ** m).mod(y ** 2 - 2)
            term_a = reduced[0]
            term_b = reduced[1] if reduced.degree() >= 1 else QQ(0)
            assert QQbar(term_a) + QQbar(term_b) * s == term
            if coefficient == 0:
                assert (term_a, term_b) == (0, 0)
            else:
                assert positive(term_a, term_b)
            partial_a += term_a
            partial_b += term_b
            assert positive(partial_a, partial_b)
            power *= xc

        assert QQbar(partial_a) + QQbar(partial_b) * s == direct
        assert positive(partial_a, partial_b)
        checked += 1

assert checked == 6
print(f"OK: claim_critical_partition_value_mem_positive_cone ({checked} 組)")
