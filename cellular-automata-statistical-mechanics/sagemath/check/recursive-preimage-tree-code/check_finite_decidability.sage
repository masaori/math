# claim_recursive_preimage_tree_code_finite_decidability の検算。
# 二つの局所真理値表（規則番号）から、大域写像表の有限走査、各配位の μ・π の有限走査、
# 最小前周期の大きい順の有限再帰による写像符号の計算、符号の有限比較、
# 符号が等しい場合の共役全単射の構成までが有限回で完了し、その判定が
# 全単射の全数走査による独立判定と一致することを検査する。
# 対象はセル数 0・1・2 の全初等 CA 規則対（513 表の全順序対 263,169 対。元数違いの対を含む）。
# 帰属: 有限集合の写像表、全単射の有限列挙、入れ子有限多重集合の等号。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

# claim_iterate_monoid_finite_decidability の冒頭と同じく、局所真理値表から大域写像表を作る。
instances = [(stage_size, rule, table)
             for stage_size, rule, table in exhaustive_instances() if stage_size <= 2]
map_codes = {}
for stage_size, rule, table in instances:
    map_codes[(stage_size, rule)] = code_data(table)[5]

pairs = 0
equal_code_pairs = 0
for stage_f, rule_f, table_f in instances:
    for stage_g, rule_g, table_g in instances:
        pairs += 1
        codes_equal = map_codes[(stage_f, rule_f)] == map_codes[(stage_g, rule_g)]
        exists, _ = conjugacy_scan(table_f, table_g)
        # 符号の等号による判定が、全単射の全数走査による独立判定と一致する。
        assert codes_equal == exists, (stage_f, rule_f, stage_g, rule_g)
        if codes_equal:
            equal_code_pairs += 1
            # 符号が等しい場合は構成が有限回で完了し、共役全単射を与える。
            h = build_conjugacy_from_codes(table_f, table_g)
            assert frozenset(h.keys()) == frozenset(range(len(table_f)))
            assert frozenset(h.values()) == frozenset(range(len(table_g)))
            assert all(h[table_f[y]] == table_g[h[y]] for y in range(len(table_f))), \
                (stage_f, rule_f, stage_g, rule_g)

print(f"PASS tables={len(instances)} pairs={pairs} equal_code_pairs={equal_code_pairs}")
