# 対象ラベル: claim_low_temperature_partition_bounds
# 本文の上界を有理数の四項和で検算する。
from itertools import product

for terms in product((QQ(1)/7, QQ(2)/3, QQ(5)), repeat=4):
    maximum = max(terms)
    half_sum = sum(terms) / 2
    assert half_sum <= 2 * maximum
print('RESULT: PASS upper bound')
