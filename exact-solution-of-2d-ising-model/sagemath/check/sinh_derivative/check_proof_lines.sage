# 対象ラベル: sinh_derivative
# 証明の鎖 sinh'(x) = (½(exp - exp∘n))'(x) = ½(exp - exp∘n)'(x) = ½(exp'(x) - (exp∘n)'(x))
#   = ½(exp'(x) - exp'(n(x))·n'(x)) = ½(exp(x) - exp(n(x))·n'(x)) = ½(exp(x) - exp(-x)·n'(x)) = ½(exp(x) - exp(-x)·(-1))
#   = (exp(x)+exp(-x))/2 = cosh x（n(x) := -x）の九行を確かめる。
# 帰属: 本文の exp は部分和の極限なので、QQ[x] の形式冪級数として確かめる。全次数 D 以下の部分の微分は、
#   導関数の全次数 D-1 以下の部分に等しい（項ごとの微分）。微分の公式（和・定数倍・合成・exp' = exp）そのものは
#   本文が外部から持ち込む事実で、ここではそれを当てはめた各行の値が一致することを確かめる。
#   あわせて Sage の記号微分（SR）でも両端を比べる。
load("../../_shared/hyperbolic_by_definition.sage")
D = D_SERIES
P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p, d=D - 1: truncate_total_degree(p, d)
E, Em = exp_series(P, x), exp_series(P, -x)
lhs = sinh_by_definition(E, Em).derivative(x)                  # sinh' を級数の項ごとの微分で
lineA = ((E - Em) / 2).derivative(x)                           # 1 行目: sinh = ½(exp - exp∘n)
lineB = (E - Em).derivative(x) / 2                             # 2 行目: 定数倍
assert lhs == lineA == lineB
line1 = (E.derivative(x) - Em.derivative(x)) / 2               # 3 行目: 和
assert lineB == line1
n_prime = (-x).derivative(x)
assert n_prime == -1
line2 = (E.derivative(x) - T(E.derivative(x)(x=-x)) * n_prime) / 2   # 合成: (exp∘n)' = exp'(n(x))·n'(x)
assert T(line1) == T(line2)
assert T(E.derivative(x)) == T(E)                               # exp' = exp（全次数 D-1 以下）
line3n = (T(E) - T(E(x=-x)) * n_prime) / 2                     # exp' = exp を 2 箇所へ（exp(n(x)) のまま）
assert T(line2) == T(line3n)
line3a = (T(E) - T(Em) * n_prime) / 2                           # n(x) = -x：exp(n(x)) = exp(-x)
assert line3n == line3a
assert (-1 * x).derivative(x) == -1 * x.derivative(x) == -1      # n = (-1)·id、定数倍と恒等関数の導関数 1
line3 = (T(E) - T(Em) * (-1)) / 2
assert line3a == line3
line4 = (T(E) + T(Em)) / 2
assert line3 == line4
line5 = T(cosh_by_definition(E, Em))
assert line4 == line5
assert T(lhs) != T(sinh_by_definition(E, Em))                  # 対照: sinh' は sinh ではない
print(f"九行が QQ[x] の形式冪級数で全次数 {D - 1} 以下で一致する（sinh' ≠ sinh は対照）")
xs = SR.var('xs')
assert bool(((exp(xs) - exp(-xs)) / 2).diff(xs) == (exp(xs) + exp(-xs)) / 2)
print("SR の記号微分でも sinh' = cosh の両端が一致する")
print("RESULT: PASS")
