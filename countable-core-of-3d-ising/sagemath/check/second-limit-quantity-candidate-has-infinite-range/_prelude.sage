# 対象ラベル: claim_second_limit_quantity_candidate_has_infinite_range
# 本文は直前の分類の対偶である（q≠1 で極限量を持つなら値の集合は無限集合）。
# 有限検査で確かめられるのは、対偶の前提が有限標本で既に崩れていること（値の集合が一点でないこと）と、
# 唯一の例外である有理点 1 では値の集合が実際に一点であること、の二つである。
# 帰属: ZZ と QQ。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
load("../../_shared/defs.sage")

# 頂点数 #V_L = L^3。
def vertex_count(L):
    return ZZ(L) ** ZZ(3)

PARTITION_POLYNOMIAL = {}
for L in [ZZ(1), ZZ(2)]:
    PARTITION_POLYNOMIAL[L] = partition_polynomial_by_enumeration(L, free_box_edges(L))

def partition_value(L, q):
    return QQ(PARTITION_POLYNOMIAL[ZZ(L)](QQ(q)))

# 有限箱の量 a_L(q) は Z_L(q) の #V_L 乗根なので、二つの箱の量が等しいことは
# 交差冪の有理数等式 Z_L(q)^{#V_{L'}} = Z_{L'}(q)^{#V_L} と同値である（本文で既出）。
# 根を作らずにこの等式だけで値の一致を判定する（QQ の中で閉じる）。
def finite_box_values_agree(L, Lprime, q):
    return partition_value(L, q) ** vertex_count(Lprime) == partition_value(Lprime, q) ** vertex_count(L)

SAMPLE_BOX_SIZES = [ZZ(1), ZZ(2)]

# 有理点 1 以外の標本。交差冪は値の桁が急速に伸びるので一辺 1 と 2 の組で見る。
OFF_ONE_SAMPLES = [QQ(1) / QQ(2), QQ(2), QQ(3), QQ(1) / QQ(3), QQ(3) / QQ(2), QQ(2) / QQ(3), QQ(4), QQ(1) / QQ(4)]
