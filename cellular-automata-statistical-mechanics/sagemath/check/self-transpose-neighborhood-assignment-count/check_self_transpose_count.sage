# 対象ラベル: claim_self_transpose_neighborhood_assignment_count
# 自己転置な近傍割り当ての個数が 2^{n(n+1)/2} であることを全数検査する。
# 本文の証明の各段を分けて検査する。
#   |{N | N^T = N}| = |{B | B ⊆ U(V)}|   （非順序対符号の全単射）
#                    = 2^{|U(V)|}          （有限集合の部分集合の個数）
#                    = 2^{n(n+1)/2}        （非順序対の個数）
# 帰属: 有限集合と自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

counts = []

for size in (0, 1, 2, 3, 4):
    cells = tuple(range(size))
    n = ZZ(size)
    U = unordered_pairs(cells)
    self_transpose = self_transpose_assignments(cells)
    pair_sets = tuple(subsets(tuple(sorted(U, key=lambda pair: tuple(sorted(pair))))))

    # 第一段: 全単射により両側の個数が一致する
    assert ZZ(len(self_transpose)) == ZZ(len(pair_sets))
    # 第二段: 有限集合の部分集合の個数
    assert ZZ(len(pair_sets)) == 2 ** ZZ(len(U))
    # 第三段: 非順序対の個数
    assert ZZ(len(U)) == (n * (n + 1)) / 2
    # 三段の合成
    assert ZZ(len(self_transpose)) == 2 ** ((n * (n + 1)) / 2)
    counts.append((size, len(self_transpose)))

print("PASS self_transpose_count counts={}".format(counts))
