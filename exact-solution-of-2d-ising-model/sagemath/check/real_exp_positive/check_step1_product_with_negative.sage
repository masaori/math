# 対象ラベル: real_exp_positive
# Step 1（0 でない）の二つの鎖を確かめる。
#   exp(x)exp(-x) = exp(x + (-x)) = exp(0) = 1
#   （exp(x) = 0 と仮定すると）1 = exp(x)exp(-x) = 0·exp(-x) = 0
# 帰属: 係数 QQ の多項式環 QQ[x]（K = R の x を不定元に置く）、具体の点は QQ。
# 行列の exp は極限なので、第一の鎖の第一辺・第二辺は形式冪級数として全次数 D 以下の項で比べる。
# exp([x]) の D 次の切り捨ては部分和 S_D([x]) の D 次の切り捨てに等しい（m > D の項は次数 m で落ちる）。
# 値としての第一辺は、具体の点で本文の exp を囲むボールで確かめる（R への脱出。RealBallField(512)）。
load("../../_shared/one_by_one_matrix.sage")

D = 20
R = PolynomialRing(QQ, 'x')
x = R.gen()
E = lambda A: A.apply_map(lambda p: truncate_total_degree(p, D))
S = lambda A: E(matrix_partial_sum(A, D))

# 第一辺: exp(x)exp(-x) の D 次まで。exp(-x) は [ -x ]_R の部分和で作る（x の部分和に -x を代入したものではない）。
line0 = truncate_total_degree(entry11(S(one_by_one(R, x))) * entry11(S(one_by_one(R, -x))), D)
# 第二辺: exp(x + (-x))。1 行 1 列の行列 [x + (-x)] の部分和。
line1 = entry11(S(one_by_one(R, x + (-x))))
# 第三辺: exp(0)。[0]_R の部分和は全ての N で厳密に [1]_R（scalar_exp_zero）。
for N in range(0, 31):
    assert matrix_partial_sum(one_by_one(QQ, QQ(0)), N) == one_by_one(QQ, QQ(1))
line2 = entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), D))
assert x + (-x) == 0
assert line0 == line1 == R(line2) == R(1), (line0, line1, line2)
print(f"第一の鎖: exp(x)exp(-x)、exp(x+(-x))、exp(0) が全次数 {D} 以下で 1 に一致")

# 対照: exp(x)exp(x) は 1 にならない（-x を x に取り違えると落ちる）
assert truncate_total_degree(entry11(S(one_by_one(R, x)))^2, D) != 1

# 値として: 具体の点で、本文の exp のボールの積 exp(x)exp(-x) が 1 を含む
for x0 in [QQ(0), QQ(1), QQ(-1), QQ(7) / 3, QQ(-25), QQ(50)]:
    prod = body_real_exp_ball(x0) * body_real_exp_ball(-x0)
    assert prod.contains_exact(1), x0
    assert prod.rad() < 2^(-200)
print("値として: 6 点で exp(x)exp(-x) のボールが 1 を含む（半径 < 2^-200）")

# 第二の鎖（背理法の中の計算）: e, f を不定元として、e = 0 を代入すると e·f = 0·f = 0 であり 0 ≠ 1。
P = PolynomialRing(QQ, 'e,f')
e, f = P.gens()
lhs = (e * f).subs(e=0)
assert lhs == P(0) * f == P(0)
assert QQ(1) != QQ(0)
print("第二の鎖: exp(x) = 0 を代入すると exp(x)exp(-x) = 0·exp(-x) = 0 で、1 ≠ 0 に反する")
print("RESULT: PASS")
