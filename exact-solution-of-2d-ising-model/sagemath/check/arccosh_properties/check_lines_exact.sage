# 対象ラベル: arccosh_properties
# 証明の等号の行を厳密に確かめる。
# - exp の性質を使わない行: exp(u)・exp(-u)・exp(-u+u)・exp(0)・cosh t・sinh t の値を QQ 上の独立な不定元に置き、
#   各行の両辺の差が「その行の (∵) が引く関係式だけ」で生成したイデアルに入ること、
#   かつ（関係式を使う行では）関係式なしでは差が 0 でないことを確かめる。不定元で成り立つ多項式の等号は、
#   不定元へ実数の値を代入しても成り立つ（代入は環準同型である）。
# - exp の性質を使う行（scalar_exp_product・scalar_exp_zero）: 積の法則は本文の exp の部分和から作った形式冪級数を
#   全次数 D_SERIES 以下で比べ（hyperbolic_by_definition.sage の exp_series）、exp(0) = 1 は部分和で厳密に確かめる。
# - log の行（log 1 = log(exp 0) = 0、t = log(exp t)）は、exp(0) = 1 の厳密な確かめと log の逆写像の定義
#   （def_real_logarithm_positive）から従う。具体の点での囲みは check_statement_with_balls.sage が持つ。
# - 準備の r ≥ 0・r^2 = y^2 - 1・y + r ≥ 1 と (4) の行: 具体の y ∈ AA（実代数的数）で厳密に。
load("../../_shared/hyperbolic_by_definition.sage")

# y, r: 準備の記号。E = exp(u), F = exp(-u), X = exp(-u+u), X0 = exp(0)。C = cosh t, S = sinh t。
P = PolynomialRing(QQ, ['y', 'r', 'E', 'F', 'X', 'X0', 'C', 'S'])
y, r, E, F, X, X0, C, S = P.gens()


def line_holds_by(lhs, rhs, relations, label):
    """lhs - rhs が relations だけで生成したイデアルに入る。relations が空でなければ、関係式なしでは差が 0 でない。"""
    d = P(lhs) - P(rhs)
    if relations:
        assert d in P.ideal(relations), label
        assert d != 0, label + "（関係式を使わずに成り立ってしまう）"
    else:
        assert d == 0, label
    print("  PASS", label)


r_rel = r^2 - (y^2 - 1)          # 準備: r^2 = y^2 - 1
expu_rel = E - (y + r)            # (2): exp(u) = y + r
diff_rel = y^2 - r^2 - 1          # (2): y^2 - r^2 = 1

print("(2) y^2 - r^2 の鎖")
line_holds_by(y^2 - r^2, y^2 - (y^2 - 1), [r_rel], "y^2 - r^2 = y^2 - (y^2 - 1)（r^2 = y^2 - 1）")
line_holds_by(y^2 - (y^2 - 1), 1, [], "y^2 - (y^2 - 1) = 1（R の四則）")

print("(2) exp(-u) の鎖")
chain = [
    (F, F * (y^2 - r^2), [diff_rel], "exp(-u) = exp(-u)(y^2 - r^2)（y^2 - r^2 = 1）"),
    (F * (y^2 - r^2), F * ((y + r) * (y - r)), [], "= exp(-u)((y+r)(y-r))（和と差の積）"),
    (F * ((y + r) * (y - r)), F * (E * (y - r)), [expu_rel], "= exp(-u)(exp(u)(y-r))（exp(u) = y + r）"),
    (F * (E * (y - r)), (F * E) * (y - r), [], "= (exp(-u)exp(u))(y-r)（積の結合律）"),
    ((F * E) * (y - r), X * (y - r), [F * E - X], "= exp(-u+u)(y-r)（scalar_exp_product。不定元の関係として）"),
    (X * (y - r), X0 * (y - r), [X - X0], "= exp(0)(y-r)（-u+u = 0。不定元の関係として）"),
    (X0 * (y - r), 1 * (y - r), [X0 - 1], "= 1·(y-r)（scalar_exp_zero。不定元の関係として）"),
    (1 * (y - r), y - r, [], "= y - r（積の単位元）"),
]
for lhs, rhs, rels, label in chain:
    line_holds_by(lhs, rhs, rels, label)

print("(2) cosh の鎖（分母 2 を払って QQ 係数の多項式で比べる）")
# 1 行目 cosh(arccosh y) = cosh(u) は u := arccosh(y) の定め方そのもので、計算を含まない。
# 2 行目は定義の関数（cosh_by_definition）と本文の式の書き写しの一致で、定義の適用なので自明に通る。
cosh_u = cosh_by_definition(E, F)
expmu_rel = F - (y - r)
line_holds_by(2 * cosh_u, (E + F), [], "cosh(u) = (exp(u)+exp(-u))/2（def_cosh_sinh の書き写し）")
line_holds_by(E + F, (y + r) + F, [expu_rel], "= ((y+r) + exp(-u))/2（exp(u) = y + r）")
line_holds_by((y + r) + F, (y + r) + (y - r), [expmu_rel], "= ((y+r)+(y-r))/2（exp(-u) = y - r）")
line_holds_by((y + r) + (y - r), 2 * y, [], "= 2y/2（R の加法）")
assert (2 * y) / 2 == y
print("  PASS = y（約分）")

print("(3) (sinh t)^2 の鎖")
pyth_rel = C^2 - S^2 - 1          # cosh_sinh_basic_properties (2)
line_holds_by(S^2, C^2 - 1, [pyth_rel], "(sinh t)^2 = (cosh t)^2 - 1（cosh_sinh_basic_properties (2) と移項）")
line_holds_by(C^2 - 1, y^2 - 1, [C - y], "= y^2 - 1（cosh t = y）")

