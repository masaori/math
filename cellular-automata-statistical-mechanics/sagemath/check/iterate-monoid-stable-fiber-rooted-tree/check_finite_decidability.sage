# 対象ラベル: claim_iterate_monoid_fiber_tree_finite_decidability
# 真理値表から R_F、辺、0..m_F の深さ走査、第二成分の有限数え上げによる分岐数を構成し、定義どおりの値と照合する。
# 帰属: 有限回の二値状態の等号検査、有限集合、非負整数だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
table_applications = 0
depth_tests = 0
branch_tests = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    scanned_R = []
    for y in range(len(F)):
        scanned_R.append(apply_table_power(F, y, lam))
        table_applications += lam
    scanned_R = tuple(scanned_R)
    assert scanned_R == R
    for q in Q:
        edges = tree_edges(scanned_R, fibers[q], q)
        for y in fibers[q]:
            found = None
            for d in range(m + 1):
                depth_tests += 1
                if apply_table_power(F, y, d * lam) == q:
                    found = d
                    break
            assert found == tree_depth(F, lam, m, y, q)
            scanned_branching = sum(1 for edge in edges if edge[1] == y)
            assert scanned_branching == branching_count(edges, y)
            assert scanned_branching == sum(1 for z in fibers[q] if z != q and scanned_R[z] == y)
            branch_tests += len(edges)
    instances += 1

print("global maps checked: {}".format(instances))
print("F applications used to build R tables: {}".format(table_applications))
print("depth equality tests: {}".format(depth_tests))
print("edge comparisons for branching counts: {}".format(branch_tests))
print("RESULT: PASS")
