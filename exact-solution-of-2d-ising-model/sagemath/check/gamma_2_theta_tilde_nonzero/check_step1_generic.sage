# Step 1: w(θ) の成分の鎖、逆元の鎖（a(θ) b(θ) = 1）、a(θ) ≠ 0 の背理の鎖、a w = 0 ⟺ w = 0 の二つの鎖、同値の鎖。
# (a) 成分: ℂ を definition_of_cc どおり実数の対で持ち、cos θ = co、sin θ = si などを QQ 上の不定元に置く。
# (b) 逆元の鎖: 本文は exp(iθ) を Euler の公式で展開せず scalar_exp_product・scalar_exp_zero だけを使うので、
#     exp(iθ)、exp(-iθ)、exp(iθ + (-iθ)) を独立な不定元 e, f, g に置き、各行の根拠が導入する関係
#     （e f = g、g = 1、s t = 1。t = (s_2^*)^{-1}）だけを法として隣の行と比べる。係数体は QQ(i)。
#     i·i = -1 と (-1)(-1) = 1 と包含が積を保つことは、実数の対の積で別に確かめる。
load("_prelude.sage")
rep = Report("Step 1（零点の必要条件）一般の θ")

P = PolynomialRing(QQ, 'co,si,c1,s1,c2,s,t')
co, si, c1, s1, c2, s, t = P.gens()
def cadd(*zs):
    return (sum(z[0] for z in zs), sum(z[1] for z in zs))
def cmul(a, b):
    return (a[0]*b[0] - a[1]*b[1], a[0]*b[1] + a[1]*b[0])
def real(x):
    return (P(x), P(0))
I2 = (P(0), P(1))
m1 = real(-1)

# (a) w(θ) の成分の鎖（4 行）
w_l1 = cadd(cmul(real(c1), real(co)), cmul(m1, cmul(I2, real(si))), cmul(m1, cmul(real(s1), real(c2))))
w_l2 = cadd((c1*co, P(0)), cmul(m1, (P(0), si)), cmul(m1, (s1*c2, P(0))))
w_l3 = cadd((c1*co, P(0)), (P(0), -si), (-s1*c2, P(0)))
w_l4 = (c1*co - s1*c2, -si)
rep.check(cmul(real(c1), real(co)) == (c1*co, 0) and cmul(I2, real(si)) == (0, si) and cmul(real(s1), real(c2)) == (s1*c2, 0),
          "w の成分 第 1 行 → 第 2 行: 三か所の積 (c_1,0)(cos θ,0)・(0,1)(sin θ,0)・(s_1,0)(c_2,0)")
rep.check(cmul(m1, (P(0), si)) == (0, -si) and cmul(m1, (s1*c2, P(0))) == (-s1*c2, 0), "w の成分 第 2 行 → 第 3 行: 二か所の積")
rep.check(w_l1 == w_l2 == w_l3 and w_l3 == w_l4, "w の成分 第 3 行 → 第 4 行: 和。鎖の両端 w(θ) = (c_1 cos θ - s_1c_2, -sin θ)")
rep.check(w_l4[0] + s1*c2 == c1*co, "同値の鎖: 第 1 式の両辺に s_1c_2 を加える")
rep.check((-1)*w_l4[1] == si, "同値の鎖: 第 2 式の両辺を -1 倍する")
rep.check(real(0) == (0, 0), "同値の鎖: 0_C = (0,0)（成分ごとの相等で連立条件へ）")

