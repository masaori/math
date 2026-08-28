# 対象ラベル: claim_reflexive_transitive_closure_transitive
# 合成冪の加法則・包含と、閉包の反射性・包含・推移性・冪等性を分けて検査する。
# 帰属: 有限集合と有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        for i in range(n * n + 3):
            assert included(power(cells, assignment, i), result)
            for j in range(n * n + 3):
                assert compose(power(cells, assignment, i), power(cells, assignment, j)) == power(cells, assignment, i + j)
        assert is_reflexive(cells, result)
        assert included(assignment, result)
        assert is_transitive(cells, result)
        assert compose(result, result) == result
        checked += 1

print("PASS check_power_and_closure_properties")
print("  assignments checked:", checked)
