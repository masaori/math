# 対象ラベル: claim_gauge_pair_weight_nonzero
# 四つの方向と二つのねじれ指示子の全組合せを円分体で検算する。
F = CyclotomicField(8)
z = F.gen()
assert z**4 == -1
assert z != 0

checked = 0
for re in range(4):
    for rf in range(4):
        for ke in range(2):
            for kf in range(2):
                # p=-r, q=-2k は本文の対角ゲージの整数指数。
                pe, qe = -ZZ(re), -2 * ZZ(ke)
                pf, qf = -ZZ(rf), -2 * ZZ(kf)
                factors = (z**2, z**(-qe), z**(-pe), z**pf, z**qf)
                assert all(factor != 0 for factor in factors)
                left_pair = factors[1] * factors[2]
                right_pair = factors[3] * factors[4]
                assert left_pair != 0
                assert right_pair != 0
                assert left_pair * right_pair != 0
                weight = factors[0] * ((factors[1] * factors[2]) *
                                       (factors[3] * factors[4]))
                assert weight == factors[0] * (left_pair * right_pair)
                assert weight != 0
                checked += 1

print("RESULT: PASS; %d exact gauge weights" % checked)
