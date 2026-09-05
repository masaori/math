"""置換ファイバー位相和と偶部分グラフ選択和を添字ごとに厳密比較する。

対象: def_fiber_phase_weight, def_signed_selection_sum。

一辺 L=2 の全非後退置換を反転対 D と単純通過辺 E のファイバーに分ける。
各ファイバーと四つのスピン構造について、K_L^{a,b}(D,E) を Q(zeta_8) で、
U_L^{a,b}(D,E) を ZZ で定義から計算し、両者が一致することを検査する。
浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-fiber-signed-selection-equality/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
comparisons = 0

for (doubled, single), fiber in all_fibers.items():
    assert not doubled.intersection(single)
    assert is_even_edge_subset(single)
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]

    for a in (0, 1):
        for b in (0, 1):
            fiber_phase_sum = sum(
                (contributions[permutation_key(phi)][(a, b)] for phi in fiber),
                K8(0),
            )
            signed_selection_sum = sum(
                (
                    signed_even_subgraph_weight(a, b, doubled.union(selected))
                    * signed_even_subgraph_weight(
                        a, b, doubled.union(single.difference(selected)))
                    for selected in selectors
                ),
                ZZ(0),
            )
            assert fiber_phase_sum == K8(signed_selection_sum)
            comparisons += 1

assert len(all_fibers) == 609
assert comparisons == 2436
print("PASS: L=%d の全 %d ファイバーと四スピン構造について "
      "K_L^{a,b}(D,E)=U_L^{a,b}(D,E) を %d 件検査"
      % (L, len(all_fibers), comparisons))
