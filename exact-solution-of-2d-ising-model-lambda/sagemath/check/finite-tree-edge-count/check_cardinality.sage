from sage.all import graphs

# 対象ラベル: claim_finite_tree_edge_count
# 本文の等式 |E|+1 = |V\{o}|+1 = |V| を行ごとに確認する。
checked = 0
for vertices in range(1, 7):
    for tree in graphs.trees(vertices):
        root = tree.vertices(sort=True)[0]
        nonroot = set(tree.vertices(sort=True)) - {root}
        assert tree.size() + 1 == len(nonroot) + 1
        assert len(nonroot) + 1 == tree.order()
        checked += 1
print(f"RESULT: PASS cardinality ({checked} trees)")
