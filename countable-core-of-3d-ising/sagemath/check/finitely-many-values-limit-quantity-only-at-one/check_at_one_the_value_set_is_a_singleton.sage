# 対象ラベル: claim_finitely_many_values_limit_quantity_only_at_one
# 合成の結論側（q=1 では前提が実際に満たされうる）の裏取り。
# 有理点 1 では有限箱の量の値の集合が一点であり、したがって有限集合である。
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
