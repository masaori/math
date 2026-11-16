# 対象ラベル: matrix_norm_triangle_inequality（Step 1 の ι_{ℝ→ℂ} が和と積を保つ 2 つの等式）
#   ι(x) + ι(y) = ι(x + y)   (∵ real_inclusion_preserves_sum（a → x, b → y）)
#   ι(x)·ι(y)   = ι(xy)      (∵ real_inclusion_preserves_product（a → x, b → y）)
# 各行の左辺と右辺を、行に書かれた式どおりに別々に組み、等しいことを確かめる。
# 複素数は definition_of_cc のとおり実数の組で持ち、和と積はその式で組む。ι は inclusion_rr_to_cc。
# 帰属: QQ 上の多項式環 QQ[x, y]（x, y は不定元）。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ。
P = PolynomialRing(QQ, "x,y")
x, y = P.gens()
zero = P(0)


def cc_add(z, w):
    return (z[0] + w[0], z[1] + w[1])                               # definition_of_cc の和


def cc_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])  # definition_of_cc の積


def iota(r):
    return (r, zero)                                                # inclusion_rr_to_cc


checks = 0
# 和の行
lhs, rhs = cc_add(iota(x), iota(y)), iota(x + y)
assert lhs == rhs
checks += 1
# 積の行
lhs, rhs = cc_mul(iota(x), iota(y)), iota(x * y)
assert lhs == rhs
checks += 1
print(f"checked {checks} equalities with indeterminates x, y")
# 対照: 第 2 成分の 0 を 1 に替えると和も積も保たれない
assert cc_add((x, P(1)), (y, zero)) != iota(x + y)
assert cc_mul((x, P(1)), (y, zero)) != iota(x * y)
print("negative control: (x,1)+(y,0) != ι(x+y), (x,1)·(y,0) != ι(xy)")
print("RESULT: PASS")
