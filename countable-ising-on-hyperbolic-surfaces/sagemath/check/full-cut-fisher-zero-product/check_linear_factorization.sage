# 対象ラベル: theorem_full_cut_fisher_zero_product
# 式ペア: P_G(x) = Omega_G(|E|) product_j (x-alpha_j)

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-product/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    roots = data["roots_with_multiplicity"]
    factorization = polynomial[edge_count] * prod(x - alpha for alpha in roots)
    assert len(roots) == edge_count, data["name"]
    assert polynomial == factorization, data["name"]

print("RESULT: PASS — each exact QQbar polynomial equals its leading coefficient times all linear factors")
