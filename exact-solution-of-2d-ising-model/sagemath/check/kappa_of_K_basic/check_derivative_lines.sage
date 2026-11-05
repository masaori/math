# 対象ラベル: kappa_of_K_basic
# (1) の (tanh)'・dK^*/dK・κ' の鎖、(3) の κ'' の鎖、(4) の h(t) = cosh t/sinh^2 t の h' の鎖、(κ'^2)' = 2κ'κ'' を、
# v := exp(K)（または exp(t)）の有理関数体 QQ(v) で厳密に確かめる。浮動小数点は使わない。
# 書き換え: sinh K = (v − 1/v)/2、cosh K = (v + 1/v)/2（def_cosh_sinh）。関数 f(K) = F(exp(K)) の導関数は
#   exp' = exp と合成の微分から v·F'(v) なので、微分を QQ(v) の導分 Dv(F) := v·dF/dv で表す。
#   log∘T の導関数は log'(w) = 1/w と合成から Dv(T)/T。これらの書き換えは本文の微分の公式を当てはめたもので、
#   本文の行の「微分の公式の…」の根拠そのものは、行の両辺がこの導分で一致することとして確かめる。
import sys
ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

F = FractionField(PolynomialRing(QQ, 'v')); v = F.gen()
def Dv(f):
    return v * f.derivative(v)
def sinh_at(k):   # sinh(kK) を v = exp(K) で
    return (v^k - v^(-k)) / 2
def cosh_at(k):
    return (v^k + v^(-k)) / 2
sh, ch = sinh_at(1), cosh_at(1)
sh2, ch2 = sinh_at(2), cosh_at(2)
check("準備: Dv(sinh) = cosh（sinh_derivative）", Dv(sh) == ch)
check("準備: Dv(cosh) = sinh（cosh_derivative）", Dv(ch) == sh)
check("準備: cosh^2 − sinh^2 = 1（cosh_sinh_basic_properties (2)）", ch^2 - sh^2 == 1)
check("準備: sinh 2K = 2 sinh K cosh K（sinh_double_angle_formula を x = 2K で）", sh2 == 2 * sh * ch)

# (tanh)'(K) の鎖
tanhK = sh / ch
L = [Dv(tanhK),                                   # 左辺 (tanh)'(K) = (sinh/cosh)'(K)
     (Dv(sh) * ch - sh * Dv(ch)) / ch^2,         # 商の微分
     (ch * ch - sh * sh) / ch^2,                 # sinh' = cosh、cosh' = sinh
     1 / ch^2]                                   # cosh^2 − sinh^2 = 1
for j in range(3):
    check(f"(tanh)' の鎖 {j}→{j+1} 行目", L[j] == L[j + 1])
check("(tanh)' 対照: 商の微分の符号を誤ると一致しない", (Dv(sh) * ch + sh * Dv(ch)) / ch^2 != L[0])

# dK^*/dK の鎖（K^* = −(1/2) log(tanh K)）
dKs = -QQ(1)/2 * Dv(tanhK)  / tanhK                # 定数倍と合成、log' = 1/w（log は QQ(v) に無いので、合成の行は下の SR で独立に確かめる）
M = [dKs,
     -QQ(1)/2 * (1 / tanhK) * Dv(tanhK),           # log'(tanh K) = 1/tanh K
     -QQ(1)/2 * (ch / sh) * (1 / ch^2),          # tanh の定義と上の (tanh)'
     -1 / (2 * sh * ch),                         # 四則
     -1 / sh2]                                   # 倍角公式
for j in range(4):
    check(f"dK^*/dK の鎖 {j}→{j+1} 行目", M[j] == M[j + 1])

# dK^*/dK の左辺を SR の記号微分で独立に作り、鎖の 1〜3 行目（定義・定数倍・合成）と最後の行と比べる
Ks = SR.var('Ks')
lhs_sr = (-log(tanh(Ks)) / 2).diff(Ks)
check("SR: (−(1/2) log∘tanh)'(K) = −(1/2)(log∘tanh)'(K)", bool((lhs_sr - (-(log(tanh(Ks))).diff(Ks) / 2)).simplify_full() == 0))
check("SR: (log∘tanh)'(K) = log'(tanh K)·tanh'(K) = tanh'(K)/tanh K", bool(((log(tanh(Ks))).diff(Ks) - tanh(Ks).diff(Ks) / tanh(Ks)).simplify_full() == 0))
check("SR: dK^*/dK = −1/sinh 2K（両端。exp で書き直して厳密に）", bool((lhs_sr + 1 / sinh(2 * Ks)).exponentialize().simplify_full() == 0))
check("SR 対照: −1/sinh K とは等しくない", bool((lhs_sr + 1 / sinh(Ks)).exponentialize().simplify_full() != 0))
# κ'(K) の鎖（κ(K) = 2K − 2K^*: 和・定数倍・恒等関数の導関数 1）
kp = 2 - 2 * dKs
kap_sr = 2 * Ks - 2 * (-log(tanh(Ks)) / 2)
check("SR: κ' の鎖 (2 id − 2K^*)' = (2 id)' − (2K^*)' = 2 id' − 2 dK^*/dK = 2 − 2 dK^*/dK",
      bool((kap_sr.diff(Ks) - (2 * Ks).diff(Ks) + (2 * (-log(tanh(Ks)) / 2)).diff(Ks)).simplify_full() == 0)
      and bool(Ks.diff(Ks) == 1) and bool((kap_sr.diff(Ks) - (2 - 2 * lhs_sr)).simplify_full() == 0))
