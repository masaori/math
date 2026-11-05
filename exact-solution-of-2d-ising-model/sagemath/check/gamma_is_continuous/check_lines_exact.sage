# 対象ラベル: gamma_is_continuous
# 証明の行のうち、具体の値で決まるものを厳密に確かめる（浮動小数点なし）。
# - Step 1: γ_1(θ) = c_1c_2^* - s_1s_2^* cos θ（def_gamma1_gamma2_of_theta）が cos θ の 1 次式で、係数 c_1c_2^*・s_1s_2^* が
#   θ に依らない実数であること。具体の結合定数では係数が QQ に入ること。
# - Step 2: y ∈ [1,∞) で y^2 - 1 ≥ 0、√(y^2-1) ≥ 0、y + √(y^2-1) ≥ 1 > 0（def_arccosh の右辺が定まることの鎖の当てはめ）を
#   具体の y ∈ AA で。
# - Step 3: γ_1(ℝ) ⊆ [1,∞)（gamma1_lower_bound_all_theta の当てはめ）を、具体の結合定数と θ = qπ（q ∈ QQ）で AA で。
#
# 結合定数: Y := exp(2K_1)、X := exp(2K_2^*) を QQ_{>1} に取る（K_1 = (1/2)log Y、K_2^* = (1/2)log X）。def_cosh_sinh により
# c_1 = (Y + 1/Y)/2、s_1 = (Y - 1/Y)/2、c_2^* = (X + 1/X)/2、s_2^* = (X - 1/X)/2 が QQ に入る。
# cos(qπ) は 1 の冪根 e^{iqπ} の実部として AA で作る。本文の def_cos は [-π/2, π/2] でしか cos を定めておらず、
# 全実数上の cos は本文に無い（主張に前提として書いてある）。ここの値はその外では通常の cos の値である。
import sys

n_pass = 0


def ok(cond, label):
    global n_pass
    if not cond:
        print("FAIL", label)
        print("RESULT: FAIL")
        sys.exit(1)
    n_pass += 1
    print("PASS", label)


# ---------------- Step 1 ----------------
P1 = PolynomialRing(QQ, ['c1', 's1', 'c2s', 's2s', 'co'])
c1, s1, c2s, s2s, co = P1.gens()
gamma1_poly = c1 * c2s - s1 * s2s * co          # def_gamma1_gamma2_of_theta の式（co = cos θ）
ok(gamma1_poly.degree(co) == 1, "Step 1: γ_1 は cos θ の 1 次式")
ok(gamma1_poly.coefficient({co: 0}) == c1 * c2s and gamma1_poly.coefficient({co: 1}) == -s1 * s2s,
   "Step 1: 定数項は c_1c_2^*、cos θ の係数は -s_1s_2^*（どちらも cos θ を含まず、θ に依らない）")

COUPLINGS = [(QQ(4), QQ(3)), (QQ(9), QQ(7) / 3), (QQ(2), QQ(5)), (QQ(3), QQ(3)), (QQ(11) / 10, QQ(100))]
Q_ANGLES = [QQ(0), QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1), QQ(5) / 4, QQ(7) / 6, QQ(-2) / 3, QQ(13) / 5]


def hyperbolic(Yv, Xv):
    """def_indexed_hyperbolic_abbreviations の c_1, s_1, c_2^*, s_2^*（def_cosh_sinh の式に exp の値 Y, X を入れたもの）。"""
    return (Yv + 1 / Yv) / 2, (Yv - 1 / Yv) / 2, (Xv + 1 / Xv) / 2, (Xv - 1 / Xv) / 2


for Yv, Xv in COUPLINGS:
    a1, b1, a2, b2 = hyperbolic(Yv, Xv)
    ok(a1 * a2 in QQ and b1 * b2 in QQ and b1 * b2 > 0, f"Step 1: (Y,X)=({Yv},{Xv}) で c_1c_2^*, s_1s_2^* ∈ QQ（s_1s_2^* > 0）")


def cos_qpi(q):
    """cos(qπ)（q ∈ QQ）。e^{iqπ} = ζ_{2d}^m（q = m/d）の実部として AA で作る。"""
    q = QQ(q)
    m, d = q.numerator(), q.denominator()
    z = QQbar.zeta(2 * d)
    w = z ^ m if m >= 0 else (~z) ^ (-m)
    return AA(w.real())


def gamma1_value(Yv, Xv, q):
    a1, b1, a2, b2 = hyperbolic(Yv, Xv)
    return AA(a1 * a2) - AA(b1 * b2) * cos_qpi(q)


# ---------------- Step 2 ----------------
print("Step 2: y ∈ [1,∞) で y^2 - 1 ≥ 0、√(y^2-1) ≥ 0、y + √(y^2-1) ≥ 1 > 0（具体の y ∈ AA）")
Y_POINTS = [AA(1), AA(1) + AA(1) / 10 ^ 6, AA(5) / 4, AA(2), AA(2).sqrt() + 1, AA(17) / 8, AA(10) ^ 6]
for y0 in Y_POINTS:
    ok(y0 ^ 2 - 1 >= 0, f"  y={y0}: y^2 - 1 ≥ 0")
    r0 = (y0 ^ 2 - 1).sqrt()
    ok(r0 >= 0 and r0 ^ 2 == y0 ^ 2 - 1, f"  y={y0}: √(y^2-1) は非負で平方が y^2-1（definition_of_sqrt_r_positive）")
    ok(y0 + r0 >= 1 and 1 > 0, f"  y={y0}: y + √(y^2-1) ≥ 1 > 0")
ok(AA(1) + (AA(1) ^ 2 - 1).sqrt() == 1, "  y = 1 では y + √(y^2-1) = 1（下界 1 に達する）")
# 対照: y < 1 では y^2 - 1 < 0 になりうる（定義域 [1,∞) が要る）
ok((AA(1) / 2) ^ 2 - 1 < 0, "対照: y = 1/2 では y^2 - 1 < 0")

# ---------------- Step 3 ----------------
print("Step 3: γ_1(θ) ≥ 1（gamma1_lower_bound_all_theta の当てはめ）")
for Yv, Xv in COUPLINGS:
    for q in Q_ANGLES:
        g = gamma1_value(Yv, Xv, q)
        ok(g >= 1, f"  (Y,X)=({Yv},{Xv}) q={q}: γ_1(qπ) ≥ 1")
ok(gamma1_value(QQ(3), QQ(3), QQ(0)) == 1, "  臨界の結合定数（2K_1 = 2K_2^*）、θ = 0 では γ_1 = 1（arccosh の定義域の端に達する）")

print(f"-- check_lines_exact: {n_pass} PASS")
print("RESULT: PASS")
