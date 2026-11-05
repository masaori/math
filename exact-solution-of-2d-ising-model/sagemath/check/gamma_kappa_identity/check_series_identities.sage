# 対象ラベル: gamma_kappa_identity
# 証明が引く cosh・sinh の関係式と倍角公式を、形式冪級数として厳密に確かめる（QQ 係数、浮動小数点なし）。
# - cosh_addition_formula の複号 −（Step 1 の 4 行目、x = 2K_1 = a, y = 2K_2^* = b）
# - cosh_half_angle_formula（Step 2 の 2・4 行目、x = γ, κ）
# - sinh_is_odd（偶関数性の鎖の 2 行目）
#   cosh・sinh は本文の実数の exp（1 行 1 列の行列の exp の成分。極限）から作るので、部分和（本文の定め方。
#   共通の準備 one_by_one_matrix.sage）を全次数 D 以下で切り捨てて比べる（exp([z]) の D 次の切り捨ては S_D([z]) の切り捨てに等しい）。
# - 倍角公式 cos θ = 1 − 2 sin^2(θ/2)（Step 1 の 7 行目）
#   本文は全実数上の cos・sin を定めていない（euler_formula_cos_sin の前置きが「未整備」と書く）。
#   ここでは cos・sin を通常の冪級数で置き、級数として成り立つことと、θ = πr（r ∈ QQ）の代数的数の値で
#   成り立つことを確かめる。本文の定義との結び付きはこの検算では確かめられない。
load("../../_shared/one_by_one_matrix.sage")

D = 16
ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

R2 = PolynomialRing(QQ, 'a,b')
a, b = R2.gens()
def E2(z):
    return truncate_total_degree(entry11(matrix_partial_sum(one_by_one(R2, z), D)), D)
T2 = lambda p: truncate_total_degree(p, D)
cosh2 = lambda z: (E2(z) + E2(-z)) / 2
sinh2 = lambda z: (E2(z) - E2(-z)) / 2

lhs = T2(cosh2(a) * cosh2(b) - sinh2(a) * sinh2(b))
check(f"加法定理（複号 −）: cosh a cosh b − sinh a sinh b = cosh(a − b)（全次数 {D} 以下）", lhs == cosh2(a - b))
check("加法定理 対照: cosh(a + b) とは一致しない", lhs != cosh2(a + b))
# κ := a − b（def_kappa）で cosh(2K_1 − 2K_2^*) と cosh κ は同じ級数
kappa = a - b
check("def_kappa: cosh(2K_1 − 2K_2^*) と cosh κ は同じ級数", cosh2(a - b) == cosh2(kappa))

R1 = PolynomialRing(QQ, 'x')
x = R1.gen()
def E1(z):
    return truncate_total_degree(entry11(matrix_partial_sum(one_by_one(R1, z), D)), D)
T1 = lambda p: truncate_total_degree(p, D)
cosh1 = lambda z: (E1(z) + E1(-z)) / 2
sinh1 = lambda z: (E1(z) - E1(-z)) / 2
check(f"半角公式: cosh x = 1 + 2 sinh^2(x/2)（次数 {D} 以下）", cosh1(x) == T1(1 + 2 * sinh1(x / 2)^2))
check("半角公式 対照: cosh x ≠ 1 + sinh^2(x/2)", cosh1(x) != T1(1 + sinh1(x / 2)^2))
check("sinh は奇関数: sinh(−x) = −sinh x（級数）", sinh1(-x) == -sinh1(x))
check("偶関数性の鎖の両端: sinh^2(−x/2) = sinh^2(x/2)（級数）", T1(sinh1(-x / 2)^2) == T1(sinh1(x / 2)^2))

# 倍角公式（cos・sin を冪級数で置く）
Dc = 30
P = PowerSeriesRing(QQ, 'th', default_prec=Dc + 1)
th = P.gen()
cos_s = lambda z: sum((-1)^k * z^(2 * k) / factorial(2 * k) for k in range(Dc // 2 + 1)).add_bigoh(Dc + 1)
sin_s = lambda z: sum((-1)^k * z^(2 * k + 1) / factorial(2 * k + 1) for k in range(Dc // 2 + 1)).add_bigoh(Dc + 1)
check(f"倍角公式（級数、次数 {Dc} 以下）: 1 − cos θ = 2 sin^2(θ/2)", 1 - cos_s(th) == 2 * sin_s(th / 2)^2)
check("倍角公式 対照（級数）: 1 − cos θ ≠ sin^2(θ/2)", 1 - cos_s(th) != sin_s(th / 2)^2)

# 倍角公式（θ = πr の代数的数の値。負の θ と |θ| > 2π を含む）
rs = [QQ(r) for r in [0, 1, -1, 1/2, -1/3, 2/5, 7/6, -9/4, 13/3, 5/7, -11/8, 3]]
for r in rs:
    lhs_v = 1 - QQbar(cos(pi * r))
    rhs_v = 2 * QQbar(sin(pi * r / 2))^2
    check(f"倍角公式（厳密値）θ = {r}π", lhs_v == rhs_v)
check("倍角公式 対照（厳密値）θ = 2π/5 で 1 − cos θ ≠ sin^2(θ/2)",
      1 - QQbar(cos(2 * pi / 5)) != QQbar(sin(pi / 5))^2)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
