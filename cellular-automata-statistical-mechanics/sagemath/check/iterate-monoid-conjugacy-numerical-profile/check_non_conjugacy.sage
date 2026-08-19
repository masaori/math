# 対象ラベル: claim_iterate_monoid_conjugacy_numerical_profile_not_complete
# 反例の非共役性を二通りで確かめる。
# (1) 証明の論法: 根 x_0 の直前の頂点は両写像とも {x_1,x_2} で、その子孫集合の個数の多重集合が
#     {{4,2}} と {{3,3}} で異なる。
# (2) 全数走査: 8 元集合上の全 8! = 40,320 個の全単射 h について h∘F=G∘h が全て不成立。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

F_table, G_table = counterexample_tables()
predecessor_data = []
descendant_multisets = []
for table in (F_table, G_table):
    _, _, _, _, _, _, one_period, _, fibers, _ = rooted_tree_data(table)
    fiber = fibers[0]
    edges = tree_edges(one_period, fiber, 0)
    predecessors = frozenset(y for (y, z) in edges if z == 0)
    predecessor_data.append(predecessors)
    descendants = {v: descendant_set(one_period, fiber, v) for v in predecessors}
    descendant_multisets.append(tuple(sorted(len(descendants[v]) for v in predecessors)))

assert predecessor_data[0] == frozenset({1, 2})
assert predecessor_data[1] == frozenset({1, 2})
_, _, _, _, _, _, one_period_f, _, fibers_f, _ = rooted_tree_data(F_table)
assert descendant_set(one_period_f, fibers_f[0], 1) == frozenset({1, 3, 4, 6})
assert descendant_set(one_period_f, fibers_f[0], 2) == frozenset({2, 5})
_, _, _, _, _, _, one_period_g, _, fibers_g, _ = rooted_tree_data(G_table)
assert descendant_set(one_period_g, fibers_g[0], 1) == frozenset({1, 3, 4})
assert descendant_set(one_period_g, fibers_g[0], 2) == frozenset({2, 5, 6})
assert descendant_multisets[0] == (2, 4)
assert descendant_multisets[1] == (3, 3)
assert descendant_multisets[0] != descendant_multisets[1]

exists, witness = conjugacy_scan(F_table, G_table)
assert exists is False and witness is None

import itertools
scanned = 0
for h in itertools.permutations(range(8)):
    assert any(h[F_table[y]] != G_table[h[y]] for y in range(8))
    scanned += 1
assert scanned == 40320

print("descendant multisets: {} vs {}".format(descendant_multisets[0], descendant_multisets[1]))
print("bijections scanned without conjugacy: {}".format(scanned))
print("RESULT: PASS")
