# 対象ラベル: cosh_sinh_product
# 主張そのものを、具体の点で本文の exp を囲むボールで確かめる。
# 帰属: a, b ∈ QQ の点。exp の値は QQ に収まらないので R へ脱出する（RealBallField(512)）。
# ボールは本文の exp から作る（共通の準備 one_by_one_matrix.sage の body_real_exp_ball。Arb の exp は使わない）。
# 半径が相対 2^{-150} 未満であることも確かめ、重なりの検査が値を十分に絞っていることを示す。
load("../../_shared/one_by_one_matrix.sage")

def cosh_ball(x): return (body_real_exp_ball(x) + body_real_exp_ball(-x)) / 2
def sinh_ball(x): return (body_real_exp_ball(x) - body_real_exp_ball(-x)) / 2

points = [(QQ(0), QQ(0)), (QQ(1), QQ(2)), (QQ(-3) / 7, QQ(5) / 4), (QQ(10), QQ(-9)), (QQ(1) / 10^6, QQ(-2) / 3), (QQ(-20), QQ(-20))]
separated = 0
for a0, b0 in points:
    l1 = cosh_ball(a0) * sinh_ball(b0)
    r1 = (sinh_ball(a0 + b0) - sinh_ball(a0 - b0)) / 2
    l2 = cosh_ball(a0) * cosh_ball(b0)
    r2 = (cosh_ball(a0 + b0) + cosh_ball(a0 - b0)) / 2
    assert l1.overlaps(r1) and l2.overlaps(r2)
    assert max(l1.rad(), r1.rad(), l2.rad(), r2.rad()) < RR(2)^(-150) * max(1, abs(l2.mid()))
    # 対照: (sinh(a+b)+sinh(a-b))/2 = sinh(a)cosh(b) は、cosh(a)sinh(b) と a ≠ b で異なる
    wrong = (sinh_ball(a0 + b0) + sinh_ball(a0 - b0)) / 2
    if a0 != b0:
        assert not l1.overlaps(wrong)
        separated += 1
print(f"{len(points)} 点で二つの等式の両辺のボールが重なり、符号を取り違えた式は a ≠ b の {separated} 点で重ならない")
print("RESULT: PASS")
