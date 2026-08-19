# claim_recursive_preimage_tree_code_complete_invariant の検算。
# 元数 1・2・4 の配位集合上の全自己写像の同サイズ順序対（1 + 16 + 65,536 対）で、
# 写像符号の等号 𝒦(F) = 𝒦(G) と、全単射の全数走査による共役全単射の存在が
# 同値であることを検査する。元数が異なる対では、写像符号が必ず異なり
# 共役全単射も存在しないことを併せて検査する。
# 帰属: 有限集合の写像表、全単射の有限列挙、入れ子有限多重集合の等号。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

same_size_pairs = 0
conjugate_count = 0
cross_size_pairs = 0

self_maps = all_self_map_instances()
map_codes = {table: code_data(table)[5] for table in self_maps}
for table_f in self_maps:
    for table_g in self_maps:
        codes_equal = map_codes[table_f] == map_codes[table_g]
        exists, witness = conjugacy_scan(table_f, table_g)
        if len(table_f) == len(table_g):
            same_size_pairs += 1
            # 完全不変量の同値: 符号一致 ⟺ 共役全単射の存在。
            assert codes_equal == exists, (table_f, table_g)
            if exists:
                conjugate_count += 1
                # 走査の証人が実際に共役全単射であること。
                assert all(witness[table_f[y]] == table_g[witness[y]]
                           for y in range(len(table_f))), (table_f, table_g)
        else:
            cross_size_pairs += 1
            # 元数が異なれば全単射が存在せず、符号も一致しない
            # （符号一致なら claim_recursive_preimage_tree_code_completeness の
            # 全単射が構成できてしまうため）。
            assert not exists and not codes_equal, (table_f, table_g)

print(f"PASS same_size_pairs={same_size_pairs} conjugate_pairs={conjugate_count} "
      f"cross_size_pairs={cross_size_pairs}")
