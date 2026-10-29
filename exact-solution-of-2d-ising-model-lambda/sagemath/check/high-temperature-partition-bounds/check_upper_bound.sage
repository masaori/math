# 対象ラベル: claim_high_temperature_partition_bounds
# 四項の三角不等式と最大値による上界を有理数で検算する。
from itertools import product

for terms in product((QQ(-5), QQ(-1)/7, QQ(2)/3, QQ(4)), repeat=4):
    maximum = max(map(abs, terms))
    partition = sum(terms)/2
    assert partition <= sum(map(abs, terms))/2
    assert sum(map(abs, terms))/2 <= 2*maximum
print('RESULT: PASS upper bound')
