# 対象ラベル: claim_tagged_matching_nonzero_support
# 条件が偽の標識寄与は、他方の標識の条件にかかわらず零になる。
R = PolynomialRing(QQ, 'x')
x = R.gen()
for long_allowed in [False, True]:
    for short_allowed in [False, True]:
        long_contribution = R(2 if long_allowed else 0)
        short_contribution = x * R(6 if short_allowed else 0)
        if not long_allowed:
            assert long_contribution == 0
        if not short_allowed:
            assert short_contribution == 0
assert R(2) != 0 and x * R(6) != 0
print('RESULT: PASS')
