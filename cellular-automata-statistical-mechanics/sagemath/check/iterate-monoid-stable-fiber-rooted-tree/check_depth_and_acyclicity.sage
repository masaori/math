# 対象ラベル: claim_iterate_monoid_fiber_tree_depth_decrement
# 深さ零の特徴づけ、非根での一段減少、深さの厳密減少による有向閉路不存在を検査する。
# 帰属: 有限写像の等号と非負整数の大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
vertices_checked = 0
edges_checked = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    for q in Q:
        depths = {y: tree_depth(F, lam, m, y, q) for y in fibers[q]}
        for y in fibers[q]:
            assert (depths[y] == 0) == (y == q)
            vertices_checked += 1
        edges = tree_edges(R, fibers[q], q)
        for y, z in edges:
            assert depths[y] >= 1
            assert depths[z] == depths[y] - 1
            edges_checked += 1
        # 有限関数グラフを各非根から辿り、深さ回で根に着き、それ以前に再訪しないことを検査する。
        for y in fibers[q]:
            seen = set()
            z = y
            for _ in range(depths[y]):
                assert z != q and z not in seen
                seen.add(z)
                z = R[z]
            assert z == q
    instances += 1

print("global maps checked: {}".format(instances))
print("vertices with depth checked: {}".format(vertices_checked))
print("edges with exact depth decrement checked: {}".format(edges_checked))
print("RESULT: PASS")
