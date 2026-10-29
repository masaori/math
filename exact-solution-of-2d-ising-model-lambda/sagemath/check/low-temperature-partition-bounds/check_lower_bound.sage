# 対象ラベル: claim_low_temperature_partition_bounds
# 本文の下界を有理数の四項和で検算する。
from itertools import product

for terms in product((QQ(1)/7, QQ(2)/3, QQ(5)), repeat=4):
    maximum = max(terms)
    half_sum = sum(terms) / 2
    assert maximum / 2 <= half_sum
print('RESULT: PASS lower bound')