check("SR: κ'(K) = 2 + 2/sinh 2K（両端）", bool((kap_sr.diff(Ks) - 2 - 2 / sinh(2 * Ks)).exponentialize().simplify_full() == 0))
check("κ' の鎖 1 行目→2 行目: 2 − 2 dK^*/dK = 2 + 2/sinh 2K", kp == 2 + 2 / sh2)
check("κ' 対照: K^* の符号を誤る（K^* = +(1/2)log tanh K）と 2 + 2/sinh 2K にならない", 2 - 2 * (-dKs) != 2 + 2 / sh2)
# κ' > 2: 2/sinh 2K = 4v^2/(v^4 − 1) で、v > 1（K > 0）なら分母・分子とも正
check("κ' − 2 = 4v^2/(v^4 − 1)（v > 1 で正）", kp - 2 == 4 * v^2 / (v^4 - 1))

# (3) κ''(K) の鎖
kpp = Dv(kp)
# 2'(K) = Dv(2) = 0、(2/S)' = −2S'/S^2、S = sinh∘(2 id): S'(K) = sinh'(2K)·(2 id)'(K)、(2 id)' = 2·id' = 2
S = sh2
check("κ'' の鎖 和の行: Dv(2 + 2/S) = Dv(2) + Dv(2/S)", Dv(2 + 2 / S) == Dv(F(2)) + Dv(2 / S))
check("κ'' の鎖 定数の行: Dv(2) = 0", Dv(F(2)) == 0)
check("κ'' の鎖 商の行: Dv(2/S) = −2 Dv(S)/S^2", Dv(2 / S) == -2 * Dv(S) / S^2)
# 合成: S(K) = sinh(2K)。v ↦ v^2 の代入が 2 id との合成で、Dv(f(v^2)) = (Dv f)(v^2)·2
sh_u = sinh_at(1)
check("κ'' の鎖 合成の行: Dv(sinh(2K)) = sinh'(2K)·(2 id)'(K)、(2 id)' = 2", Dv(sh_u.subs(v=v^2)) == Dv(sh_u).subs(v=v^2) * 2)
check("κ'' の鎖 sinh' = cosh の行: sinh'(2K) = cosh 2K", Dv(sh_u).subs(v=v^2) == ch2)
N = [kpp, -2 * Dv(S) / S^2, -2 * ch2 * 2 / S^2, -4 * ch2 / sh2^2]
for j in range(3):
    check(f"κ'' の鎖のまとめ {j}→{j+1}", N[j] == N[j + 1])
check("κ'' 対照: 合成の 2 を落とすと一致しない", -2 * ch2 / sh2^2 != kpp)

# (4) h(t) = cosh t/sinh^2 t の h' の鎖（ここでは v = exp(t)）
h = ch / sh^2
H = [Dv(h),
     (Dv(ch) * sh^2 - ch * Dv(sh * sh)) / sh^4,       # 商
     (Dv(ch) * sh^2 - ch * 2 * sh * Dv(sh)) / sh^4,   # 積と交換律
     (sh * sh^2 - ch * 2 * sh * ch) / sh^4,            # cosh' = sinh、sinh' = cosh
     (sh^2 - 2 * ch^2) / sh^3,                         # 四則
     (-1 - ch^2) / sh^3]                               # sinh^2 = cosh^2 − 1
check("h' の鎖 1 行目の左辺 Dv(cosh/sinh^2) を商の形と独立に作った（Dv は QQ(v) の導分）", Dv(h) == Dv(ch / sh^2))
for j in range(5):
    check(f"h' の鎖 {j}→{j+1} 行目", H[j] == H[j + 1])
check("|κ''(K)| = 4h(2K): 4cosh 2K/sinh^2 2K が h の t = 2K（v ↦ v^2）での値の 4 倍",
      4 * ch2 / sh2^2 == 4 * h.subs(v=v^2))

# (κ'^2)' = 2κ'κ''
check("(κ'^2)' = 2κ'κ''（積の微分）", Dv(kp^2) == 2 * kp * kpp)
check("対照: (κ'^2)' ≠ κ'κ''", Dv(kp^2) != kp * kpp)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
