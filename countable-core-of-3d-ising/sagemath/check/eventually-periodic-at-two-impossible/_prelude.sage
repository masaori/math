# 対象ラベル: claim_eventually_periodic_at_two_is_impossible
# 本文の三段（法 4 への簡約による奇数因子の取り出し、周期の冪等式からの 2 の指数の分離、
# 偶奇の矛盾）を、実際の自由境界の箱の値と有限な整数標本で検査する。
# 帰属: ZZ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

def site_count(box_width):
    return box_width ** 3

# 値だけで足りるので層転送で一辺 4 の箱まで広げる（全配位の列挙は回らない）。
VALUE_CASES = [
    (L, ZZ(free_partition_value_by_fast_layer_transfer(L, ZZ(2))))
    for L in [ZZ(2), ZZ(3), ZZ(4)]
]
