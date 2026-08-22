# 対象ラベル: theorem_full_cut_fisher_zero_minus_one_multiplicity_parity
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")


for data, (_name, vertex_count, _edges) in zip(example_data, examples):
    polynomial = data["polynomial"]
    root_multiplicities = {
        alpha: NN(multiplicity)
        for alpha, multiplicity in polynomial.roots(ring=QQbar)
    }
    data["root_multiplicities"] = root_multiplicities
    data["vertex_count"] = NN(vertex_count)
    data["minus_one_multiplicity"] = root_multiplicities.get(QQbar(-1), NN(0))
    data["plus_one_multiplicity"] = root_multiplicities.get(QQbar(1), NN(0))
