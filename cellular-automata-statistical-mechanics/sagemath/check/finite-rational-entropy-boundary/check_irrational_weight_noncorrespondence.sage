# 対象ラベル: claim_finite_real_distribution_not_always_rational
# 式ペア: r(b0)=sqrt(2)/2、r(b1)=1-sqrt(2)/2 は正規化されるが有理数の標準実数像にない。
# 帰属: 実代数的数体 AA。無理数重みを選ぶ箇所で実数へ脱出する。浮動小数点、実対数、極限は使わない。
x = polygen(QQ)
left_weight = AA(2).sqrt() / AA(2)
right_weight = AA(1) - left_weight

assert left_weight > 0
assert right_weight > 0
assert left_weight + right_weight == AA(1)
assert left_weight.minpoly().degree() == 2
assert right_weight.minpoly().degree() == 2
assert left_weight not in QQ
assert right_weight not in QQ
assert (AA(2) * left_weight) ** 2 == AA(2)
print('irrational binary probability distributions checked:', ZZ(1))
print('irrational weights excluded from the rational image:', ZZ(2))
print('RESULT: PASS')
