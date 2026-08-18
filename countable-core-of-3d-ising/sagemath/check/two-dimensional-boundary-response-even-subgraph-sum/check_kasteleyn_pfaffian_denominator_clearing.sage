# 対象ラベル: claim_two_dimensional_boundary_response_even_subgraph_sum
# L'=1, L=2 の四角形から得る 8 頂点 terminal cycle について、
# Kasteleyn 向き付け、Pfaffian 展開、分母消去後の境界応答多項式を厳密に比較する。

polynomial_ring = PolynomialRing(ZZ, names=("X0", "X1", "X2", "X3"))
X = polynomial_ring.gens()
fraction_field = polynomial_ring.fraction_field()

terminal_vertices = tuple(range(8))
cycle_edges = tuple((index, (index + 1) % 8) for index in range(8))

# 一つの辺だけ反時計回りと逆に向けるので、面境界と食い違う辺は 1 本で奇数である。
oriented_edges = ((1, 0),) + cycle_edges[1:]
assert sum(oriented_edges[index] != cycle_edges[index] for index in range(8)) == 1

# 偶数番目は city 内部辺、奇数番目は元の四角形に対応する外部辺である。
external_inverse_weights = tuple(
    fraction_field((1 + variable) / (1 - variable)) for variable in X
)
edge_weights = tuple(
    fraction_field(1) if index % 2 == 0 else external_inverse_weights[index // 2]
    for index in range(8)
)

skew_adjacency = matrix(fraction_field, 8, 8)
for (source, target), weight in zip(oriented_edges, edge_weights):
    skew_adjacency[source, target] += weight
    skew_adjacency[target, source] -= weight

pfaffian = skew_adjacency.pfaffian()

# 8-cycle の完全マッチングは、内部辺 4 本または外部辺 4 本の二つだけである。
dimer_sum = fraction_field(1) + prod(external_inverse_weights)
assert pfaffian == dimer_sum or pfaffian == -dimer_sum

denominator_factor = prod(1 - variable for variable in X)
cleared_pfaffian = polynomial_ring(denominator_factor * pfaffian)
expected_even_subgraph_sum = prod(1 - variable for variable in X) + prod(
    1 + variable for variable in X
)
assert cleared_pfaffian == expected_even_subgraph_sum or cleared_pfaffian == -expected_even_subgraph_sum

print("RESULT: PASS — Kasteleyn Pfaffian の分母消去後に R^(2)_{2,1} の偶部分グラフ和と一致")
