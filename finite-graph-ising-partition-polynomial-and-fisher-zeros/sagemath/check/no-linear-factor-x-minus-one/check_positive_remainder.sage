# 対象ラベル: theorem_no_linear_factor_x_minus_one
# 式: r_G = Z_G(1) = 2^|V| != 0
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-linear-factor-x-minus-one/_prelude.sage")

for vertex_count, edges in examples:
    x, configurations, polynomial = partition_polynomial(vertex_count, edges)
    quotient, remainder = polynomial.quo_rem(x - 1)
    assert polynomial(1) == ZZ(len(configurations))
    assert ZZ(len(configurations)) == ZZ(2) ** vertex_count
    assert remainder == polynomial.parent()(ZZ(2) ** vertex_count)
    assert remainder != 0

print("RESULT: PASS — the exact remainder is the positive integer 2^|V|")
