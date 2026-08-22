# 対象ラベル: theorem_fisher_zeros_nonzero
# 式ペア: product_j alpha_j != 0 ならば全ての j で alpha_j != 0

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zeros-nonzero/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert prod(roots) != 0, data["name"]
    assert all(alpha != 0 for alpha in roots), data["name"]

print("RESULT: PASS — zero is absent from every exact multiplicity-counted Fisher-zero list")
