# claim_self_neighborhood_reversible_maps_finite_commutative_group の検算。
# 1 <= |V| <= 5 で、可逆大域写像全体が合成について閉じ、結合的、可換であり、
# 単位元が F_空集合 = 恒等写像、各元が自分自身の逆元、元数が 2^|V| であることを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked = 0
for cell_count in range(1, 6):
    size = 2 ** cell_count
    flip_sets = subsets(cell_count)
    group = tuple(flip_table(cell_count, flip_set) for flip_set in flip_sets)
    group_set = set(group)
    assert len(group_set) == 2 ** cell_count
    unit = flip_table(cell_count, frozenset())
    assert unit == identity_table(size)
    for left in group:
        assert compose(left, unit) == left and compose(unit, left) == left
        assert compose(left, left) == unit          # 各元が自分自身の逆元
        for right in group:
            product = compose(left, right)
            assert product in group_set             # 閉性
            assert product == compose(right, left)  # 可換性
            for third in group:
                assert compose(compose(left, right), third) == compose(left, compose(right, third))
            checked += 1

print(f"PASS pairs={checked}")
