"""単純閉路の鍵の四項を、方向列由来の統計の F_2 線型結合で書けるか調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

直線合併を含まない成分の辺数最小代表は単一の単純閉路だった
（parity-identity-minimal-standard-representatives）。そこで、E が単一の
単純閉路（全頂点の次数が 2 で辺連結成分が 1）である鍵 (D, E) の全てについて、
標準形配向での四項（動辺数・頂点項・非共有端点対項・標的指数）を計算し、
閉路の方向列から機械的に読める統計

  定数 1、|E|、水平辺数、垂直辺数、巻き付き偶奇 2 つとその積、
  角の個数の半分、行 0 の角の個数、列 0 の角の個数、|D|、選択文字対の項

の F_2 線型結合として各項が書けるかを、厳密な線型方程式で解く。
角とは、接する二辺の種類（水平・垂直）が異なる次数 2 の頂点である
（閉路の方向列で向きが変わる場所。角の総数は常に偶数なので半分を取る）。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-key-terms/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
expressible_by_side = {}

for side in (2, 3):
    keys = collect_keys(side)
    cycle_keys = [(doubled, single) for doubled, single in keys
                  if is_simple_cycle(side, single)]
    rows = []
    term_columns = [[] for _ in range(4)]
    for doubled, single in cycle_keys:
        rows.append(cycle_statistics(side, doubled, single))
        terms = key_terms(side, doubled, single)
        for index in range(4):
            term_columns[index].append(GF(2)(terms[index]))

    statistic_matrix = matrix(GF(2), rows)
    if side == 3:
        for row, terms in zip(rows, zip(*term_columns)):
            size = row[1]
            winding_product = row[6]
            assert terms[0] == size
            assert terms[1] == GF(2)(1) + size + winding_product
            assert terms[2] == GF(2)(1) + size
            assert terms[3] == size + winding_product
    expressible = []
    for index in range(4):
        term_vector = vector(GF(2), term_columns[index])
        try:
            solution = statistic_matrix.solve_right(term_vector)
            support = [STATISTIC_NAMES[position]
                       for position in range(len(STATISTIC_NAMES))
                       if solution[position] != 0]
            expressible.append((TERM_NAMES[index], support))
        except ValueError:
            expressible.append((TERM_NAMES[index], None))

    expressible_by_side[side] = expressible
    print("L=%d: keys=%d cycle-keys=%d matrix-rank=%d results=%s"
          % (side, len(keys), len(cycle_keys), statistic_matrix.rank(),
             [(name, support) for name, support in expressible]))
    assert len(cycle_keys) > 0

# 観測の固定: 一辺三（D は空）では四項の全てが統計で書け、角の統計は不要で
# 動辺数 = |E|、頂点項 = 1 + |E| + eps_h*eps_v、対項 = 1 + |E|、
# 標的指数 = |E| + eps_h*eps_v になる（上の per-key 検査）。
# 一辺二では D が動くため、動辺数（常に 0）と標的指数は書けるが、
# 頂点項と非共有端点対項は候補統計の線型結合では書けない。
assert [name for name, support in expressible_by_side[2]
        if support is not None] == ["moved", "target"]
assert all(support is not None for _, support in expressible_by_side[3])

print("PASS: 単純閉路の鍵では、一辺三で四項の全てが方向列統計の F_2 線型結合で"
      "書けるが、一辺二では頂点項と非共有端点対項が候補統計だけでは書けない")
