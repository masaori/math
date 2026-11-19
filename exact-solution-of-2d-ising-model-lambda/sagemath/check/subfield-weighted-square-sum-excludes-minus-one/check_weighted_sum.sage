# 対象ラベル: claim_subfield_weighted_square_sum_excludes_minus_one
# 有限和の帰納段で「零または正」の閉性を検査する。
from itertools import product
coefficients = [QQ(1)/2, QQ(1), QQ(3)/2]
values = [QQ(-2), QQ(0), QQ(3)/2]
for length in range(4):
    for cs in product(coefficients, repeat=length):
        for ys in product(values, repeat=length):
            terms = [cs[i]*ys[i]*ys[i] for i in range(length)]
            assert all(term == 0 or term > 0 for term in terms)
            total = sum(terms, QQ(0))
            assert total == 0 or total > 0
            assert total != -1
print('PASS: weighted square sums')
