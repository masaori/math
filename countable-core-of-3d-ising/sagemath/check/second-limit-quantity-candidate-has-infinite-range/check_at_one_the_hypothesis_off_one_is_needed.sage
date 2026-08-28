# 対象ラベル: claim_second_limit_quantity_candidate_has_infinite_range
# 仮定 q≠1 が落とせないことの裏取り。有理点 1 では有限箱の量の値の集合は一点であり、
# 無限集合ではない。したがって q≠1 を外すと主張は偽になる。
# 値の一致は交差冪の有理数等式で判定する（根を作らない）。
load("_prelude.sage")

ok = True

for L in SAMPLE_BOX_SIZES:
    for Lprime in SAMPLE_BOX_SIZES:
        if not finite_box_values_agree(L, Lprime, QQ(1)):
            ok = False
            print("FAIL: 有理点 1 で一辺 %s と %s の量が一致しない" % (L, Lprime))

for L in SAMPLE_BOX_SIZES:
    if partition_value(L, QQ(1)) != QQ(2) ** vertex_count(L):
        ok = False
        print("FAIL: 有理点 1 で Z_%s(1) が 2 の点数乗でない" % L)

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
