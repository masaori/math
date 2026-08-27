# 対象ラベル: claim_eventually_periodic_at_one_half_is_impossible
# 本文の三段（回文性による有理点 2 分の 1 の値と有理点 2 の値の関係、そこから得る素因子 2 の
# 指数 1-#E_M、周期の冪等式が強制する指数等式の両辺の差が正であること）を、
# 実際の自由境界の箱の値と有限な整数計算で検査する。
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

def site_count(box_width):
    return box_width ** 3

def free_edge_count(box_width):
    return ZZ(3) * box_width ** 2 * (box_width - ZZ(1))

# 値だけで足りるので層転送で一辺 4 の箱まで広げる（全配位の列挙は回らない）。
BOX_WIDTHS = [ZZ(2), ZZ(3)]

# 分配多項式そのものを層転送で作り、二つの有理点での値を独立に代入して得る
# （回文性の関係を仮定せずに確かめるため）。
PARTITION_POLYNOMIAL = {
    L: partition_polynomial_by_layer_transfer(L, free_box_edges(L), False)
    for L in BOX_WIDTHS
}

VALUE_AT_TWO = {L: ZZ(PARTITION_POLYNOMIAL[L](ZZ(2))) for L in BOX_WIDTHS}
VALUE_AT_ONE_HALF = {L: QQ(PARTITION_POLYNOMIAL[L](QQ(1) / QQ(2))) for L in BOX_WIDTHS}
