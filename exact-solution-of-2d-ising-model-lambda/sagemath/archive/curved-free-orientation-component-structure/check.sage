"""曲がり型なし均衡配向の成分ごとの構造を一辺二・一辺三の全偶部分グラフで検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一般の辺長で、配向差と局所選択ビットから巡回空間の基底係数を列挙に
頼らず取り出す規則へ向けた検査である。トーラスの偶部分グラフ E の
曲がり型なし均衡配向（次数 4 の頂点の入辺二本の軸が常に一致する
均衡配向）について、次を固定する。

  - 各連結成分の曲がり型なし均衡配向は 0 個か 2 個であり、2 個の
    ときは互いの全反転である。従って E 全体の曲がり型なし均衡配向の
    個数は 0 か 2^{c(E)}（c(E) は非空連結成分数）で、二つの配向の
    不一致辺集合は常にいくつかの成分の辺集合の合併になる。
  - 次数勘定の等式 |E| - |V(E)| = n4(E)（n4 は次数 4 の頂点数）。
    従って巡回空間の階数 |E| - |V(E)| + c(E) は c(E) + n4(E) に
    分解し、成分の指示元 c(E) 本は巡回空間の一次独立な元である。
  - 曲がり型なし配向の直進型頂点数 s(o) は常に n4(E) に等しい。

これにより配向側の座標は「成分ごとの反転ビット」＝成分の指示元への
展開として列挙に頼らず取れる。残るのは直進型頂点の選択ビットから
巡回空間の残り n4 次元の係数を取り出す規則である。有限集合、F_2、
整数の厳密演算だけを使い、浮動小数点は使わない。
"""


def build_torus(side):
    """辺は (i, j, d)。d=0 は (i,j)→(i,j+1)、d=1 は (i,j)→(i+1,j)。"""
    edge_list = []
    for i in range(side):
        for j in range(side):
            edge_list.append((i, j, 0))
            edge_list.append((i, j, 1))
    incidence = {}
    for edge in edge_list:
        i, j, d = edge
        if d == 0:
            head = (i, (j + 1) % side)
            axis = "h"
        else:
            head = ((i + 1) % side, j)
            axis = "v"
        tail = (i, j)
        incidence.setdefault(tail, []).append((edge, 0, axis))
        incidence.setdefault(head, []).append((edge, 1, axis))
    return edge_list, incidence


def even_subgraphs(edge_list, incidence):
    """全偶部分グラフを、頂点×辺の境界行列の核（巡回空間）として列挙する。"""
    vertex_order = sorted(incidence)
    boundary = matrix(GF(2), [
        [1 if any(edge == other for other, _, _ in incidence[vertex]) else 0
         for edge in edge_list]
        for vertex in vertex_order])
    result = []
    for kernel_vector in boundary.right_kernel():
        chosen = frozenset(edge for edge, coefficient
                           in zip(edge_list, kernel_vector) if coefficient == 1)
        # 核の元が本当に各頂点で偶数次数であることを直接確かめる。
        assert all(ZZ(sum(1 for edge, _, _ in slots if edge in chosen)) % 2 == 0
                   for slots in incidence.values())
        result.append(chosen)
    return result


def edge_components(chosen, incidence):
    """非空連結成分（辺集合の分割）を返す。"""
    remaining = set(chosen)
    components = []
    while remaining:
        seed = min(remaining)
        stack = [seed]
        component = set()
        while stack:
            edge = stack.pop()
            if edge not in component:
                component.add(edge)
                i, j, d = edge
                if d == 0:
                    ends = [(i, j), (i, (j + 1) % L_side)]
                else:
                    ends = [(i, j), ((i + 1) % L_side, j)]
                for vertex in ends:
                    for other, _, _ in incidence[vertex]:
                        if other in remaining and other not in component:
                            stack.append(other)
        remaining -= component
        components.append(frozenset(component))
    return components


def curved_free_orientations(component, incidence):
    """成分の曲がり型なし均衡配向を総当たりで列挙する。

    配向はタプル（辞書式順の辺リストへのビット割当。0 は辺の定義の向き）。
    """
    edge_order = sorted(component)
    index_of = {edge: k for k, edge in enumerate(edge_order)}
    vertex_slots = []
    for vertex, slots in incidence.items():
        local = [(index_of[edge], end, axis) for edge, end, axis in slots
                 if edge in component]
        if local:
            assert len(local) in (2, 4)
            vertex_slots.append(local)
    found = []
    for mask in range(2 ** len(edge_order)):
        ok = True
        for local in vertex_slots:
            in_axes = []
            for index, end, axis in local:
                bit = (mask >> index) & 1
                if (end == 1) == (bit == 0):
                    in_axes.append(axis)
            if len(in_axes) * 2 != len(local):
                ok = False
                break
            if len(local) == 4 and in_axes[0] != in_axes[1]:
                ok = False
                break
        if ok:
            found.append(mask)
    return edge_order, found


