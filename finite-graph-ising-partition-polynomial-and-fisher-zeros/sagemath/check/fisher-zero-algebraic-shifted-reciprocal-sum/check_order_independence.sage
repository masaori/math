# 対象ラベル: def_fisher_zero_algebraic_shifted_reciprocal_sum
# 式ペア: sum_j 1/(a-alpha_j) is unchanged by reversing the multiplicity-indexed root order
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            forward = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            reversed_order = sum(((a - alpha)**(-1) for alpha in reversed(data["roots"])), QQbar(0))
            assert forward == reversed_order, (data["name"], a)
print("RESULT: PASS — shifted reciprocal sums are invariant under root-order reversal")
