# 対象ラベル: theorem_minimal_carrier_size_for_composition_intersection_nondistributivity
# 舞台元数 |V| = 0, 1, 2 の全ての近傍割り当ての三つ組を走査し、
# 左右それぞれの非分配反例が現れる最小の舞台元数がどちらも 2 であることを検査する。
# 反例の非存在（|V| <= 1）と存在（|V| = 2）を別々に数え、最小元数を集合の最小として取る。
# 帰属: 有限集合、有限写像、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

left_counterexample_counts = {}
right_counterexample_counts = {}
triple_counts = {}

for size in (0, 1, 2):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)
    left_count = 0
    right_count = 0
    triple_count = 0
    for N in assignments:
        for M in assignments:
            meet = pointwise_intersection(cells, N, M)
            for L in assignments:
                triple_count += 1
                if compose(cells, meet, L) != pointwise_intersection(
                    cells, compose(cells, N, L), compose(cells, M, L)
                ):
                    left_count += 1
                if compose(cells, L, meet) != pointwise_intersection(
                    cells, compose(cells, L, N), compose(cells, L, M)
                ):
                    right_count += 1
    left_counterexample_counts[size] = left_count
    right_counterexample_counts[size] = right_count
    triple_counts[size] = triple_count

# |V| <= 1 では反例が無い
assert left_counterexample_counts[0] == 0 and left_counterexample_counts[1] == 0
assert right_counterexample_counts[0] == 0 and right_counterexample_counts[1] == 0

# |V| = 2 では左右とも反例がある
assert left_counterexample_counts[2] > 0
assert right_counterexample_counts[2] > 0

# 最小舞台元数は自然数の集合 {n : 反例あり} の最小元
left_minimum = min(n for n in (0, 1, 2) if left_counterexample_counts[n] > 0)
right_minimum = min(n for n in (0, 1, 2) if right_counterexample_counts[n] > 0)
assert left_minimum == 2 and right_minimum == 2

# 走査した三つ組数が |N(V)|^3 に一致することを確かめる（走査漏れの検出）
assert triple_counts[0] == 1 and triple_counts[1] == 8 and triple_counts[2] == 4096

print("PASS minimal_cell_count left_counts={} right_counts={} triples={} minimum=({}, {})".format(
    left_counterexample_counts, right_counterexample_counts, triple_counts,
    left_minimum, right_minimum
))
