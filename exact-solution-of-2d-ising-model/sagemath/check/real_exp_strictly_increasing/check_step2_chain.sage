# 対象ラベル: real_exp_strictly_increasing
# Step 2 の鎖を確かめる。
#   exp(y) = exp(x + (y - x)) = exp(x)exp(y - x) > exp(x)·1 = exp(x)
# 帰属: 等号の二行は、x と d := y - x を QQ[x, d] の不定元に置き、形式冪級数として全次数 D 以下で厳密に比べる
# （exp([z]) の D 次の切り捨ては部分和 S_D([z]) の D 次の切り捨てに等しい）。x + (y - x) = y は QQ[x, y] で確かめる。
# 不等号の行は具体の点で本文の exp を囲むボールで確かめる（R への脱出。RealBallField(512)）。
load("../../_shared/one_by_one_matrix.sage")

D = 14
Q2 = PolynomialRing(QQ, 'x,y')
X, Y = Q2.gens()
assert X + (Y - X) == Y

R = PolynomialRing(QQ, 'x,d')
x, d = R.gens()
S = lambda A: matrix_partial_sum(A, D).apply_map(lambda p: truncate_total_degree(p, D))
line1 = entry11(S(one_by_one(R, x + d)))                                                    # exp(x + (y - x))
line2 = truncate_total_degree(entry11(S(one_by_one(R, x))) * entry11(S(one_by_one(R, d))), D)  # exp(x)exp(y - x)
assert line1 == line2 and len(line1.monomials()) == binomial(D + 2, 2)
print(f"exp(x + (y-x)) = exp(x)exp(y-x) が全次数 {D} 以下の {binomial(D + 2, 2)} 項で一致")

pairs = [(QQ(0), QQ(1) / 10^6), (QQ(-1) / 3, QQ(1) / 7), (QQ(-50), QQ(-49)), (QQ(5), QQ(11) / 2), (QQ(-3), QQ(30))]
for x0, y0 in pairs:
    assert x0 < y0 and y0 - x0 > 0
    ey = body_real_exp_ball(y0)
    ex = body_real_exp_ball(x0)
    ed = body_real_exp_ball(y0 - x0)
    assert ey.overlaps(ex * ed)                       # exp(y) = exp(x)exp(y-x)
    assert ed.lower() > 1 and ex.lower() > 0          # Step 1 と real_exp_positive
    assert (ex * ed).lower() > (ex * 1).upper()       # exp(x)exp(y-x) > exp(x)·1
print(f"{len(pairs)} 組の点で、exp(y) と exp(x)exp(y-x) のボールが重なり、exp(x)exp(y-x) > exp(x) が成り立つ")
print("RESULT: PASS")
