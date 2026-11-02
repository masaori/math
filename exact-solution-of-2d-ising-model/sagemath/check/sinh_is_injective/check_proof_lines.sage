# 対象ラベル: sinh_is_injective
# 対偶の鎖 u ≠ v ⇒ u < v ∨ v < u ⇒ sinh u < sinh v ∨ sinh v < sinh u ⇒ sinh u ≠ sinh v を、
# u ≠ v の 8 組の点 (u, v) ∈ QQ^2 で確かめる。1 行目は QQ の全順序（厳密）、2 行目は sinh_strictly_increasing を
# ボールの比較で（RealBallField(512)。値が QQ に収まらないため）、3 行目はボールが重ならないこと。
load("../../_shared/hyperbolic_by_definition.sage")
pairs = [(QQ(0), QQ(1)), (QQ(1), QQ(0)), (QQ(-3), QQ(3)), (QQ(1)/10^9, QQ(0)), (QQ(-20), QQ(-21)), (QQ(5)/7, QQ(6)/7), (QQ(2), QQ(-2)), (QQ(40), QQ(39))]
for u0, v0 in pairs:
    assert u0 != v0 and ((u0 < v0) != (v0 < u0))
    su, sv = sinh_ball(u0), sinh_ball(v0)
    assert (su < sv) if u0 < v0 else (sv < su)
    assert not su.overlaps(sv)
print(f"u ≠ v の {len(pairs)} 組で対偶の鎖の三行が成り立つ")
print("RESULT: PASS")
