# claim_recursive_preimage_tree_code_completeness の検算。
# 証明の再帰構成（写像符号の等号による周期軌道の重複度つき対応、等しい基点語による
# 周期辺の接着、等しい子符号の多重集合からの前像木全単射の葉側までの再帰構成）を
# そのまま実装し、写像符号が等しい対で、得られた h が各点にちょうど一度定義された
# 全単射で h ∘ F = G ∘ h を満たすことを検査する。
# 対象は、共役対の全数族 3,073 対（|V| <= 3。写像符号の等号は不変性の章で成立済み）と、
# 元数 1・2・4 の全自己写像の同サイズ対のうち写像符号が等しい全対。
# 帰属: 有限集合の写像表、有限集合の等号・所属、有限列・入れ子有限多重集合の等号。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))


def verify_construction(table_f, table_g, context):
    h = build_conjugacy_from_codes(table_f, table_g)
    # h は全域に一度ずつ定義され、値が相異なる（全単射）。
    assert len(h) == len(table_f) == len(table_g), context
    assert frozenset(h.keys()) == frozenset(range(len(table_f))), context
    assert frozenset(h.values()) == frozenset(range(len(table_g))), context
    # 共役条件 h(F(z)) = G(h(z))（def_iterate_monoid_conjugacy_bijection）。
    for z in range(len(table_f)):
        assert h[table_f[z]] == table_g[h[z]], (context, z)


conjugate_pairs = 0
for stage_size, rule, table_f, h0, table_g in conjugate_instances():
    verify_construction(table_f, table_g, (stage_size, rule, h0))
    conjugate_pairs += 1

equal_code_pairs = 0
self_maps = all_self_map_instances()
map_codes = {table: code_data(table)[5] for table in self_maps}
for table_f in self_maps:
    for table_g in self_maps:
        if len(table_f) == len(table_g) and map_codes[table_f] == map_codes[table_g]:
            verify_construction(table_f, table_g, (table_f, table_g))
            equal_code_pairs += 1

print(f"PASS conjugate_pairs={conjugate_pairs} equal_code_pairs={equal_code_pairs}")
