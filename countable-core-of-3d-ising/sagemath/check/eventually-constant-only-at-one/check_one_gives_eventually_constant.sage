# 対象ラベル: claim_eventually_constant_only_at_one
# 合成の「有理点 1 ならば末尾定数」の向き。
# Z_L(1) = 2^{#V_L} なので、点数乗表示が底 2 で全ての箱に成り立ち、隣接箱の冪等式も成り立つ。
# したがって有限箱の量の列は（閾値 1 以後）値 2 の定数列である。
load("_prelude.sage")

ok = True

for L in BOX_SIZES_AT_ONE:
    ZL = ZZ(free_partition_value_by_fast_layer_transfer(L, QQ(1)))
    expected = ZZ(2) ** vertex_count(L)
    if ZL != expected:
        ok = False
        print("FAIL: L=%s で Z_L(1)=%s だが 2^{#V_L}=%s" % (L, ZL, expected))

for L in [ZZ(1)]:
    if not cross_power_identity_holds(L, QQ(1)):
        ok = False
        print("FAIL: L=%s で有理点 1 の冪等式が成り立たない" % L)

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
