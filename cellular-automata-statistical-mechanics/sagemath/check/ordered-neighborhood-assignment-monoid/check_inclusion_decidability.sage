# 対象ラベル: claim_neighborhood_assignment_pointwise_inclusion_finite_decidable
# V x V の全ての組 (v, w) を走査して「w ∈ N(v) ならば w ∈ M(v)」を検査する手続きが、
# 定義どおりの N <= M と同値であること、および走査回数が |V|^2 であることを検査する。
# 帰属: 有限集合、有限写像、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))


def scan_decide(cells, lower, upper):
    """本文の証明が指定する有限走査。走査した組の個数も返す。"""
    scanned = 0
    verdict = True
    for v in cells:
        for w in cells:
            scanned += 1
            if w in lower[v] and w not in upper[v]:
                verdict = False
    return verdict, scanned


checked_pairs = 0
positive_pairs = 0
for cell_count in range(0, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    for lower in assignments:
        for upper in assignments:
            verdict, scanned = scan_decide(cells, lower, upper)
            # 走査による判定は定義による判定と一致する
            assert verdict == precedes(cells, lower, upper)
            # 走査回数は |V|^2
            assert scanned == cell_count ** 2
            checked_pairs += 1
            if verdict:
                positive_pairs += 1

print("PASS decided_pairs={} positive_pairs={}".format(checked_pairs, positive_pairs))
