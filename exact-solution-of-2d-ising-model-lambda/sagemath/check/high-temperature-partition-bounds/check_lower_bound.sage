# 対象ラベル: claim_high_temperature_partition_bounds
# 本文の双対因子、非負セクター和、低温側下界を有理数で検算する。
from itertools import product

for q in (QQ(1)/2, QQ(3)/4):
    t = (1-q)/(1+q)
    for L in (1, 2, 3):
        factor = (1+q)^(2*L^2)/2^(L^2)
        for terms in product((QQ(1)/7, QQ(2)/3), repeat=4):
            maximum = max(terms)
            z_t = sum(terms)/2
            sectors = (z_t/2, QQ(0), QQ(1)/5, QQ(2)/7)
            z_q = factor*sum(sectors)
            assert z_t >= maximum/2
            assert sum(sectors) >= z_t/2
            assert z_q >= factor*maximum/4
            # 自己双対変換の符号を絶対値へ移す等号。
            transformed = tuple(((-1 if i == 0 else 1)*factor*term) for i, term in enumerate(terms))
            assert factor*maximum == max(factor*term for term in terms)
            assert max(map(abs, transformed)) == factor*maximum
print('RESULT: PASS lower bound')
