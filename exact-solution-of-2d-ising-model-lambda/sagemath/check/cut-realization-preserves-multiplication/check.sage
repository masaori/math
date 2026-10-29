# 対象ラベル: claim_cut_realization_preserves_multiplication
# 実代数的数の有限例で、正数の有理挟み込みと積の幅を厳密に照合する。
# 実数上限と任意精度の結論はこの有限検算の対象外である。
examples = [
    (AA(2).sqrt(), AA(3).sqrt()),
    (AA(5).sqrt() / 3, AA(7).sqrt() / 2),
    (AA(1) / 3, AA(5).sqrt()),
]
for a, b in examples:
    M = QQ(max(ceil(a), ceil(b)) + 2)
    for k in range(3, 9):
        n = 2**k
        eta = QQ(3) / n
        ra = QQ(floor(n*a) - 1) / n
        sa = QQ(floor(n*a) + 1) / n
        rb = QQ(floor(n*b) - 1) / n
        sb = QQ(floor(n*b) + 1) / n
        assert 0 < ra < a < sa < M
        assert 0 < rb < b < sb < M
        assert 0 < sa-ra < eta and 0 < sb-rb < eta
        assert AA(ra*rb) < a*b < AA(sa*sb)
        assert sa*sb-ra*rb == (sa-ra)*sb + ra*(sb-rb)
        assert sa*sb-ra*rb < 2*M*eta
        for sign_a, sign_b in [(1, 1), (-1, 1), (1, -1), (-1, -1)]:
            assert (sign_a*a)*(sign_b*b) == (sign_a*sign_b)*(a*b)
print('RESULT: PASS')
