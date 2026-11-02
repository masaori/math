# 対象ラベル: exp_of_negative_i_real_as_cos_minus_i_sin
# 主張 exp(-iθ_C) = (cos θ)_C - i(sin θ)_C を、本文の exp（部分和と尾の上界のボール）と Arb の cos・sin
# （1 の冪根を経ない独立の計算）で確かめる。ℝ への脱出はここだけ（θ が π を含む点と exp の値）。
# 点: θ = 2πq（q の分母 1..12、|q| ≤ 2）と、π を含まない有理数 θ = r/7（|r| ≤ 70）。
# 対照: 右辺の符号を -i から +i に替えると、sin θ ≠ 0 の点で交わらない。
load("../../_shared/half_integer_phase_exact.sage")

pts = []
for den in range(1, 13):
    for num in range(-2 * den, 2 * den + 1):
        pts.append(2 * PI * RB(QQ(num) / den))
for r in range(-70, 71):
    pts.append(RB(QQ(r) / 7))
broke = 0
for th in pts:
    lhs = body_exp_i_ball(-th)
    rhs = CB(th.cos(), -th.sin())
    assert lhs.overlaps(rhs)
    if not lhs.overlaps(CB(th.cos(), th.sin())):
        broke += 1
assert broke > 0
print(f"  {len(pts)} 点で、本文の exp(-iθ_C) のボールと Arb の cos θ - i sin θ が重なる。符号を +i に替えると {broke} 点で交わらない")
print("RESULT: PASS")
