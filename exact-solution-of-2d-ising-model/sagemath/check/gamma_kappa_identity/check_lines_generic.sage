# 対象ラベル: gamma_kappa_identity
# 証明の鎖のうち、cosh・sinh・cos・sin の値を独立な不定元に置いても成り立つ行（四則・記号の書き換え）と、
# 引いた関係式 1 本だけで成り立つ行を、QQ 上の多項式環で厳密に確かめる。浮動小数点は使わない。
#
# 不定元の対応（証明の記号 → 不定元）:
#   c1, s1, c2s, s2s : c_1 = cosh 2K_1, s_1 = sinh 2K_1, c_2^* = cosh 2K_2^*, s_2^* = sinh 2K_2^*
#   co                : cos θ
#   v                 : sin(θ/2)
#   ck                : cosh κ（κ = 2K_1 − 2K_2^*）。cosh(2K_1 − 2K_2^*) も同じ値なのでこれで表す
#   A                 : A = s_1 s_2^*（def_critical_sinh_product_A）
#   C, t              : cosh γ(θ), sinh(γ(θ)/2)
#   u                 : sinh(κ/2)
#   g1                : γ_1(θ)
# 各行の等号が「その行の (∵) が引く関係式だけ」を法として成り立ち、その関係式を抜くと成り立たないことを確かめる。

R = PolynomialRing(QQ, 'c1,s1,c2s,s2s,co,v,ck,A,C,t,u,g1', order='degrevlex')
c1, s1, c2s, s2s, co, v, ck, A, C, t, u, g1 = R.gens()

def holds_mod(lhs, rhs, rels):
    """lhs − rhs が rels の生成するイデアルに入るか（グレブナー基底で判定。rels が空なら多項式の等号）。"""
    d = R(lhs - rhs)
    if not rels:
        return d == 0
    return d in R.ideal(rels)

ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

# ---- Step 1 の鎖 ----
# 加法定理（cosh_addition_formula の複号 −）: c1 c2s − s1 s2s = cosh(2K_1 − 2K_2^*) = ck（κ の定義で同じ値）
rel_add = c1 * c2s - s1 * s2s - ck
rel_A = A - s1 * s2s                       # def_critical_sinh_product_A
rel_double = (1 - co) - 2 * v^2            # 倍角公式 cos θ = 1 − 2 sin^2(θ/2)

S1 = [
    c1 * c2s - s1 * s2s * co,                                   # 1 行目（def_gamma1_gamma2_of_theta）
    (c1 * c2s - s1 * s2s) + s1 * s2s * (1 - co),                # 2 行目（分配則）
    (c1 * c2s - s1 * s2s) + s1 * s2s * (1 - co),                # 3 行目（略記の書き換え。不定元は同じ値を表す）
    ck + s1 * s2s * (1 - co),                                   # 4 行目（加法定理）
    ck + s1 * s2s * (1 - co),                                   # 5 行目（κ の定義。cosh(2K_1−2K_2^*) と cosh κ は同じ値）
    ck + A * (1 - co),                                          # 6 行目（A の定義）
    ck + 2 * A * v^2,                                           # 7 行目（倍角公式）
]
check("Step 1: 1→2 行目は多項式の等号（分配則だけ）", holds_mod(S1[0], S1[1], []))
check("Step 1: 2→3 行目は略記の書き換え（同じ不定元）", S1[1] == S1[2])
check("Step 1: 3→4 行目は加法定理の関係式だけで成り立つ", holds_mod(S1[2], S1[3], [rel_add]))
check("Step 1: 3→4 行目は加法定理なしでは成り立たない", not holds_mod(S1[2], S1[3], []))
check("Step 1: 4→5 行目は κ の定義の書き換え（同じ不定元）", S1[3] == S1[4])
check("Step 1: 5→6 行目は A の定義だけで成り立つ", holds_mod(S1[4], S1[5], [rel_A]))
check("Step 1: 5→6 行目は A の定義なしでは成り立たない", not holds_mod(S1[4], S1[5], []))
check("Step 1: 6→7 行目は倍角公式だけで成り立つ", holds_mod(S1[5], S1[6], [rel_double]))
check("Step 1: 6→7 行目は倍角公式なしでは成り立たない", not holds_mod(S1[5], S1[6], []))
check("Step 1: 鎖の両端は三つの関係式で成り立つ", holds_mod(S1[0], S1[6], [rel_add, rel_A, rel_double]))
for k, r in enumerate([rel_add, rel_A, rel_double]):
    rest = [x for j, x in enumerate([rel_add, rel_A, rel_double]) if j != k]
    check(f"Step 1: 鎖の両端は関係式 {k} を抜くと成り立たない", not holds_mod(S1[0], S1[6], rest))
