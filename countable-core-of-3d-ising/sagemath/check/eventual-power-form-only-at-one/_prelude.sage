# 対象ラベル: claim_eventual_power_form_only_at_one
# 本文の三段（候補の三点への絞り込み、有理点 2 分の 1 と 2 の排除、有理点 1 での逆向き）を、
# 実際の自由境界の箱の分配多項式と有限な整数標本で検査する。
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

CANDIDATE_POINTS = [QQ(1) / QQ(2), QQ(1), QQ(2)]

# 係数まで要る検査は全配位を列挙できる一辺 2 の箱で行う。
COEFFICIENT_CASES = []
for L in [ZZ(2)]:
    Z = partition_polynomial_by_enumeration(L, free_box_edges(L))
    COEFFICIENT_CASES.append((L, ZZ(len(free_box_edges(L))), Z))

# 有理点 2 の値だけで足りる検査は層転送で一辺 3 の箱まで広げる（列挙は 2^{27} 通りで回らない）。
VALUE_AT_TWO_CASES = [(L, ZZ(free_partition_value_by_fast_layer_transfer(L, ZZ(2)))) for L in [ZZ(2), ZZ(3)]]

# 有理点 1 の値は層転送で一辺 4 の箱まで広げる。
VALUE_AT_ONE_CASES = [(L, ZZ(free_partition_value_by_fast_layer_transfer(L, ZZ(1)))) for L in [ZZ(1), ZZ(2), ZZ(3), ZZ(4)]]

# 底の候補は有限標本にとどめる（無限の探索はしない）。
BASE_SAMPLES = [ZZ(1), ZZ(2), ZZ(3), ZZ(5), ZZ(7), ZZ(12), QQ(1) / QQ(2), QQ(3) / QQ(2)]
