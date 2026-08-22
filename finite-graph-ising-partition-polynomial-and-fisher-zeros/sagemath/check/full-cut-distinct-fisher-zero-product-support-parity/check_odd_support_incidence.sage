# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 式: |Z_G| が奇数なら奇接続辺数頂点が存在する
# 帰属: 有限集合、NN

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/_prelude.sage")


for data in example_data:
    if data["root_support_is_odd"]:
        assert data["odd_incident_vertex_exists"], data["name"]

print("RESULT: PASS — odd root support implies an odd incident-edge-count vertex")
