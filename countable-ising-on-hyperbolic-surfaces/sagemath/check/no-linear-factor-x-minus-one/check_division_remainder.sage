# 対象ラベル: theorem_no_linear_factor_x_minus_one
# 式: Z_G(x) = (x-1)Q_G(x)+r_G および r_G=Z_G(1)
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-linear-factor-x-minus-one/_prelude.sage")

for vertex_count, edges in examples:
    x, configurations, polynomial = partition_polynomial(vertex_count, edges)
    quotient, remainder = polynomial.quo_rem(x - 1)
    assert polynomial == (x - 1) * quotient + remainder
    assert remainder == polynomial.parent()(polynomial(1))

print("RESULT: PASS — division by x-1 has remainder Z_G(1) in ZZ[x]")
