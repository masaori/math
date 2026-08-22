# 対象ラベル: theorem_full_cut_fisher_zero_minus_one_multiplicity_parity
# 式: sum_{alpha in Z_G minus {-1,1}} mu_G(alpha) = 0 mod 2
# 帰属: 有限集合、NN、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data in example_data:
    root_multiplicities = data["root_multiplicities"]
    nonfixed_roots = tuple(
        alpha
        for alpha in root_multiplicities
        if alpha not in (QQbar(-1), QQbar(1))
    )
    for alpha in nonfixed_roots:
        assert alpha != alpha^(-1), (data["name"], alpha)
        assert alpha^(-1) in root_multiplicities, (data["name"], alpha)
        assert root_multiplicities[alpha^(-1)] == root_multiplicities[alpha], (
            data["name"],
            alpha,
        )
    nonfixed_multiplicity_sum = NN(
        sum(root_multiplicities[alpha] for alpha in nonfixed_roots)
    )
    assert nonfixed_multiplicity_sum.mod(2) == 0, data["name"]

print("RESULT: PASS — every nonfixed inverse orbit has even total multiplicity")
