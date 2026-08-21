# 対象ラベル: theorem_no_linear_factor_x_minus_one
# 式: (x-1) does not divide Z_G(x) in ZZ[x]
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-linear-factor-x-minus-one/_prelude.sage")

for example in examples:
    x, configurations, polynomial = partition_polynomial(*example)
    quotient, remainder = polynomial.quo_rem(x - 1)
    assert remainder != 0
    assert polynomial != (x - 1) * quotient

print("RESULT: PASS — x-1 divides none of the exact Ising partition polynomials")
