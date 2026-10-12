# 対象ラベル: claim_quadratic_positive_cone_nat_mul
# ZZ / QQ / QQbar で計算し、浮動小数点を使わない。
def _pn_positive(a, b):
    return ((0 <= a and 0 <= b and (a, b) != (0, 0)) or
            (0 < a and b < 0 and 2 * b * b < a * a) or
            (a < 0 and 0 < b and a * a < 2 * b * b))


def _pn_member(value, pair, s):
    a, b = pair
    assert a.parent() is QQ and b.parent() is QQ
    assert value.parent() is QQbar and s.parent() is QQbar
    return value == QQbar(a) + QQbar(b) * s


def _pn_rows():
    ring = PolynomialRing(QQ, 't')
    roots = (ring.gen()**2 - 2).roots(QQbar, multiplicities=False)
    assert len(roots) == 2
    samples = [(QQ(1), QQ(0)), (QQ(2), QQ(1)), (QQ(3), QQ(-1)), (QQ(-1), QQ(1))]
    for s in roots:
        assert s * s == QQbar(2)
        for a, b in samples:
            assert _pn_positive(a, b)
            xi = QQbar(a) + QQbar(b) * s
            for c in [ZZ(0), ZZ(1), ZZ(2), ZZ(3), ZZ(5), ZZ(7)]:
                q = QQ(c)
                value = QQbar(q) * xi
                pair = (q * a, q * b)
                if c == 0:
                    chain = [value, QQbar(QQ(ZZ(0))) * xi, QQbar(QQ(0)) * xi,
                             QQbar(0) * xi, QQbar(0)]
                    for name, left, right in zip(
                            ['zero_substitution', 'natural_zero', 'embedded_zero', 'zero_product'],
                            chain, chain[1:]):
                        yield name, left, right
                    zero = QQbar(0)
                    rep = [zero, zero + zero, zero + zero * s,
                           QQbar(QQ(0)) + zero * s, QQbar(QQ(0)) + QQbar(QQ(0)) * s]
                    for name, left, right in zip(
                            ['zero_add', 'zero_right_product', 'zero_first_embedding', 'zero_second_embedding'],
                            rep, rep[1:]):
                        yield name, left, right
                    yield 'zero_membership', _pn_member(zero, (QQ(0), QQ(0)), s), True
                    yield 'zero_product_membership', _pn_member(value, (QQ(0), QQ(0)), s), True
                else:
                    yield 'natural_positive', ZZ(0) < c, True
                    yield 'rational_positive', QQ(0) < q, True
                    yield 'coefficient_membership', _pn_member(QQbar(q), (q, QQ(0)), s), True
                    yield 'coefficient_positive', _pn_positive(q, QQ(0)), True
                    yield 'positive_product_membership', _pn_member(value, pair, s), True
                    yield 'positive_product', _pn_positive(*pair), True
                yield 'value_bridge', QQbar(pair[0]) + QQbar(pair[1]) * s, value


def _pn_check(selected=None):
    counts = {}
    for name, left, right in _pn_rows():
        if selected is not None and name != selected:
            continue
        assert left == right, (name, left, right)
        counts[name] = counts.get(name, 0) + 1
    assert len(counts) == (17 if selected is None else 1)
    for name, count in counts.items():
        expected = 48 if name == 'value_bridge' else 8 if name.startswith('zero_') or name in ['natural_zero', 'embedded_zero'] else 40
        assert count == expected, (name, count, expected)
    print('PASS:', counts)
    return counts
