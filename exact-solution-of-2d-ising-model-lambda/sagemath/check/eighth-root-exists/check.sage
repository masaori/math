# 対象ラベル: claim_eighth_root_exists
# 帰属: QQbar（代数的数）の厳密計算。浮動小数点を使わない。
#
# 主張: ある ζ ∈ QQbar が存在して ζ^4 = -1。
# 証明の組み立てを一行ずつ突き合わせる（s*s = 2 の二根と ω*ω = -1 の二根の四つの組それぞれで）:
#   準備: s ≠ 0、s*s^{-1} = 1、ζ := (1+ω)*s^{-1}
#   二乗の十三段: ζ*ζ = ((1+ω)s^{-1})((1+ω)s^{-1}) = ((1+ω)(1+ω))(s^{-1}s^{-1})
#     = ((1·1+1·ω)+(ω·1+ω·ω))(…) = ((1+ω)+(ω+ω·ω))(…) = ((1+ω)+(ω+(-1)))(…)
#     = ((ω+ω)+(1+(-1)))(…) = (ω+ω)(…) = (ω(1+1))(…) = (ω·2)(…) = (ω(s·s))(…)
#     = ω((s s^{-1})(s s^{-1})) = ω(1·1) = ω
#   四乗の七段: ζ^4 = ζ^3ζ = (ζ^2ζ)ζ = ((ζ^1ζ)ζ)ζ = ((ζζ)ζ)ζ = (ζζ)(ζζ) = ωω = -1

R = PolynomialRing(QQbar, "t")
t = R.gen()
one = QQbar(1)
minus_one = -one
two = QQbar(2)
assert two != QQbar(0), "準備の 2 ≠ 0 が壊れている"
assert one + minus_one == QQbar(0), "準備の 1 + (-1) = 0 が壊れている"

sqrt_twos = (t**2 - two).roots(multiplicities=False)
imaginary_units = (t**2 + one).roots(multiplicities=False)
assert len(sqrt_twos) == 2 and len(imaginary_units) == 2

checked = 0
for s in sqrt_twos:
    assert s * s == two, "準備の s*s = 2 が壊れている"
    assert s != QQbar(0), "準備の s ≠ 0 が壊れている"
    si = s**(-1)
    assert s * si == one, "準備の s*s^{-1} = 1 が壊れている"
    for w in imaginary_units:
        assert w * w == minus_one, "準備の ω*ω = -1 が壊れている"
        z = (one + w) * si
        u = si * si
        square_chain = [
            z * z,
            ((one + w) * si) * ((one + w) * si),
            ((one + w) * (one + w)) * u,
            ((one * one + one * w) + (w * one + w * w)) * u,
            ((one + w) + (w + w * w)) * u,
            ((one + w) + (w + minus_one)) * u,
            ((w + w) + (one + minus_one)) * u,
            (w + w) * u,
            (w * (one + one)) * u,
            (w * two) * u,
            (w * (s * s)) * u,
            w * ((s * si) * (s * si)),
            w * (one * one),
            w,
        ]
        for i in range(len(square_chain) - 1):
            assert square_chain[i] == square_chain[i + 1], f"二乗の {i+1} 段目が壊れている: s = {s}, ω = {w}"
        fourth_chain = [
            z**4, z**3 * z, (z**2 * z) * z, ((z**1 * z) * z) * z, ((z * z) * z) * z,
            (z * z) * (z * z), w * w, minus_one,
        ]
        for i in range(len(fourth_chain) - 1):
            assert fourth_chain[i] == fourth_chain[i + 1], f"四乗の {i+1} 段目が壊れている: s = {s}, ω = {w}"
        checked += 1

# 負の検査: s の代わりに s*s = 2 を満たさない元（1）を使うと ζ^4 = -1 は成り立たない。
for w in imaginary_units:
    z_bad = (one + w) * one
    assert z_bad**4 != minus_one, "負の検査: s = 1 で ζ^4 = -1 になってしまった"

print(f"PASS check.sage: 二乗 13 段・四乗 7 段 × {checked} 組、負の検査 2 件")
