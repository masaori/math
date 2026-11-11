# 対象ラベル: diagonalization_check_P_D
# Step 1 の分母が C^× に属すること、Step 2 の第 1 成分の鎖（c x = x/d、5 行）と第 2 成分の鎖（c b = 1/u、13 行）を、
# 一般の点（s, b, x を不定元にした QQ(i) 上の有理関数体）で一行ずつ確かめる。各行は本文の式から別々に作る。浮動小数点なし。
import sys

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

K0.<I0> = QuadraticField(-1)
R.<s, b, x> = PolynomialRing(K0)
F = R.fraction_field()
s, b, x = F(s), F(b), F(x)
one = F(1)
two = F(2)                       # 2_C = (2_R)_C
u = two * s                      # u := 2_C s
d = u * b                        # d := u b
ui = u^-1                        # multiplicative_group_of_cc の逆元
di = d^-1
c = one / d                      # c := 1_C / d

# ---- Step 2 第 1 成分: c x = x / d ----
chain1 = [
    c * x,                       # c x
    (one / d) * x,               # c の定義
    (one * di) * x,              # def_complex_quotient (z -> 1_C, w -> d)
    di * x,                      # 積の単位元
    x * di,                      # 積の可換律
    x / d,                       # def_complex_quotient (z -> x, w -> d) を右辺から左辺へ
]
for k in range(len(chain1) - 1):
    check(chain1[k] == chain1[k + 1], f"c x の鎖 第 {k+1} 行 = 第 {k+2} 行")

# ---- Step 2 第 2 成分: c b = 1 / u ----
chain2 = [
    c * b,
    (one / d) * b,               # c の定義
    (one * di) * b,              # def_complex_quotient
    di * b,                      # 積の単位元
    one * (di * b),              # 積の単位元（右辺から左辺へ）
    (ui * u) * (di * b),         # 逆元 u（右辺から左辺へ）
    ui * (u * (di * b)),         # 積の結合律
    ui * ((u * di) * b),         # 積の結合律（右辺から左辺へ）
    ui * ((di * u) * b),         # 積の可換律
    ui * (di * (u * b)),         # 積の結合律
    ui * (di * d),               # d の定義（右辺から左辺へ）
    ui * one,                    # 逆元 d
    one * ui,                    # 積の可換律
    one / u,                     # def_complex_quotient（右辺から左辺へ）
]
for k in range(len(chain2) - 1):
    check(chain2[k] == chain2[k + 1], f"c b の鎖 第 {k+1} 行 = 第 {k+2} 行")
check(len(chain2) - 1 == 13, "c b の鎖は 13 行（等号 13 個）")

# 否定の対照: 逆元の取り違え・約分の取り違えを見分ける
check(c * b != di, "否定の対照: c b は d^{-1} ではない（b を約さずに残すと崩れる）")
check(d^-1 != ui * b, "否定の対照: (u b)^{-1} は u^{-1} b ではない")
check(c * b != u, "否定の対照: c b は u ではない（逆元を取り忘れると崩れる）")

# ---- P̌_μ の成分との一致（第 1 列 c(-r, b)、第 2 列 c(r, b)） ----
check(c * (-x) == (-x) / d and c * x == x / d, "第 1 成分: x -> -r_C・x -> r_C のどちらでも c x = x/d")
check(c * b == one / u, "第 2 成分: c b = 1_C / u（P̌ の第 2 行の成分）")

# ---- Step 1: s = (√M, 0)、2_C = (2, 0) の第 1 成分が 0 でないこと（M_col = 2..8 で厳密に） ----
for M in range(2, 9):
    check(ZZ(M) >= 2 and ZZ(2) >= 1, f"M_col = {M}: M_col ≥ 2 ≥ 1（ℤ の順序）")
    iM = QQ(ZZ(M))
    check(iM >= 1 and QQ(1) > 0, f"M_col = {M}: ι(M_col) ≥ 1_R > 0（inclusion_zz_to_rr_of_positive_is_at_least_one と順序）")
    sq = AA(M).sqrt()
    check(sq > 0 and sq^2 == M, f"M_col = {M}: √M_col > 0 かつ (√M_col)^2 = M_col（sqrt_of_positive_real_is_positive、AA）")
check(QQ(2) != 0, "2_C = (2, 0) の第 1 成分 2 ≠ 0")
for M in range(2, 9):
    sv = QQbar(AA(M).sqrt())
    check(2 * sv != 0, f"M_col = {M}: 実際の値で u = 2_C (√M_col)_C ≠ 0（QQbar）")
# u, d が 0 でないこと（不定元 s, b が 0 でない一般の点で）
check(u != 0 and d != 0 and c * d == one, "一般の点で u ≠ 0、d ≠ 0、c d = 1_C（c は d の逆元）")

print(f"-- diagonalization_check_P_D の商の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
