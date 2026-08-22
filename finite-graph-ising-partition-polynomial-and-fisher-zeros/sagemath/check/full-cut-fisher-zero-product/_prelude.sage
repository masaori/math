# 対象ラベル: theorem_full_cut_fisher_zero_product
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")


def roots_with_multiplicity(polynomial):
    return tuple(
        alpha
        for alpha, multiplicity in polynomial.roots(ring=QQbar)
        for _index in range(ZZ(multiplicity))
    )


for data in example_data:
    polynomial = data["polynomial"]
    data["roots_with_multiplicity"] = roots_with_multiplicity(polynomial)
