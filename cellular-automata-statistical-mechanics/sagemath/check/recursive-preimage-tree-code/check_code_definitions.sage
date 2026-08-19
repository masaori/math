# claim_recursive_preimage_tree_code_child_preperiod_increment /
# claim_recursive_preimage_tree_code_preperiod_upper_bound /
# def_recursive_preimage_tree_code の検算。
# 非周期一段前像の最小前周期の増分 μ(z) = μ(y) + 1、上界 μ(y) <= 2^{|V|} - 1、
# 再帰符号の well-defined 性（μ の大きい側からの帰納法で全配位に定義され、
# μ(y) = 2^{|V|} - 1 - j のとき c_F(y) ∈ M_j）を、全数対象で定義から検査する。
# 帰属: 有限集合の写像表、有限集合の等号・所属、非負整数の加減・大小比較。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

tables = 0
increment_checks = 0
bound_checks = 0
membership_checks = 0

for stage_size, rule, table in exhaustive_instances():
    tables += 1
    mp, periodic, children, codes, orbits, map_code = code_data(table)
    top = len(table) - 1  # 2^{|V|} - 1
    for y in range(len(table)):
        # claim_recursive_preimage_tree_code_preperiod_upper_bound: μ(y) <= 2^{|V|} - 1。
        assert mp[y][0] <= top, (stage_size, rule, y)
        bound_checks += 1
        for z in children[y]:
            # def_recursive_preimage_tree_code_children の定義確認。
            assert table[z] == y and z not in periodic, (stage_size, rule, y, z)
            # claim_recursive_preimage_tree_code_child_preperiod_increment: μ(z) = μ(y) + 1。
            assert mp[z][0] == mp[y][0] + 1, (stage_size, rule, y, z)
            increment_checks += 1
        # def_recursive_preimage_tree_code: c_F(y) が定義され、多重集合として
        # 子の符号を重複を保って集めた整列表現に一致し、c_F(y) ∈ M_{2^{|V|}-1-μ(y)}。
        assert codes[y] == tuple(sorted(codes[z] for z in children[y])), (stage_size, rule, y)
        assert hierarchy_member(codes[y], top - mp[y][0]), (stage_size, rule, y)
        membership_checks += 1

print(f"PASS tables={tables} bound_checks={bound_checks} "
      f"increment_checks={increment_checks} membership_checks={membership_checks}")
