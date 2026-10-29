# 対象ラベル: claim_high_temperature_partition_bounds
# 高温点の双対が低温点に属することを有理数の恒等式で検算する。
R.<q> = PolynomialRing(QQ)
t = (1-q)/(1+q)
assert t^2+2*t-1 == ((1-q)/(1+q))^2+2*(1-q)/(1+q)-1
assert ((1-q)/(1+q))^2+2*(1-q)/(1+q)-1 == ((1-q)^2+2*(1-q)*(1+q)-(1+q)^2)/(1+q)^2
assert t^2+2*t-1 == -2*(q^2+2*q-1)/(1+q)^2
for value in (QQ(1)/2, QQ(3)/4, QQ(9)/10):
    assert value^2+2*value-1 > 0
    dual = t(q=value)
    assert 0 < dual < 1 and dual^2+2*dual-1 < 0
print('RESULT: PASS dual point')
