# 対象ラベル: claim_iterate_monoid_fiber_tree_edge_count
# y↦(y,R_F(y)) の全単射と |T_F(q)|=|B_F(q)|-1 を検査する。
# 帰属: 有限集合の対・等号・個数だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
fibers_checked = 0
edges_checked = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    for q in Q:
        domain = frozenset(y for y in fibers[q] if y != q)
        edges = tree_edges(R, fibers[q], q)
        assert frozenset(y for y, _ in edges) == domain
        assert all(z == R[y] and z in fibers[q] for y, z in edges)
        assert len(edges) == len(domain) == len(fibers[q]) - 1
        fibers_checked += 1
        edges_checked += len(edges)
    instances += 1

print("global maps checked: {}".format(instances))
print("stable fibers checked: {}".format(fibers_checked))
print("tree edges checked: {}".format(edges_checked))
print("RESULT: PASS")
