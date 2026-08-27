# 対象ラベル: claim_all_self_transpose_assignments_composition_closed_iff_subsingleton
# 特徴づけそのものを有限決定として検査する。舞台元数ごとに
#   (1) 自己転置な割り当ての全列挙（2^{|V|^2} の走査）と、対称な所属関係からの構成が一致すること
#   (2) その順序対を全て走って Closed_st(V) を判定すること
#   (3) 判定結果が |V| <= 1 と一致すること
# を分けて検査する。合成表の計算は各セルで高々 |V| 項の合併、自己転置性の判定は |V| 個の値の比較。
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

rows = []
for n in range(0, 5):
    cells = tuple(range(n))
    by_symmetry = self_transpose_assignments_by_symmetry(cells)
    # (1) 二通りの列挙の一致（全列挙は |V| <= 4 まで走査できる）
    brute = self_transpose_assignments(cells)
    assert set(brute) == set(by_symmetry)
    assert len(by_symmetry) == 2 ** (n * (n + 1) // 2)

    # (2) 順序対の全走査による判定（|V| = 4 は順序対が 1,048,576 組になるため走査しない）
    if n >= 4:
        rows.append((n, len(by_symmetry), None, None))
        continue
    closed = True
    commuting_pairs = 0
    for N in by_symmetry:
        for M in by_symmetry:
            NM = compose(cells, N, M)
            MN = compose(cells, M, N)
            is_self_transpose = transpose(cells, NM) == NM
            # 同値: 合成が自己転置 ⟺ 可換
            assert is_self_transpose == (NM == MN)
            if is_self_transpose:
                commuting_pairs += 1
            else:
                closed = False
    assert closed == closed_st(cells)

    # (3) 特徴づけとの一致
    assert closed == (n <= 1)
    rows.append((n, len(by_symmetry), commuting_pairs, closed))

for n, count, commuting, closed in rows:
    print("  |V|={} self_transpose={} commuting_pairs={} closed={}".format(
        n, count, commuting, closed
    ))
print("PASS characterization_finite_decision stages={}".format(len(rows)))
