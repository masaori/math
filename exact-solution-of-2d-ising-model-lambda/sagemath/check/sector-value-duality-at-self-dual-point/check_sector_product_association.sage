# 対象ラベル: claim_sector_value_duality_at_algebraic_point
# 本文の新しい行: 三因子の結合則。
# 帰属: QQbar。浮動小数点を使わない。
points = (QQbar(1) / 2, QQbar(2).sqrt() - 1, QQbar(-2).sqrt() + 2)
checks = 0
for L in (1, 2, 3):
    for k in range(2 * L * L + 1):
        for xi in points:
            dual = (1 - xi) * (1 + xi) ** (-1)
            p = (1 + xi) ** (2 * L * L - k)
            q = (1 + xi) ** k
            r = dual ** k
            assert p * q * r == (p * q) * r
            checks += 1
print('RESULT: PASS', checks)
