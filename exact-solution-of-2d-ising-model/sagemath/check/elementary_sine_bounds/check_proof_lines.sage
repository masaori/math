# 対象ラベル: elementary_sine_bounds
# 主張: θ ∈ [0, π] なら θ/2 - sin(θ/2) ≤ θ³/48。
# 証明: θ ∈ [0, π] から θ/2 ∈ [0, π/2]。
#   θ/2 - sin(θ/2) = (1/6)(θ/2)³ - (sin(θ/2) - θ/2 + (1/6)(θ/2)³) ≤ (1/6)(θ/2)³ - 0 = θ³/48。
# 帰属:
# - 1・3 行目の等号は、θ と s := sin(θ/2) を QQ 上の不定元とした多項式環で厳密に。
# - 2 行目と主張は、θ = qπ（[0, π] を 12 等分した点）で sin(θ/2) を AA で厳密に、θ を π のボールで囲んで比べる。
load("../../_shared/sine_cosine_by_definition.sage")
R.<th, s> = QQ[]
h = th / 2
assert h - s == QQ(1)/6 * h^3 - (s - h + QQ(1)/6 * h^3)        # 1 行目
assert QQ(1)/6 * h^3 - 0 == th^3 / 48                           # 3 行目
print("1・3 行目の等号が QQ[θ, s] で成り立つ")
qs = [QQ(k) / 12 for k in range(13)]                             # θ = qπ、θ/2 = (q/2)π
for q in qs:
    assert 0 <= q / 2 <= QQ(1) / 2                               # θ/2 ∈ [0, π/2]
    sh = ball(sin_exact(q / 2))
    hb = angle_ball(q / 2)
    diff_ = hb - sh
    cub = ball(sin_exact(q / 2)) - hb + hb^3 / 6                 # sine_cubic_lower_bound の量
    if q == 0:
        assert sin_exact(0) == 0
        continue
    assert surely_gt(cub, RBF256(0))                             # 2 行目の根拠（≥ 0）
    assert surely_ge(hb^3 / 6, diff_)                            # 2 行目
    assert surely_ge(angle_ball(q)^3 / 48, diff_)                # 主張の上側
print(f"θ = 0 と、[0, π] の 12 等分点で、2 行目と主張 θ/2 - sin(θ/2) ≤ θ³/48 が成り立つ")
print("RESULT: PASS")
