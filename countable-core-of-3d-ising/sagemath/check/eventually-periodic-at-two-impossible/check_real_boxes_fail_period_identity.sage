# 式ペア: 実データ Z_L(2) に対し、どの周期 p でも Z_L(2)^{#V_{L+p}} ≠ Z_{L+p}(2)^{#V_L}。
#         2 の指数が (L+p)^3 と L^3 で異なることが直接の理由である。
# 帰属: ZZ。有限な冪と 2 の指数だけを使う。
load("_prelude.sage")
values = {L: value for L, value in VALUE_CASES}
box_widths = sorted(values.keys())
for L in box_widths:
    for M in box_widths:
        if M <= L:
            continue
        p = M - L
        left = values[L] ** site_count(M)
        right = values[M] ** site_count(L)
        assert left.valuation(2) == site_count(M)
        assert right.valuation(2) == site_count(L)
        assert site_count(M) > site_count(L)
        assert left != right
print("RESULT: PASS")