# 対照: 倍角公式の係数を誤って 1 − cos θ = sin^2(θ/2) とすると 7 行目へ着かない
check("Step 1 対照: 1 − cos θ = sin^2(θ/2) では 7 行目に着かない",
      not holds_mod(S1[5], S1[6], [(1 - co) - v^2]))

# cosh γ = γ_1 の鎖: cosh(arccosh(γ_1)) = γ_1 は arccosh_properties (2)。値の検算は check_lines_with_balls.sage。

# ---- Step 2 の鎖 ----
rel_half_gamma = C - (1 + 2 * t^2)         # cosh_half_angle_formula を x = γ に
rel_step1 = C - (ck + 2 * A * v^2)         # Step 1 の 1 番目の式（cosh γ = γ_1 = cosh κ + 2A sin^2(θ/2)）
rel_half_kappa = ck - (1 + 2 * u^2)        # cosh_half_angle_formula を x = κ に

S2 = [
    t^2,                                                        # 左辺 sinh^2(γ/2)
    ((1 + 2 * t^2) - 1) / 2,                                    # 1 行目（四則）
    (C - 1) / 2,                                                # 2 行目（半角公式 x = γ）
    ((ck + 2 * A * v^2) - 1) / 2,                               # 3 行目（Step 1）
    ((1 + 2 * u^2 + 2 * A * v^2) - 1) / 2,                      # 4 行目（半角公式 x = κ）
    u^2 + A * v^2,                                              # 5 行目（四則）
]
rels2 = [[], [rel_half_gamma], [rel_step1], [rel_half_kappa], []]
for k in range(5):
    check(f"Step 2: {k}→{k+1} 行目は引いた関係式だけで成り立つ", holds_mod(S2[k], S2[k + 1], rels2[k]))
    if rels2[k]:
        check(f"Step 2: {k}→{k+1} 行目は引いた関係式なしでは成り立たない", not holds_mod(S2[k], S2[k + 1], []))
check("Step 2: 鎖の両端は三つの関係式で成り立つ",
      holds_mod(S2[0], S2[5], [rel_half_gamma, rel_step1, rel_half_kappa]))
check("Step 2 対照: 主張を sinh^2(κ/2) + 2A sin^2(θ/2) と誤ると成り立たない",
      not holds_mod(S2[0], u^2 + 2 * A * v^2, [rel_half_gamma, rel_step1, rel_half_kappa]))

# ---- Step 3 ----
# S = sinh^2(γ/2) = (sinh(γ/2))^2（Step 2 と記法）: S を 5 行目の式として、t^2 との差が Step 2 の関係式で消える
Sdef = u^2 + A * v^2
check("Step 3: S = (sinh(γ/2))^2 は Step 2 の三つの関係式で成り立つ",
      holds_mod(Sdef, t^2, [rel_half_gamma, rel_step1, rel_half_kappa]))
# γ = 2·(γ/2) は QQ の四則。偶関数性: (−a)^2 = a^2
check("偶関数性: (−u)^2 = u^2（多項式の等号）", (-u)^2 == u^2)
check("偶関数性: 右辺 u^2 + A v^2 は u → −u で不変", Sdef.subs(u=-u) == Sdef)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
