from sage.all import graphs

# 対象ラベル: claim_finite_tree_edge_count
# 根以外の頂点と、根への路の最初の辺との対応を確認する。
checked = 0
for vertices in range(1, 7):
    for tree in graphs.trees(vertices):
        root = tree.vertices(sort=True)[0]
        nonroot = set(tree.vertices(sort=True)) - {root}
        first_edges = {frozenset(tree.shortest_path(v, root)[:2]) for v in nonroot}
        assert len(first_edges) == len(nonroot)
        assert first_edges == {frozenset(edge) for edge in tree.edges(labels=False)}
        checked += 1
print(f"RESULT: PASS root-edge bijection ({checked} trees)")
