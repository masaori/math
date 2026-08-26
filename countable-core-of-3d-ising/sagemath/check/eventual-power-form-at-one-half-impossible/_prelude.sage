# 対象ラベル: claim_eventual_power_form_at_one_half_is_impossible
# 本文の三段（回文性による有限箱の等式、辺の個数からの 4 の可除性、法 4 の矛盾）を、
# 実際の自由境界の箱の分配多項式と有限な整数標本で検査する。
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

# 係数まで要る検査は全配位を列挙できる一辺 2 の箱で行う。
COEFFICIENT_CASES = []
for L in [ZZ(2)]:
    Z = partition_polynomial_by_enumeration(L, free_box_edges(L))
    COEFFICIENT_CASES.append((L, ZZ(len(free_box_edges(L))), Z, Z.list()))

# 有理点 2 分の 1 の値まで要る検査は、係数が得られる一辺 2 の箱で行う。
ONE_HALF_CASES = [(L, edge_count, QQ(Z(QQ(1) / QQ(2))), ZZ(Z(2))) for L, edge_count, Z, _ in COEFFICIENT_CASES]

# 有理点 2 の値だけで足りる検査は層転送で一辺 3 の箱まで広げる（列挙は 2^{27} 通りで回らない）。
VALUE_AT_TWO_CASES = [(L, ZZ(len(free_box_edges(L))), ZZ(free_partition_value_by_fast_layer_transfer(L, ZZ(2)))) for L in [ZZ(2), ZZ(3)]]
