# 対象ラベル: diagonalization_check_P_D
# Step 1 の c = 1_C/d = 1_C d^{-1} = d^{-1}（3 行）、Step 3 の前置き (a) s s = ℓ（5 行。実数の側は AA で厳密）・
# (b) ℓ, 2_C ℓ, q ∈ C^×・(c) 1_C + 1_C = 2_C・(d) d u = 2_C q（12 行）と、det P̌_μ = (-ρ)/q の 29 行の鎖を一行ずつ確かめる。
# 鎖は s, b, rho を不定元にした QQ(i) 上の有理関数体で、ℓ = s s と置いて確かめ、(a) は実際の M_col で別に確かめる。浮動小数点なし。
import sys

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

K0.<I0> = QuadraticField(-1)
R.<s, b, rho> = PolynomialRing(K0)
F = R.fraction_field()
s, b, rho = F(s), F(b), F(rho)
one = F(1)
two = F(2)
m1 = F(-1)
u = two * s
d = u * b
ell = s * s                       # (a) で示す ℓ = s s を、一般の点ではこの形で置く
q = (two * ell) * b               
ui, di, qi = u^-1, d^-1, q^-1
c = one / d

# ---- Step 1: c = 1_C / d = 1_C d^{-1} = d^{-1} ----
chain_check([c, one / d, one * di, di], "Step 1 の c の鎖")

# ---- (a) s s = ℓ（実際の M_col で。√M_col は AA の非負の平方根） ----
for M in range(2, 9):
    sq = AA(M).sqrt()
    sC = QQbar(sq)
    lines_a = [sC * sC, QQbar(sq * sq), QQbar(sq^2), QQbar(AA(M)), QQbar(M)]
    for k in range(len(lines_a) - 1):
        check(lines_a[k] == lines_a[k + 1], f"(a) M_col = {M}: 第 {k+1} 行 = 第 {k+2} 行")
    check(sq >= 0 and AA(M) >= 1, f"(a) M_col = {M}: √ の中 ι(M_col) ≥ 1 ≥ 0、√ の値 ≥ 0")

# ---- (b) ℓ, 2_C ℓ, q ∈ C^×（一般の点。s, b ∈ C^× のとき） ----
check(ell != 0 and two * ell != 0 and q != 0 and ell == s * s, "(b) 一般の点で ℓ = s s ≠ 0、2_C ℓ ≠ 0、q ≠ 0")

# ---- (c) 1_C + 1_C = 2_C ----
chain_check([K0(1) + K0(1), K0(QQ(1)) + K0(QQ(1)), K0(QQ(1) + QQ(1)), K0(QQ(2)), K0(2)], "(c) 1+1=2 の鎖")

# ---- (d) d u = 2_C q ----
lines_d = [
    d * u,
    (u * b) * u,
    u * (b * u),
    u * (u * b),
    (u * u) * b,
    ((two * s) * (two * s)) * b,
    (two * (s * (two * s))) * b,
    (two * ((s * two) * s)) * b,
    (two * ((two * s) * s)) * b,
    (two * (two * (s * s))) * b,
    (two * (two * ell)) * b,
    two * ((two * ell) * b),
    two * q,
]
chain_check(lines_d, "(d) d u の鎖")
check(len(lines_d) - 1 == 12, "(d) の鎖は 12 行")

# ---- Step 3: det P̌ = (-ρ)/q ----
P11, P12, P21, P22 = (-rho) / d, rho / d, one / u, one / u
y = (-rho) * (di * ui)
lines_3 = [
    P11 * P22 - P12 * P21,                                       # det の定義
    ((-rho) / d) * (one / u) - (rho / d) * (one / u),                # def_det_two_by_two
    ((-rho) * di) * (one * ui) - (rho * di) * (one * ui),            # 商 4 か所
    ((-rho) * di) * ui - (rho * di) * ui,                            # 単位元 2 か所
    (-rho) * (di * ui) - rho * (di * ui),                            # 結合律 2 か所
    (-rho) * (di * ui) + (-(rho * (di * ui))),                       # 差の定義
    (-rho) * (di * ui) + m1 * (rho * (di * ui)),                     # multiply_by_minus_one
    (-rho) * (di * ui) + (m1 * rho) * (di * ui),                     # 結合律（逆向き）
    (-rho) * (di * ui) + (-rho) * (di * ui),                         # multiply_by_minus_one（逆向き）
    one * y + one * y,                                           # 単位元（逆向き）2 か所
    (one + one) * y,                                             # 分配律（逆向き）
    two * y,                                                     # (c)
    (two * (-rho)) * (di * ui),                                    # 結合律（逆向き）
    ((-rho) * two) * (di * ui),                                    # 可換律
    (-rho) * (two * (di * ui)),                                    # 結合律
    (-rho) * (one * (two * (di * ui))),                            # 単位元（逆向き）
    (-rho) * ((qi * q) * (two * (di * ui))),                       # 逆元 q（逆向き）
    (-rho) * (qi * (q * (two * (di * ui)))),                       # 結合律
    (-rho) * (qi * ((q * two) * (di * ui))),                       # 結合律（逆向き）
    (-rho) * (qi * ((two * q) * (di * ui))),                       # 可換律
    (-rho) * (qi * ((d * u) * (di * ui))),                         # (d)（逆向き）
    (-rho) * (qi * (d * (u * (di * ui)))),                         # 結合律
    (-rho) * (qi * (d * ((u * di) * ui))),                         # 結合律（逆向き）
    (-rho) * (qi * (d * ((di * u) * ui))),                         # 可換律
    (-rho) * (qi * (d * (di * (u * ui)))),                         # 結合律
    (-rho) * (qi * (d * (di * one))),                              # 逆元 u
    (-rho) * (qi * (d * di)),                                      # 単位元
    (-rho) * (qi * one),                                           # 逆元 d
    (-rho) * qi,                                                   # 単位元
    (-rho) / q,                                                    # 商（逆向き）
]
chain_check(lines_3, "Step 3 の det の鎖")
check(len(lines_3) - 1 == 29, "Step 3 の鎖は 29 行（先頭は det の定義の形）")

# 否定の対照: 4M で止める・2 を約し忘れる・符号を落とす
check((-rho) / q != (-rho) / (two * q), "否定の対照: det は (-ρ)/(4 ℓ b) ではない")
check((-rho) / q != rho / q, "否定の対照: det は ρ/q ではない（符号）")
check(d * u != q, "否定の対照: d u は q ではない（2_C が残る）")

# ---- det ≠ 0: |b| = r を満たす値で（relation_of_gamma_2_theta_tilde の b = -conj(a)、r = |a| > 0）、M_col = 2..8 ----
for M in range(2, 9):
    for a_ in [K0(3) + 4*I0, K0(5) + 12*I0, K0(1), -2*I0, K0(-8) + 6*I0]:
        bb = -a_.conjugate()
        rr = QQ(sqrt(QQ(a_.norm())))     # |a|（ここで選んだ a はノルムが平方数）
        check(rr > 0 and rr^2 == a_.norm() and bb.norm() == rr^2, f"M_col = {M}, a = {a_}: r = |a| = |b| > 0")
        mm = K0(M)
        ww = (2 * mm) * bb
        check(ww != 0 and (-K0(rr)) / ww != 0, f"det ≠ 0: M_col = {M}, a = {a_}")
check(K0(-1) != 0, "-1_C = (-1, 0) の第 1 成分 -1 ≠ 0")

print(f"-- diagonalization_check_P_D の Step 1・Step 3 の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
