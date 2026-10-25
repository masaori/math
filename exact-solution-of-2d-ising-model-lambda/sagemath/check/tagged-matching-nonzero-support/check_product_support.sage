# 対象ラベル: claim_tagged_matching_nonzero_support
# 非零な有限積では、選んだ各標識の寄与が非零である。
from itertools import product
R = PolynomialRing(QQ, 'x')
x = R.gen()
for allowed in product([False, True], repeat=4):
    for labels in product([False, True], repeat=4):
        factors = [R(2) if a else R(0) for a, short in zip(allowed, labels) if not short]
        factors += [x * R(3) if a else R(0) for a, short in zip(allowed, labels) if short]
        term = prod(factors, R.one())
        if term != 0:
            assert all(allowed)
print('RESULT: PASS')
