# 対象ラベル: real_exp_positive
# Step 2（非負）の鎖を確かめる。
#   exp(x) = exp(x/2 + x/2) = exp(x/2)exp(x/2) = (exp(x/2))^2 ≥ 0
# 帰属: 係数 QQ の多項式環 QQ[x]。等号の三行は形式冪級数として全次数 D 以下で厳密に比べる。
# 最後の不等号（実数の平方は非負）と、exp(x/2) ∈ R は具体の点で本文の exp を囲むボールで確かめる
# （R への脱出。RealBallField(512)）。
load("../../_shared/one_by_one_matrix.sage")

D = 20
R = PolynomialRing(QQ, 'x')
x = R.gen()
S = lambda A: matrix_partial_sum(A, D).apply_map(lambda p: truncate_total_degree(p, D))

assert x / 2 + x / 2 == x
line0 = entry11(S(one_by_one(R, x)))                                     # exp(x)
line1 = entry11(S(one_by_one(R, x / 2 + x / 2)))                         # exp(x/2 + x/2)
half = entry11(S(one_by_one(R, x / 2)))
line2 = truncate_total_degree(half * half, D)                            # exp(x/2)exp(x/2)
line3 = truncate_total_degree(scalar_power_by_definition(half, 2), D)    # (exp(x/2))^2（冪の定義 t^2 = (1·t)·t）
assert line0 == line1 == line2 == line3
assert len(line0.monomials()) == D + 1
print(f"等号の三行が全次数 {D} 以下の {D + 1} 項で一致")

# 対照: exp(x) は exp(x/2) の 2 倍ではない（積と和を取り違えると落ちる）
assert line0 != truncate_total_degree(2 * half, D)

# 不等号: 具体の点で exp(x/2) のボールは実数で、その平方のボールの下端は 0 以上、かつ exp(x) のボールと重なる
for x0 in [QQ(0), QQ(1), QQ(-1), QQ(-7) / 3, QQ(-60), QQ(40)]:
    h = body_real_exp_ball(x0 / 2)
    sq = h^2  # 整数冪の平方（Arb は偶数冪の下端を 0 未満にしない）
    assert sq.lower() >= 0, x0
    assert sq.overlaps(body_real_exp_ball(x0)), x0
print("不等号: 6 点で (exp(x/2))^2 のボールの下端が 0 以上で、exp(x) のボールと重なる")
print("RESULT: PASS")
