# ---------------------------------------------------------
# SageMath: specific_heat_log_divergence の Step 4 の x log(1/x) <= 1/e の鎖を一行ずつ確かめる
#   g(x) := x log(1/x)（x > 0）、e := exp(1)
#   (t -> 1/t)'(t) = (0*t - 1*1)/t^2 = -1/t^2、(t -> log(1/t))'(t) = (1/(1/t))*(-1/t^2)
#   g'(t) = 1*log(1/t) + t*((1/(1/t))*(-1/t^2)) = log(1/t) - 1
#   0 < t < 1/e なら g'(t) > 0、t = 1/e なら g'(t) = log(exp 1) - 1 = 0、1/e < t なら g'(t) < 0
#   0 < x <= 1/e: g(1/e) - g(x) = int_x^{1/e} g' >= int 0 = 0
#   1/e <= x <= 1: g(x) - g(1/e) = int_{1/e}^x g' <= int 0 = 0
#   g(1/e) = (1/e) log(1/(1/e)) = (1/e) log(exp 1) = 1/e
#   Step 4 の 1 行目 |(k'^2 - 16) G''| = |k'^2 - 16| |G''|
# 記号計算（SR）で等号を厳密に確かめる（log を含む差は、正の引数について正しい canonicalize_radical で 0 に直す）。e を含む値の符号と大小は、区間演算 RealIntervalField(256)
# で確かめる（e と log の値を区間で囲むための ℝ 脱出。区間が判定できなければ FAIL になる）。
# ---------------------------------------------------------
all_ok = True
def report(name, ok):
    global all_ok
    print(f"  {name}: {'PASS' if ok else 'FAIL'}")
    all_ok = all_ok and bool(ok)

t, x, w = var('t x w')
assume(t > 0); assume(x > 0)
g = lambda u: u * log(1 / u)
E = exp(1)
RI = RealIntervalField(256)
pos = lambda v: bool(RI(v) > 0)
neg = lambda v: bool(RI(v) < 0)

print("=== g'(t) の鎖 ===")
zero = lambda v: bool(SR(v).canonicalize_radical() == 0)
report("(t -> 1/t)'(t) = (0*t - 1*1)/t^2", zero(diff(1 / t, t) - (0 * t - 1 * 1) / t**2))
report("= -1/t^2", zero((0 * t - 1 * 1) / t**2 - (-1 / t**2)))
report("(t -> log(1/t))'(t) = (1/(1/t))*(-1/t^2)", zero(diff(log(1 / t), t) - (1 / (1 / t)) * (-1 / t**2)))
d_raw = diff(g(t), t)
line1 = 1 * log(1 / t) + t * ((1 / (1 / t)) * (-1 / t**2))
line2 = log(1 / t) - 1
report("g'(t) = 1*log(1/t) + t*((1/(1/t))*(-1/t^2))", zero(d_raw - line1))
report("= log(1/t) - 1", zero(line1 - line2))

print("=== g' の符号 ===")
inv_e = 1 / E
lefts = [QQ(1) / 1000, QQ(1) / 10, QQ(1) / 4, QQ(36) / 100]   # いずれも 1/e より小さい
rights = [QQ(38) / 100, QQ(1) / 2, QQ(9) / 10, QQ(1)]           # いずれも 1/e より大きい
report("標本点が 1/e の左右にある", all(pos(inv_e - q) for q in lefts) and all(neg(inv_e - q) for q in rights))
report("0 < t < 1/e で g'(t) > 0", all(pos(line2.subs(t=q)) for q in lefts))
report("t = 1/e で g'(t) = log(exp 1) - 1 = 0", zero(line2.subs(t=inv_e)) and bool(log(exp(1)) - 1 == 0))
report("1/e < t で g'(t) < 0", all(neg(line2.subs(t=q)) for q in rights))

print("=== (R4) と (R3) の鎖 ===")
G = lambda a, b: integral(line2, t, a, b)
ok = True
for q in lefts:
    lhs = g(inv_e) - g(q)
    ok = ok and zero(lhs - G(q, inv_e)) and pos(G(q, inv_e))
report("0 < x <= 1/e: g(1/e) - g(x) = int_x^{1/e} g' >= 0", ok)
ok = True
for q in rights:
    lhs = g(q) - g(inv_e)
    ok = ok and zero(lhs - G(inv_e, q)) and neg(G(inv_e, q))
report("1/e <= x <= 1: g(x) - g(1/e) = int_{1/e}^x g' <= 0", ok)
report("(R4) を定数関数 F = 0 で: int 0 = 0", bool(integral(SR(0), t, QQ(1) / 10, inv_e) == 0))

print("=== g(1/e) の鎖 ===")
v1 = g(inv_e)
v2 = (1 / E) * log(1 / (1 / E))
v3 = (1 / E) * log(exp(1))
v4 = 1 / E
report("g(1/e) = (1/e) log(1/(1/e))", zero(v1 - v2))
report("= (1/e) log(exp 1)", zero(v2 - v3))
report("= 1/e", zero(v3 - v4))

print("=== 結論: 0 < x <= 1 なら g(x) <= 1/e（否定コントロール: 1/e を少し下げると x = 1/e で破れる） ===")
samples = [QQ(k) / 200 for k in range(1, 201)]
report("0 < x <= 1 の標本点で g(x) <= 1/e", all(pos(inv_e - g(q)) for q in samples if q != QQ(1)))
report("x = 1 で g(1) = 0", bool(g(SR(1)) == 0))
report("否定コントロール: 上界を 1/e - 1/10^6 に下げると x = 1/e で破れる", pos(g(inv_e) - inv_e + QQ(1) / 10**6))

print("=== Step 4 の 1 行目: |a b| = |a| |b| ===")
ok = all(abs(QQ(a) * QQ(b)) == abs(QQ(a)) * abs(QQ(b)) for a in [-3, -QQ(1)/2, 0, 2] for b in [-5, QQ(7)/3, 0])
report("|a b| = |a| |b|（有理数の標本点）", ok)

print()
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
