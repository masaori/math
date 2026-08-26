# 対象ラベル: claim_eventually_constant_only_at_one
# 本文は三つの同値（末尾定数性 ⇔ 隣接箱の冪等式の末尾成立 ⇔ 正の有理数の点数乗表示の末尾成立
# ⇔ 有理点 1）の合成である。合成の両端を、実際の自由境界の箱の分配多項式の値で検査する。
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

# 頂点数 #V_L = L^3。
def vertex_count(L):
    return ZZ(L) ** ZZ(3)

# 隣接する二つの箱の冪等式 Z_L(q)^{#V_{L+1}} = Z_{L+1}(q)^{#V_L}（QQ の等式）。
PARTITION_POLYNOMIAL = {}
for L in [ZZ(1), ZZ(2)]:
    PARTITION_POLYNOMIAL[L] = partition_polynomial_by_enumeration(L, free_box_edges(L))

def cross_power_identity_holds(L, q):
    ZL = QQ(PARTITION_POLYNOMIAL[ZZ(L)](QQ(q)))
    ZL1 = QQ(PARTITION_POLYNOMIAL[ZZ(L) + 1](QQ(q)))
    return ZL ** vertex_count(L + 1) == ZL1 ** vertex_count(L)

# 有理点 1 では箱の大きさを 4 まで広げる（層転送で値だけ求める）。
BOX_SIZES_AT_ONE = [ZZ(1), ZZ(2), ZZ(3), ZZ(4)]

# 有理点 1 以外の標本。冪等式は値の桁が急速に伸びるので一辺 1 と 2 の組で見る。
OFF_ONE_SAMPLES = [QQ(1) / QQ(2), QQ(2), QQ(3), QQ(1) / QQ(3), QQ(3) / QQ(2), QQ(2) / QQ(3)]
