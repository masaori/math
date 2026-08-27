# 対象ラベル: claim_self_transpose_composition_closure_finitely_decidable
# 自己転置な組の合成閉性が有限決定できることを、判定手続きの各段に分けて検査する。
#   第一段: 自己転置な割り当ての有限列挙（個数は 2^{n(n+1)/2}）
#   第二段: 各順序対の二つの合成を有限表として計算（各セルで高々 n 項の合併）
#   第三段: 合成が自己転置か否かは、二つの有限表の n 個の値の比較で決まる
# あわせて、走査した舞台での「合成が自己転置になる順序対」の個数を記録する。
# 帰属: 有限集合、有限写像表、ZZ の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

profile = []

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    n = ZZ(size)

    # 第一段: 有限列挙とその個数
    selfs = self_transpose_assignments(cells)
    assert ZZ(len(neighborhood_assignments(cells))) == ZZ(2) ** (n * n)
    assert ZZ(len(selfs)) == ZZ(2) ** (n * (n + 1) / 2)

    closed_pairs = 0
    for N in selfs:
        for M in selfs:
            # 第二段: 合成表の有限計算（定義の合併をそのまま辿る）
            NM = compose(cells, N, M)
            for v in cells:
                collected = set()
                comparisons = 0
                for u in N[v]:
                    collected |= set(M[u])
                    comparisons += 1
                assert comparisons <= size
                assert NM[v] == frozenset(collected)

            # 第三段: 自己転置性の判定は n 個の値の比較
            MN = compose(cells, M, N)
            value_comparisons = 0
            equal = True
            for v in cells:
                value_comparisons += 1
                if NM[v] != MN[v]:
                    equal = False
            assert value_comparisons == size
            assert equal == (NM == MN)
            # 判定の正しさ（同値による言い換え）
            assert equal == (transpose(cells, NM) == NM)

            if equal:
                closed_pairs += 1

    total_pairs = ZZ(len(selfs)) ** 2
    profile.append((size, len(selfs), closed_pairs, int(total_pairs)))
    # 二元以上では閉じない順序対が実在する（合成閉性の反証が走査でも見える）
    if size >= 2:
        assert ZZ(closed_pairs) < total_pairs
    else:
        assert ZZ(closed_pairs) == total_pairs

print("PASS finite_decision profile={}".format(profile))
