"""切断依存項を巻き付き偶奇と交差対へまとめる有限検算。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

直前までに得た頂点局所量を、同じ局所配置を一辺五の内部頂点へ移した
基準値と比較する。頂点基準値からの符号差と、非共有端点対の軌道分解に
現れる座標切断横断項を合わせた切断依存項を取り出し、残る切断非依存項と
標的の巻き付き偶奇・交差対の関係を全鍵で調べる。
"""

load("sagemath/check/parity-identity-cut-contribution-topological/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
records = {}

for side in (2, 3):
    count = ZZ(0)
    patterns = set()
    for doubled, single in collect_keys(side):
        selectors = [
            selected for selected in base_edge_subsets
            if selected.issubset(single)
            and is_even_edge_subset(doubled.union(selected))
        ] if side == 2 else [frozenset()]
        selector = min(selectors, key=lambda item: tuple(sorted(item)))
        base, cut = cut_and_base_exponents(side, doubled, single)
        target = target_exponent(side, doubled, single, selector)
        assert (base + cut) % 2 == target
        eh, ev = subset_parities(side, single)
        intersection = intersection_pairing(
            side, doubled.union(selector), single)
        patterns.add((eh, ev, intersection, base, cut, target))
        count += 1
    records[side] = (count, patterns)
    print("L=%d: keys=%d patterns=%s" % (side, count, sorted(patterns)))

    values_by_topology = {}
    for eh, ev, intersection, base, cut, target in patterns:
        values_by_topology.setdefault(
            (eh, ev, intersection, target), set()).add((base, cut))
    collisions = {
        topology: values for topology, values in values_by_topology.items()
        if len(values) > 1
    }
    print("L=%d: topological classes with multiple (base,cut) values=%d"
          % (side, len(collisions)))
    assert collisions

print("PASS: 内部頂点基準による切断依存項と切断非依存項の和は標的式に一致するが、"
      "各項は同じ巻き付き偶奇・交差対の中でも変わるため、この基準では切断依存項を"
      "位相量だけへ同定できない")
