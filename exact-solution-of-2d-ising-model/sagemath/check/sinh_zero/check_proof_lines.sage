# 対象ラベル: sinh_zero
# 証明の鎖 sinh 0 = (exp(0)-exp(-0))/2 = (exp(0)-exp(0))/2 = (1-1)/2 = 0 の四行を確かめる。
# 帰属: すべて QQ で厳密。exp(0) は本文の 1 行 1 列の行列の exp の成分で、部分和 S_N([0]) の成分が N によらず 1 に
#   等しいこと（N = 0,…,30）を確かめる（極限は定数列の極限なので 1）。exp の値を不定元に置いた形でも各行を確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
assert -QQ(0) == QQ(0)
for N in range(31):
    assert entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), N)) == 1
R = PolynomialRing(QQ, 'E0,Em0'); E0, Em0 = R.gens()
line1 = sinh_by_definition(E0, Em0)          # (exp(0) - exp(-0))/2
line2 = sinh_by_definition(E0, E0)           # -0 = 0 で exp(-0) は exp(0) と同じ値
assert line1 != line2                         # 対照: 2 行目は引数の等号 -0 = 0 を使う
assert line2 == 0                             # exp(0) の値によらず (E0 - E0)/2 = 0
line3 = (QQ(1) - QQ(1)) / 2
assert line2.subs(E0=1) == line3 == 0
assert exp_ball(0).contains_exact(1) and sinh_ball(0).contains_exact(0)
print("-0 = 0、部分和 S_N([0]) の成分が N ≤ 30 で 1、四行が QQ で厳密に一致し、ボールでも sinh 0 は 0 を含む")
print("RESULT: PASS")
