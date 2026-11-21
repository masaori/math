# 対象ラベル: claim_imaginary_unit_exists
# 帰属: QQbar（代数的数）と QQbar[t] の厳密計算。浮動小数点を使わない。
#
# 主張: ある ω ∈ QQbar が存在して ω*ω = -1。
# 証明の組み立てを一行ずつ突き合わせる:
#   係数: ac_2(g) = ac_2(t^2 + 1^) = ac_2(t^2) + ac_2(1^) = 1 + ac_2(1^) = 1 + 0 = 1
#   根:   aev_ω(g) = 0 を満たす ω が存在する（代数閉性。QQbar では根を列挙できる）
#   評価: ω*ω = aev_ω(t)*aev_ω(t) = aev_ω(t*t) = aev_ω(t^1*t) = aev_ω(t^2)
#             = aev_ω(t^2)+0 = aev_ω(t^2)+(1+(-1)) = aev_ω(t^2)+(aev_ω(1^)+(-1))
#             = (aev_ω(t^2)+aev_ω(1^))+(-1) = aev_ω(t^2+1^)+(-1) = aev_ω(g)+(-1)
#             = 0+(-1) = -1

R = PolynomialRing(QQbar, "t")
t = R.gen()
one = QQbar(1)
minus_one = -one
assert one + minus_one == QQbar(0), "準備の 1 + (-1) = 0 が壊れている"
assert one != QQbar(0), "準備の 1 ≠ 0 が壊れている"

g = t**2 + R(one)

# 係数の五段
coeff_chain = [g[2], (t**2 + R(one))[2], (t**2)[2] + R(one)[2],
               QQbar(1) + R(one)[2], QQbar(1) + QQbar(0), QQbar(1)]
for i in range(len(coeff_chain) - 1):
    assert coeff_chain[i] == coeff_chain[i + 1], f"係数の {i+1} 段目が壊れている"
assert g[2] != QQbar(0), "ac_2(g) ≠ 0 が壊れている"

# 根の存在（QQbar では厳密に列挙できる）
roots = g.roots(multiplicities=False)
assert len(roots) == 2, f"t^2 + 1 の根の個数が 2 でない: {len(roots)}"

checked = 0
for w in roots:
    c = R(one)
    chain = [w * w, t(w) * t(w), (t * t)(w), (t**1 * t)(w), (t**2)(w),
             (t**2)(w) + QQbar(0), (t**2)(w) + (one + minus_one),
             (t**2)(w) + (c(w) + minus_one), ((t**2)(w) + c(w)) + minus_one,
             (t**2 + c)(w) + minus_one, g(w) + minus_one,
             QQbar(0) + minus_one, minus_one]
    for i in range(len(chain) - 1):
        assert chain[i] == chain[i + 1], f"評価の {i+1} 段目が壊れている: ω = {w}"
    assert g(w) == QQbar(0), "aev_ω(g) = 0 が壊れている"
    checked += 1

# 負の検査: 定数項を 1 から -1 に変えた多項式の根では ω*ω = -1 が成り立たない。
h = t**2 + R(minus_one)
for w in h.roots(multiplicities=False):
    assert w * w != minus_one, "負の検査: t^2 - 1 の根で ω*ω = -1 になってしまった"

print(f"PASS check.sage: 係数 5 段、評価 12 段 × {checked} 根、負の検査 2 根")
