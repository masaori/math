# 対象ラベル: cosh_sinh_product
# 4 行目（exp(s)exp(t) = exp(s+t) を 4 箇所へ。scalar_exp_product）と、二つの鎖の両端を確かめる。
# 帰属: a, b を QQ[a, b] の不定元に置く。本文の実数の exp は 1 行 1 列の行列の exp の成分であり極限なので、
# 形式冪級数として全次数 D 以下で比べる（exp([z]) の D 次の切り捨ては部分和 S_D([z]) の D 次の切り捨てに等しい）。
# 部分和は本文の定め方（冪を右から 1 つずつ掛ける）で作る（共通の準備 one_by_one_matrix.sage）。
load("../../_shared/one_by_one_matrix.sage")

D = 14
R = PolynomialRing(QQ, 'a,b')
a, b = R.gens()

def E(z):
    """exp(z) の全次数 D 以下の部分。z は QQ[a,b] の一次式。"""
    return truncate_total_degree(entry11(matrix_partial_sum(one_by_one(R, z), D)), D)

def T(p):
    return truncate_total_degree(p, D)

# 4 行目: 3 行目の 4 つの積がそれぞれ exp の和に等しい
pairs = [(a, b), (a, -b), (-a, b), (-a, -b)]
for s, t in pairs:
    assert T(E(s) * E(t)) == E(s + t)
print(f"exp(s)exp(t) = exp(s+t) が 4 つの組 (a,b),(a,-b),(-a,b),(-a,-b) で全次数 {D} 以下で一致")

# 対照: 積の順序を誤って exp(a)exp(-b) = exp(a+b) とすると一致しない
assert T(E(a) * E(-b)) != E(a + b)

# 鎖の両端: 左辺は cosh・sinh の定義を exp の値へ、右辺は sinh(a±b)・cosh(a±b) の定義を exp の値へ、別々に作る
cosh_ = lambda z: (E(z) + E(-z)) / 2
sinh_ = lambda z: (E(z) - E(-z)) / 2
lhs1 = T(cosh_(a) * sinh_(b))
rhs1 = (sinh_(a + b) - sinh_(a - b)) / 2
lhs2 = T(cosh_(a) * cosh_(b))
rhs2 = (cosh_(a + b) + cosh_(a - b)) / 2
assert lhs1 == rhs1 and lhs2 == rhs2
assert lhs1 != 0 and lhs2 != 0
# 対照: 符号を取り違えた (sinh(a+b) + sinh(a-b))/2 は sinh(a)cosh(b) であって cosh(a)sinh(b) ではない
assert lhs1 != (sinh_(a + b) + sinh_(a - b)) / 2
print(f"二つの等式の両辺が全次数 {D} 以下で一致（項数 {len(lhs1.monomials())}, {len(lhs2.monomials())}）")
print("RESULT: PASS")
