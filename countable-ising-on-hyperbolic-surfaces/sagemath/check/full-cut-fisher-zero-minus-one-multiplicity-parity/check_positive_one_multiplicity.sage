# 対象ラベル: theorem_full_cut_fisher_zero_minus_one_multiplicity_parity
# 式: Pbar_G(1) = 2^|V| != 0, hence mu_G(1) = 0
# 帰属: NN、QQbar、QQbar[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data in example_data:
    polynomial = data["polynomial"]
    vertex_count = data["vertex_count"]
    assert polynomial(QQbar(1)) == QQbar(ZZ(2)^vertex_count), data["name"]
    assert polynomial(QQbar(1)) != 0, data["name"]
    assert data["plus_one_multiplicity"] == 0, data["name"]

print("RESULT: PASS — +1 is not a Fisher zero and has multiplicity zero")
