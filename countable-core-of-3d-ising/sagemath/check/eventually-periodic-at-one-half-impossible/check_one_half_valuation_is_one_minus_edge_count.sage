# 式ペア: Z_M(2) の素因子 2 の指数が 1 であることと、
#         そこから従う Z_M(1/2) の素因子 2 の指数 1 - #E_M。
# 帰属: ZZ と QQ。有限の整数計算だけを使う。
load("_prelude.sage")
for L in BOX_WIDTHS:
    edge_count = free_edge_count(L)
    assert VALUE_AT_TWO[L].valuation(2) == ZZ(1)
    assert VALUE_AT_ONE_HALF[L].valuation(2) == ZZ(1) - edge_count
print("RESULT: PASS")
