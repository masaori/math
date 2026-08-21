# 対象ラベル: theorem_full_cut_fisher_zero_product
# 式ペア: Omega_G(0) = P_G(0) = Omega_G(|E|) product_j (0-alpha_j)

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-product/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    roots = data["roots_with_multiplicity"]
    constant_term = polynomial[0]
    substituted_factorization = polynomial[edge_count] * prod(-alpha for alpha in roots)
    assert constant_term == polynomial(0), data["name"]
    assert polynomial(0) == substituted_factorization, data["name"]

print("RESULT: PASS — evaluating every exact linear factorization at zero gives the constant coefficient")
