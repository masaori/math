# 対象ラベル: theorem_full_cut_fisher_zero_product
# 式ペア: 1 = (-1)^|E| product_j alpha_j
#          therefore product_j alpha_j = (-1)^|E|

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-product/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    roots = data["roots_with_multiplicity"]
    root_product = QQbar(prod(roots))
    assert polynomial[0] != 0, data["name"]
    assert QQbar(1) == (-1)^edge_count * root_product, data["name"]
    assert root_product == QQbar((-1)^edge_count), data["name"]

print("RESULT: PASS — the multiplicity-counted Fisher zero product is exactly (-1)^|E|")
