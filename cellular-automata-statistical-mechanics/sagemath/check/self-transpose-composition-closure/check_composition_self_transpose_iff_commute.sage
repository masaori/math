# 対象ラベル: claim_self_transpose_composition_iff_commute
# 自己転置な N, M について (N star M)^T = N star M ⟺ N star M = M star N を全数検査する。
# 本文の証明の各段を分けて検査する。
#   第一段: (N star M)^T = M^T star N^T（転置が合成順序を反転する）
#   第二段: N^T = N, M^T = M の代入で M^T star N^T = M star N
#   第三段: 等号の対称性
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
closed_count = 0
open_count = 0

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    selfs = self_transpose_assignments(cells)
    for N in selfs:
        for M in selfs:
            pair_count += 1
            NM = compose(cells, N, M)
            MN = compose(cells, M, N)

            # 第一段: 転置が合成順序を反転する（所属ごとに確かめてから写像の等号にする）
            for v in cells:
                for w in cells:
                    assert (w in transpose(cells, NM)[v]) == (v in NM[w])
            assert transpose(cells, NM) == compose(
                cells, transpose(cells, M), transpose(cells, N)
            )

            # 第二段: 自己転置性の代入
            assert transpose(cells, N) == N
            assert transpose(cells, M) == M
            assert compose(cells, transpose(cells, M), transpose(cells, N)) == MN

            # 両段の合成: (N star M)^T = M star N
            assert transpose(cells, NM) == MN

            # 第三段: 等号の対称性を経た同値
            assert (transpose(cells, NM) == NM) == (MN == NM)
            assert (transpose(cells, NM) == NM) == (NM == MN)

            if NM == MN:
                closed_count += 1
            else:
                open_count += 1

print("PASS composition_self_transpose_iff_commute pairs={} commuting={} noncommuting={}".format(
    pair_count, closed_count, open_count
))
