# claim_recursive_preimage_tree_code_conjugacy_invariance の検算。
# 共役対の全数族（セル数 0 の唯一の大域写像と 1 <= |V| <= 3 の全初等 CA 規則に
# 決定的な全単射 5 種を当てた対）で、証明の中間段（周期点集合の移送、非周期一段前像の移送、
# 点ごとの符号の保存 c_F(y) = c_G(h(y))、基点語・成分符号の保存）と
# 結論 𝒦(F) = 𝒦(G) を定義からの再計算で検査する。
# 帰属: 有限集合の写像表、有限集合の等号・所属・像、入れ子有限多重集合の等号。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
pointwise_checks = 0
orbit_checks = 0

for stage_size, rule, table_f, h, table_g in conjugate_instances():
    pairs += 1
    mp_f, per_f, children_f, codes_f, orbits_f, map_code_f = code_data(table_f)
    mp_g, per_g, children_g, codes_g, orbits_g, map_code_g = code_data(table_g)
    # 周期点集合の移送 h(Per(F)) = Per(G)。
    assert frozenset(h[y] for y in per_f) == per_g, (stage_size, rule, h)
    for y in range(len(table_f)):
        # 非周期一段前像の移送 h(C_F(y)) = C_G(h(y))。
        assert frozenset(h[z] for z in children_f[y]) == frozenset(children_g[h[y]]), \
            (stage_size, rule, h, y)
        # 点ごとの符号の保存 c_F(y) = c_G(h(y))。
        assert codes_f[y] == codes_g[h[y]], (stage_size, rule, h, y)
        pointwise_checks += 1
    # 周期軌道の移送と基点語・成分符号の保存。
    transported = frozenset(frozenset(h[y] for y in orbit) for orbit in orbits_f)
    assert transported == orbits_g, (stage_size, rule, h)
    for orbit_points in orbits_f:
        image = frozenset(h[y] for y in orbit_points)
        for q in orbit_points:
            assert base_word(table_f, mp_f, codes_f, q) == base_word(table_g, mp_g, codes_g, h[q]), \
                (stage_size, rule, h, q)
        assert component_code(table_f, mp_f, codes_f, orbit_points) == \
            component_code(table_g, mp_g, codes_g, image), (stage_size, rule, h)
        orbit_checks += 1
    # 結論 𝒦(F) = 𝒦(G)。
    assert map_code_f == map_code_g, (stage_size, rule, h)

print(f"PASS pairs={pairs} pointwise_checks={pointwise_checks} orbit_checks={orbit_checks}")
