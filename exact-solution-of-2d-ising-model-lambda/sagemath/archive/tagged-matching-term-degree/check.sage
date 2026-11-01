from sage.all import QQ, PolynomialRing

# 対象ラベル: claim_tagged_matching_term_degree
# 短い対ごとの一次因子と長い対の定数因子を厳密な多項式として計算する。
R = PolynomialRing(QQ, 'x')
x = R.gen()
for short_count in range(9):
    for long_count in range(9):
        short_weights = [QQ(i + 2) / QQ(i + 3) for i in range(short_count)]
        long_weights = [QQ(i + 3) / QQ(i + 5) for i in range(long_count)]
        sign = (-1) ** short_count
        term = R(sign)
        for weight in long_weights:
            term *= R(weight)
        for weight in short_weights:
            term *= x * R(weight)
        coefficient = QQ(sign)
        for weight in long_weights + short_weights:
            coefficient *= weight
        assert coefficient != 0
        assert term == coefficient * x ** short_count
        assert term.degree() == short_count
print('RESULT: PASS (81 exact polynomial products)')
