# 対象ラベル: claim_twisted_mode_product_bijection, claim_twisted_mode_product_sum_reindex
# 有限例で直積の像と、複素根の組を添字とする和の一致を厳密検算する。
for L in range(1, 9):
    primitive = QQbar.zeta(2 * L)
    for a in (0, 1):
        horizontal = [primitive**k for k in range(2 * L) if (primitive**k)**L == (-1)**a]
        horizontal_roots = [z for z, multiplicity in (PolynomialRing(QQbar, 'X').gen()**L - (-1)**a).roots(ring=QQbar)]
        for b in (0, 1):
            vertical = [primitive**k for k in range(2 * L) if (primitive**k)**L == (-1)**b]
            vertical_roots = [z for z, multiplicity in (PolynomialRing(QQbar, 'X').gen()**L - (-1)**b).roots(ring=QQbar)]
            source_pairs = [(z, w) for z in horizontal for w in vertical]
            target_pairs = [(z, w) for z in horizontal_roots for w in vertical_roots]
            assert len(source_pairs) == len(target_pairs) == L**2
            assert set(source_pairs) == set(target_pairs)
            F = lambda z, w: z + w + z*w
            assert sum(F(z, w) for z, w in source_pairs) == sum(F(z, w) for z, w in target_pairs)
print('RESULT: PASS')