def winding(chosen, side):
    """水平・垂直の切断線を横切る辺数の偶奇を返す。"""
    return (
        ZZ(sum(1 for i, j, d in chosen if d == 0 and j == side - 1)) % 2,
        ZZ(sum(1 for i, j, d in chosen if d == 1 and i == side - 1)) % 2,
    )


def selection_character_is_nontrivial(chosen, all_even, side):
    """E に含まれる偶部分グラフ上で巻き付き交代積が非零かを判定する。"""
    chosen_h, chosen_v = winding(chosen, side)
    for subgraph in all_even:
        if subgraph <= chosen:
            subgraph_h, subgraph_v = winding(subgraph, side)
            if (chosen_h * subgraph_v + chosen_v * subgraph_h) % 2 == 1:
                return True
    return False


for L_side in (2, 3):
    edge_list, incidence = build_torus(L_side)
    all_even = even_subgraphs(edge_list, incidence)
    assert ZZ(len(all_even)) == 2 ** (len(edge_list) - L_side ** 2 + 1)

    component_cache = {}
    nonzero_count = ZZ(0)
    zero_count = ZZ(0)
    nontrivial_character_count = ZZ(0)
    subgraph_checks = ZZ(0)
    for chosen in all_even:
        touched = [vertex for vertex, slots in incidence.items()
                   if any(edge in chosen for edge, _, _ in slots)]
        degree_four = [vertex for vertex in touched
                       if ZZ(sum(1 for edge, _, _ in incidence[vertex]
                                 if edge in chosen)) == 4]
        n4 = ZZ(len(degree_four))
        # 次数勘定: 2|E| = 4 n4 + 2 n2 と |V(E)| = n4 + n2 から |E|-|V(E)| = n4。
        assert ZZ(len(chosen)) - ZZ(len(touched)) == n4

        components = edge_components(chosen, incidence)
        c_count = ZZ(len(components))
        rank = ZZ(len(chosen)) - ZZ(len(touched)) + c_count
        assert rank == c_count + n4

        all_pairs = True
        for component in components:
            if component not in component_cache:
                edge_order, found = curved_free_orientations(component, incidence)
                full_mask = 2 ** len(edge_order) - 1
                assert len(found) in (0, 2)
                if len(found) == 2:
                    # 二つは互いの全反転（不一致辺集合が成分全体）。
                    assert found[0] ^^ found[1] == full_mask
                component_cache[component] = len(found)
            if component_cache[component] == 0:
                all_pairs = False

        if chosen and all_pairs:
            # 曲がり型なし配向の総数は成分ごとの独立な 2 択の積 2^{c}。
            # 直進型頂点数はどの曲がり型なし配向でも n4（曲がり型なしの定義）。
            nonzero_count += 1
            # 成分の指示元 c 本は巡回空間の一次独立な元（台が非空で互いに素）。
            indicator_rows = matrix(GF(2), [
                [1 if edge in component else 0 for edge in edge_list]
                for component in components])
            assert indicator_rows.rank() == c_count
        elif chosen:
            zero_count += 1
        if chosen and selection_character_is_nontrivial(chosen, all_even, L_side):
            nontrivial_character_count += 1
            # 「非自明文字なら曲がり型なし配向なし」の逆も、この有限範囲では直接照合する。
            assert not all_pairs
        elif chosen:
            assert all_pairs
        subgraph_checks += 1

    if L_side == 2:
        assert nonzero_count == 23 and zero_count == 8
        assert nontrivial_character_count == 8
    else:
        # 一辺三では個数だけでなく、各 E ごとに両条件が同値である。
        assert nonzero_count == 677 and zero_count == 346
        assert nontrivial_character_count == 346
    print("PASS: L=%d の偶部分グラフ %d 個で、曲がり型なし均衡配向が成分ごとに"
          " 0 個または全反転の 2 個であること、|E|-|V(E)|=n4、階数 = c + n4、"
          "成分指示元の一次独立を検査（曲がり型なし配向を持つ非空 E は %d 個、"
          "持たない非空 E は %d 個）" %
          (L_side, subgraph_checks, nonzero_count, zero_count))
