# claim_flip_test_equivalence と claim_support_finite_decidability の検算。
# 初等セルオートマトンの局所真理値表 256 通りについて、本質的依存台を
# (1) 一点反転検査、(2) 台の外の値を動かしても像が変わらないことの直接確認
# の二通りで求め、一致することを全数で確かめる。

import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))


def support_by_definition(table):
    """定義どおりの本質的依存: 台の外の成分を任意に変えても値が変わらない最小の集合を全数探索で求める。"""
    for size in range(4):
        for slots in itertools.combinations(range(3), size):
            constant_outside = True
            for fixed in itertools.product((0, 1), repeat=size):
                values = set()
                for rest in itertools.product((0, 1), repeat=3 - size):
                    argument = [None, None, None]
                    for slot, value in zip(slots, fixed):
                        argument[slot] = value
                    rest_iter = iter(rest)
                    for slot in range(3):
                        if argument[slot] is None:
                            argument[slot] = next(rest_iter)
                    values.add(local_value(table, *argument))
                if len(values) != 1:
                    constant_outside = False
                    break
            if constant_outside:
                return tuple(NEIGHBOR_POSITIONS[slot] for slot in slots)
    raise AssertionError("台が求まらない")


support_histogram = {}
comparisons_used = 0
for rule_number in range(256):
    table = local_table(rule_number)
    by_flip = support_by_flip_test(table)
    by_definition = support_by_definition(table)
    assert by_flip == by_definition, (rule_number, by_flip, by_definition)
    support_histogram[by_flip] = support_histogram.get(by_flip, 0) + 1
    comparisons_used += 3 * 8

# 一点反転検査は各位置につき高々 2^3 回の比較で済み、claim_support_finite_decidability の
# 上界 |S| * 2^{|S|} = 3 * 8 = 24 を規則ごとに超えない。
assert flip_test_comparison_bound(3) == 24
assert comparisons_used == 256 * 24

# 台ごとの規則数は 2^{2^{|台|}} を包除した数と一致する（有限集合の数え上げのみ）。
assert sum(support_histogram.values()) == 256
assert support_histogram[()] == 2
assert support_histogram[(0,)] == 2
assert support_histogram[(-1,)] == 2
assert support_histogram[(1,)] == 2
assert support_histogram[(-1, 0)] == 10
assert support_histogram[(-1, 1)] == 10
assert support_histogram[(0, 1)] == 10
assert support_histogram[(-1, 0, 1)] == 218
assert 2 + 2 * 3 + 10 * 3 + 218 == 256

print(f"PASS rules=256 supports={sorted(support_histogram.items())} bound=24")
