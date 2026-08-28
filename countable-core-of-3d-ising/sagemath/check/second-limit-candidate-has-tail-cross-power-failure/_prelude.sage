# 対象ラベル: claim_second_limit_candidate_has_tail_cross_power_failure
# 本文は「q≠1 で極限量を持つなら、任意の閾値 K の先に Z_L(q)^{M^3} ≠ Z_M(q)^{L^3} となる二箱がある」。
# 無限個の閾値にわたる全称は有限検査の対象外なので、確かめられるのは次の二つである。
#   (1) 小さい閾値について、証拠となる二箱の組が実際に有理数の不等式として見つかること
#   (2) 有理点 1 では同じ二箱に破れが無く、仮定 q≠1 が落とせないこと
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

def vertex_count(L):
    return ZZ(L) ** ZZ(3)

PARTITION_POLYNOMIAL = {}
for L in [ZZ(1), ZZ(2)]:
    PARTITION_POLYNOMIAL[L] = partition_polynomial_by_enumeration(L, free_box_edges(L))

def partition_value(L, q):
    return QQ(PARTITION_POLYNOMIAL[ZZ(L)](QQ(q)))

# 交差冪等式 Z_L(q)^{#V_M} = Z_M(q)^{#V_L}。破れとはこの等式が成り立たないことである。
def cross_power_identity_holds(L, M, q):
    return partition_value(L, q) ** vertex_count(M) == partition_value(M, q) ** vertex_count(L)

# 全配位を列挙できる箱は一辺 1 と 2 だけなので、証拠として使える二箱の組はこれだけである。
AVAILABLE_BOX_PAIRS = [(ZZ(1), ZZ(2))]

# 上の組が L,M >= max{K,1} を満たす閾値。
THRESHOLDS = [ZZ(0), ZZ(1)]

OFF_ONE_SAMPLES = [QQ(1) / QQ(2), QQ(2), QQ(3), QQ(1) / QQ(3), QQ(3) / QQ(2), QQ(2) / QQ(3), QQ(4), QQ(1) / QQ(4)]
