# 対象ラベル: theorem_fisher_zero_shifted_product_configuration_count
# 式ペア: Z_G(1) = 2^|V|
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-shifted-product-configuration-count/_prelude.sage")
for data in examples:
    left = data["polynomial"](QQbar(1))
    right = QQbar(2 ** data["vertex_count"])
    assert left == right, data["name"]
print("RESULT: PASS — evaluation at one equals the number of spin configurations")
