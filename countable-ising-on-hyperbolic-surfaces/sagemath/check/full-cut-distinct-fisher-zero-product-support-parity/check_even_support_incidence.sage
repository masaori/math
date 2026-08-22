# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 式: |Z_G| が偶数なら全頂点の接続辺数が偶数である
# 帰属: 有限集合、NN

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/_prelude.sage")


for data in example_data:
    if not data["root_support_is_odd"]:
        assert not data["odd_incident_vertex_exists"], data["name"]
        assert all(count % 2 == 0 for count in data["incident_edge_counts"]), data["name"]

print("RESULT: PASS — even root support implies even incident-edge counts at every vertex")
