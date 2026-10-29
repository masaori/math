# 対象ラベル: claim_cut_realization_preserves_addition
# 実代数的数の有限例で、有理挟み込みと和の順序を厳密に検算する。
# 実数上限と任意精度の極限をこの有限検算は証明しない。
examples = [
    (AA(2).sqrt(), -AA(3).sqrt()),
    (AA(5).sqrt(), AA(7).sqrt()),
    (AA(-3)/2, AA(4)/3),
]
for a, b in examples:
    for k in range(1, 7):
        epsilon = QQ(1) / (2**k)
        n = 2**(k + 2)
        ra = QQ(floor(n*a) - 1) / n
        sa = QQ(floor(n*a) + 1) / n
        rb = QQ(floor(n*b) - 1) / n
        sb = QQ(floor(n*b) + 1) / n
        assert AA(ra) < a < AA(sa)
        assert AA(rb) < b < AA(sb)
        assert 0 < sa-ra < epsilon
        assert 0 < sb-rb < epsilon
        assert AA(ra+rb) < a+b < AA(sa+sb)
        assert (sa+sb)-(ra+rb) < 2*epsilon
print('RESULT: PASS')
