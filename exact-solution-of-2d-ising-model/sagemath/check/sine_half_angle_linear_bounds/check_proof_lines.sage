# 対象ラベル: sine_half_angle_linear_bounds
# 証明: 準備 (θ/2)² = (θ/2)(θ/2) ≤ (θ/2)(π/2) ≤ (π/2)(π/2) = π²/4。
#   上: sin(θ/2) = θ/2 - (θ/2 - sin(θ/2)) ≤ θ/2 - 0 = θ/2。
#   下: sin(θ/2) = (θ/2 - (1/6)(θ/2)³) + (sin(θ/2) - θ/2 + (1/6)(θ/2)³) ≥ θ/2 - (1/6)(θ/2)³ + 0
#       = (θ/2)(1 - (1/6)(θ/2)²) ≥ (θ/2)(1 - (1/6)(π²/4)) = (θ/2)(1 - π²/24) = c0 θ/2。
#   準備の続き: -(1/6)(θ/2)² ≥ -(1/6)(π²/4)、1 - (1/6)(θ/2)² ≥ 1 - (1/6)(π²/4)。
# 端点で等号になる行（θ = 0 の準備 2 行目、θ = π の準備 3 行目・準備の続き・下 4 行目）は、ボールでは等号を判定できないので、
# θ/2 = qπ/2 の q/2 が 0 または 1/2 であることを QQ で確かめ、両辺が同じ式になることを π の不定元の多項式環で確かめる。
# 帰属:
# - 等号の行は θ, s := sin(θ/2), p := π を QQ 上の不定元とした多項式環で厳密に。
# - 不等号の行と主張は、θ = qπ（[0, π] を 12 等分した点）で sin(θ/2) を AA で厳密に、θ と π をボールで囲んで比べる。
load("../../_shared/sine_cosine_by_definition.sage")
R.<th, s, p> = QQ[]
h = th / 2
assert h^2 == h * h and (p/2) * (p/2) == p^2 / 4                                   # 準備の 1・4 行目
assert s == h - (h - s)                                                            # 上の 1 行目
assert s == (h - QQ(1)/6 * h^3) + (s - h + QQ(1)/6 * h^3)                          # 下の 1 行目
assert h - QQ(1)/6 * h^3 + 0 == h * (1 - QQ(1)/6 * h^2)                            # 下の 3 行目
assert h * (1 - QQ(1)/6 * p^2/4) == h * (1 - p^2/24)                               # 下の 5 行目
c0p = 1 - p^2/24                                                                   # def_sine_bound_constant
assert h * (1 - p^2/24) == c0p * h                                                 # 下の 6 行目
print("等号の行が QQ[θ, s, π] で成り立つ")
c0 = 1 - PI_BALL^2 / 24
hp = PI_BALL / 2
P.<pp> = QQ[]                                          # π の不定元（端点で両辺が同じ式になることを見る）
for q in [QQ(k) / 12 for k in range(13)]:
    hb = angle_ball(q / 2)
    sh = ball(sin_exact(q / 2))
    hq = (q / 2) * pp                                      # θ/2 を π の不定元で表した式
    # 準備 2 行目: (θ/2)(θ/2) ≤ (θ/2)(π/2)
    if q == 0:
        assert hq * hq == hq * (pp / 2)
    elif q == 1:
        assert hq * hq == hq * (pp / 2)
    else:
        assert surely_gt(hb * hp, hb * hb)
    # 準備 3 行目: (θ/2)(π/2) ≤ (π/2)(π/2)
    if q == 1:
        assert hq * (pp / 2) == (pp / 2) * (pp / 2)
    else:
        assert surely_gt(hp * hp, hb * hp)
    # 準備の続きの二行と下 4 行目
    if q == 1:
        assert -QQ(1)/6 * hq^2 == -QQ(1)/6 * pp^2 / 4
        assert 1 - QQ(1)/6 * hq^2 == 1 - QQ(1)/6 * pp^2 / 4
        assert hq * (1 - QQ(1)/6 * hq^2) == hq * (1 - QQ(1)/6 * pp^2 / 4)
    else:
        assert surely_gt(-hb^2 / 6, -(PI_BALL^2 / 4) / 6)
        assert surely_gt(1 - hb^2 / 6, 1 - (PI_BALL^2 / 4) / 6)
        if q != 0:
            assert surely_gt(hb * (1 - hb^2/6), hb * (1 - (PI_BALL^2/4)/6))
    if q == 0:
        assert sin_exact(0) == 0 and hq == 0                 # θ = 0 では三辺とも 0
        continue
    assert surely_ge(hb, sh)                                                       # 上 2 行目・主張の上側
    assert surely_ge(sh, hb - hb^3/6)                                              # 下 2 行目
    assert surely_ge(sh, c0 * hb)                                                  # 主張の下側
print("θ = 0 と、[0, π] の 12 等分点で、準備・上・下の不等号の行と主張 c0 θ/2 ≤ sin(θ/2) ≤ θ/2 が成り立つ（θ = 0, π の端で等号になる行は、π の不定元の多項式として両辺が一致することで確かめた）")
assert surely_gt(RBF256(QQ(65)/100) * angle_ball(QQ(1)/2), ball(sin_exact(QQ(1)/2)))
print("対照: c0 の代わりに 0.65（> 2/π）を置くと θ = π で下側が成り立たない")
print("RESULT: PASS")