print("(3) t の鎖の行")
# cosh_sinh_basic_properties (1) の exp(t) = cosh t + sinh t は、exp(t)・exp(-t) を不定元 E・F に置くと
# 定義の展開だけで成り立つ（exp の性質を使わない）。関係式なしで成り立つことを確かめる。
line_holds_by(E, cosh_by_definition(E, F) + sinh_by_definition(E, F), [],
              "exp(t) = cosh t + sinh t（cosh_sinh_basic_properties (1)。定義の展開で、exp の値によらない）")
line_holds_by(C + S, y + S, [C - y], "cosh t + sinh t = y + sinh t（cosh t = y）")
line_holds_by(y + S, y + r, [S - r], "y + sinh t = y + r（sinh t = r）")

print("exp の性質を使う行（形式冪級数、全次数 %d 以下）" % D_SERIES)
# exp(-u)exp(u) = exp(-u+u): 積の法則 scalar_exp_product を二変数 a, b の形式冪級数で確かめ、a = -u, b = u を代入する。
Rab = PolynomialRing(QQ, ['a', 'b']); a, b = Rab.gens()
prod_ab = truncate_total_degree(exp_series(Rab, a) * exp_series(Rab, b), D_SERIES)
assert prod_ab == exp_series(Rab, a + b)
assert prod_ab != exp_series(Rab, a - b)          # 対照: 指数を取り違えた形とは一致しない
Ru = PolynomialRing(QQ, 'u'); u = Ru.gen()
sub = Rab.hom([-u, u], Ru)
lhs_u = truncate_total_degree(exp_series(Ru, -u) * exp_series(Ru, u), D_SERIES)
assert lhs_u == truncate_total_degree(sub(prod_ab), D_SERIES)
print("  PASS exp(-u)exp(u) = exp(-u+u)（exp(a)exp(b) = exp(a+b) を QQ[a,b] で確かめ a = -u, b = u を代入。対照: exp(a-b) とは一致しない）")
# -u + u = 0
assert -u + u == 0
print("  PASS -u + u = 0（QQ[u] で）")
# exp(0) = 1（scalar_exp_zero）: 本文の部分和 S_N([0]) は N によらず [1]
for N in range(0, 25):
    assert entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), N)) == 1
print("  PASS exp(0) = 1（部分和 S_N([0]) = [1]、N = 0..24）")
# sinh 0 = (exp(0) - exp(-0))/2 = 0: -0 = 0 と exp(0) = 1
assert -QQ(0) == 0
e0 = entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), 30))
assert sinh_by_definition(e0, e0) == 0 and (QQ(1) - 1) / 2 == 0
print("  PASS sinh 0 = (exp(0) - exp(-0))/2 = (exp(0)-exp(0))/2 = (1-1)/2 = 0")

print("準備の r と (4)（AA で厳密）")
Y_POINTS = [AA(1), AA(1) + AA(1) / 10^6, AA(5) / 4, AA(2), AA(2).sqrt() + 1, AA(17) / 8, AA(10)^6]
for y0 in Y_POINTS:
    assert y0 >= 1
    assert y0^2 - 1 >= 0                          # def_arccosh: 平方根の中身は非負
    r0 = (y0^2 - 1).sqrt()                        # AA の非負の平方根
    assert r0 >= 0 and r0^2 == y0^2 - 1           # definition_of_sqrt_r_positive
    # 一意性: r^2 = y^2 - 1 を満たす実数は ±r0 の二つで、非負なのは r0 だけ（y0 > 1 のとき -r0 < 0）
    roots = [z for z, _ in (PolynomialRing(AA, 'z').gen()^2 - (y0^2 - 1)).roots()]
    assert [z for z in roots if z >= 0] == [r0]
    assert y0 + r0 >= 1                           # def_arccosh: log の引数は 1 以上
    if y0 > 1:
        assert y0 + r0 > 1
print(f"  PASS {len(Y_POINTS)} 点の y で r ≥ 0、r^2 = y^2 - 1、非負の根の一意性、y + r ≥ 1（y > 1 なら > 1）")
# (4) の鎖を一行ずつ: √(1^2-1) → √(1-1)（power_of_real_one_is_one の m → 2）→ √0（ℝ で a - a = 0 の a → 1）
#   → 0（sqrt_of_real_zero_is_zero）→ log(1+0) → log 1（1 + 0 = 1）
assert QQ(1)^2 == 1                               # power_of_real_one_is_one（m → 2）
assert QQ(1)^2 - 1 == QQ(1) - 1                   # 2 行目: 根号の中身 1^2 - 1 = 1 - 1
a = QQ['a'].gen()
assert a - a == 0                                 # ℝ で a - a = 0（a は不定元。次の行で a → 1）
assert QQ(1) - 1 == 0                             # 3 行目: 根号の中身 1 - 1 = 0
assert AA(0).sqrt() == 0 and AA(0) >= 0 and AA(0)^2 == 0   # sqrt_of_real_zero_is_zero
assert 1 + 0 == 1
# 否定の対照: 1^2 を 2·1 と取り違えると根号の中身は 1 で、√1 = 1 ≠ 0 になる
assert 2 * QQ(1) - 1 != 0 and AA(2 * QQ(1) - 1).sqrt() != 0
print("  PASS (4) 1^2 = 1、1 - 1 = 0、√0 = 0（0 ≥ 0 かつ 0^2 = 0）、1 + 0 = 1（対照: 1^2 を 2 と取り違えると √1 = 1 ≠ 0）")
print("RESULT: PASS")