# (b) 逆元の鎖（13 行）
Qi.<ii> = QuadraticField(-1)
R = PolynomialRing(Qi, 'e,f,g,S,T,th')
e, f, g, S, T, th = R.gens()
mi = (-1) * ii                                  # multiply_by_minus_one: -i := (-1_C) i
L = [
    (ii*e*S) * (mi*f*T),                        # 1 定義
    (ii*mi) * (e*f) * (S*T),                    # 2 結合律・可換律
    (ii*((-1)*ii)) * (e*f) * (S*T),             # 3 -i の定義
    ((-1)*(ii*ii)) * (e*f) * (S*T),             # 4 結合律・可換律
    ((-1)*(-1)) * (e*f) * (S*T),                # 5 i i = -1
    1 * (e*f) * (S*T),                          # 6 (-1)(-1) = 1
    1 * g * (S*T),                              # 7 scalar_exp_product
    1 * g * (S*T),                              # 8 iθ + (-iθ) = 0（g の引数の書き換え。式としては同じ）
    1 * 1 * (S*T),                              # 9 scalar_exp_zero
    1 * 1 * (S*T),                              # 10 包含は積を保つ（R 側では同じ式。下で対の積で別に確かめる）
    1 * 1 * 1,                                  # 11 s t = 1
    R(1) * 1 * 1,                               # 12 (1)_C = 1_C
    R(1),                                       # 13 単位元
]
rep.check(L[0] == L[1], "逆元の鎖 第 1 行 = 第 2 行（結合律・可換律。多項式として一致）")
rep.check(mi == -ii and L[1] == L[2], "逆元の鎖 第 2 行 = 第 3 行（-i = (-1)i）")
rep.check(L[2] == L[3], "逆元の鎖 第 3 行 = 第 4 行（結合律・可換律）")
rep.check(cmul(I2, I2) == (-1, 0) and L[3] == L[4], "逆元の鎖 第 4 行 = 第 5 行（(0,1)(0,1) = (-1,0) を実数の対の積で）")
rep.check(cmul(m1, m1) == (1, 0) and L[4] == L[5], "逆元の鎖 第 5 行 = 第 6 行（(-1,0)(-1,0) = (1,0) を実数の対の積で）")
rep.check((L[5] - L[6]) in R.ideal([e*f - g]) and L[5] != L[6], "逆元の鎖 第 6 行 = 第 7 行（e f = g を法として。法なしでは異なる）")
rep.check(ii*th + (-ii*th) == 0, "逆元の鎖 第 7 行 = 第 8 行（iθ + (-iθ) = 0 を QQ(i)[θ] で）")
rep.check((L[7] - L[8]) in R.ideal([g - 1]) and L[7] != L[8], "逆元の鎖 第 8 行 = 第 9 行（exp(0) = 1 を法として）")
rep.check(cmul(real(s), real(t)) == real(s*t), "逆元の鎖 第 9 行 = 第 10 行（(s_2^*)_C((s_2^*)^{-1})_C = (s_2^*(s_2^*)^{-1})_C を実数の対の積で）")
rep.check((L[9] - L[10]) in R.ideal([S*T - 1]) and L[9] != L[10], "逆元の鎖 第 10 行 = 第 11 行（s t = 1 を法として）")
rep.check(real(1) == (1, 0) and L[10] == L[11] == L[12], "逆元の鎖 第 11〜13 行（(1)_C = (1,0) = 1_C、単位元）")

# 背理の鎖と a w = 0 ⟺ w = 0 の二つの鎖。a = A、b = B、w = W を不定元とし、関係 A B = 1 だけを使う
U = PolynomialRing(Qi, 'A,B,W')
A, B, W = U.gens()
inv = U.ideal([A*B - 1])
rep.check((U(1) - A*B) in inv and 0 * B == 0 and U(1) != U(0), "背理の鎖: 1 = a b、a = 0 なら 0·b = 0、1 ≠ 0")
chain = [W, 1*W, (B*A)*W, B*(A*W)]
rep.check(chain[0] == chain[1] and (chain[1] - chain[2]) in inv and chain[2] == chain[3],
          "a w = 0 ⇒ w = 0 の鎖: w = 1 w = (b a) w = b (a w)（b a = 1 を法として）")
rep.check(B * 0 == 0 * B == 0, "同 b 0 = 0 b = 0")
rep.check(A * 0 == 0 * A == 0, "w = 0 ⇒ a w = 0 の鎖: a 0 = 0 a = 0")
rep.finish()
