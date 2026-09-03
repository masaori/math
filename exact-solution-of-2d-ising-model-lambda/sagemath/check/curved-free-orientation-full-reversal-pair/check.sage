"""各成分の曲がり型なし均衡配向が全反転対になる一般証明の核を検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一般の辺長 L のトーラス正方格子の偶部分グラフ E（各頂点の次数は 2 か 4）の
任意の連結成分 K について、曲がり型なし均衡配向の集合が空であるか、
ある配向とその全反転のちょうど 2 元集合であることの証明は、次の三つの核から
成る。この検算はそれぞれを有限の厳密演算で固定する。

  - 局所決定性（辺長非依存・記号的）: 頂点 v に接続する K の辺 e の向き
    （v へ入るか v から出るか）を一つ与えると、v での曲がり型なし均衡な
    局所状態は一意に決まる。次数 2 では入 1 出 1 の均衡から、次数 4 では
    「入辺二本が同軸」という条件から一意である（e が出のとき、入辺二本の
    軸が e の軸だとすると e 自身が入辺になり矛盾するので、入辺は他軸の
    二本に限る）。
  - 全反転の保存（辺長非依存・記号的）: 局所状態の全反転（入と出の交換）は
    再び曲がり型なし均衡な局所状態であり、次数 4 の二つの局所状態を互いに
    入れ替える。従って配向の全反転は曲がり型なし均衡性を保ち、辺が一本でも
    あれば元の配向と異なる。
  - 辺連結伝播（帰納法の検証）: K は辺連結なので、固定した最小辺の向き
    2 通りそれぞれから局所決定性で全辺の向きが一意に伝播する。伝播が
    整合すれば配向が 1 つ得られ、しなければその向きの配向は無い。従って
    高々 2 個であり、非空なら全反転の対でちょうど 2 個である。一辺二・
    一辺三の全偶部分グラフの全成分で、伝播の結果が総当たり列挙と集合として
    一致することを検査する。

有限集合、F_2、整数の厳密演算だけを使い、浮動小数点は使わない。
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
        assert all(ZZ(sum(1 for edge, _, _ in slots if edge in chosen)) % 2 == 0
                   for slots in incidence.values())
        result.append(chosen)
    return result


def edge_components(chosen, incidence, side):
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
                    ends = [(i, j), (i, (j + 1) % side)]
                else:
                    ends = [(i, j), ((i + 1) % side, j)]
                for vertex in ends:
                    for other, _, _ in incidence[vertex]:
                        if other in remaining and other not in component:
                            stack.append(other)
        remaining -= component
        components.append(frozenset(component))
    return components


# ---------------------------------------------------------------------------
# 核その一: 局所決定性（記号的列挙。辺長に依存しない）。
#
# 局所状態は、頂点に接続する各辺スロット（軸付き）への in/out の割当で、
# 均衡（in の数 = out の数）かつ次数 4 では in 二本の軸が一致するもの。
# 検査: どのスロットのどの向きを固定しても、それを含む局所状態はちょうど一つ。
# ---------------------------------------------------------------------------

def local_states(axes):
    """軸列 axes のスロットへの曲がり型なし均衡な局所状態を列挙する。"""
    count = len(axes)
    states = []
    for mask in range(2 ** count):
        ins = [k for k in range(count) if (mask >> k) & 1]
        if 2 * len(ins) != count:
            continue
        if count == 4 and axes[ins[0]] != axes[ins[1]]:
            continue
        states.append(mask)
    return states


# 次数 2: 偶部分グラフの次数 2 頂点の二辺の軸は (h,h)・(h,v)・(v,v) のどれも
# ありうるので全て見る。次数 4: トーラスの頂点の四辺は常に水平二本・垂直二本。
degree_two_axes = [("h", "h"), ("h", "v"), ("v", "v")]
degree_four_axes = [("h", "h", "v", "v")]
local_checks = ZZ(0)
for axes in degree_two_axes + degree_four_axes:
    states = local_states(axes)
    assert len(states) == 2
    # 全反転（マスクの補集合）は二つの局所状態を互いに入れ替える。
    full = 2 ** len(axes) - 1
    assert states[0] ^^ full == states[1]
    for slot in range(len(axes)):
        for bit in (0, 1):
            matching = [s for s in states if ((s >> slot) & 1) == bit]
            # 一つのスロットの向きを固定すると局所状態は一意に決まる。
            assert len(matching) == 1
            local_checks += 1
print("PASS: 局所決定性と全反転の保存を記号的に検査"
      "（軸列 %d 種、スロット×向きの固定 %d 件で局所状態が常に一意）" %
      (len(degree_two_axes) + len(degree_four_axes), local_checks))


# ---------------------------------------------------------------------------
# 核その二: 辺連結伝播と総当たりの一致（一辺二・一辺三の全成分）。
# ---------------------------------------------------------------------------

def brute_force_orientations(component, incidence):
    """成分の曲がり型なし均衡配向を総当たりで列挙する。"""
    edge_order = sorted(component)
    index_of = {edge: k for k, edge in enumerate(edge_order)}
    vertex_slots = []
    for vertex, slots in incidence.items():
        local = [(index_of[edge], end, axis) for edge, end, axis in slots
                 if edge in component]
        if local:
            assert len(local) in (2, 4)
            if len(local) == 4:
                # トーラスの次数 4 頂点は常に水平二本・垂直二本。
                assert sorted(axis for _, _, axis in local) == ["h", "h", "v", "v"]
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


def propagate_orientations(component, incidence):
    """最小辺の向き 2 通りから局所決定性で伝播し、得た配向の集合を返す。

    ビット 0 は辺の定義の向き。頂点 v でスロット (edge, end) の in/out は
    end==1（v が head）と bit==0 の一致が in。
    """
    edge_order = sorted(component)
    index_of = {edge: k for k, edge in enumerate(edge_order)}
    vertex_slots = {}
    for vertex, slots in incidence.items():
        local = [(edge, end, axis) for edge, end, axis in slots
                 if edge in component]
        if local:
            vertex_slots[vertex] = local
    ends_of = {}
    for vertex, local in vertex_slots.items():
        for edge, end, axis in local:
            ends_of.setdefault(edge, []).append(vertex)
    found = []
    seed = edge_order[0]
    for seed_bit in (0, 1):
        assigned = {seed: seed_bit}
        stack = [seed]
        consistent = True
        while stack and consistent:
            edge = stack.pop()
            for vertex in ends_of[edge]:
                local = vertex_slots[vertex]
                axes = tuple(axis for _, _, axis in local)
                states = local_states(axes)
                # 既に向きの付いた辺と整合する局所状態だけを残す。
                surviving = []
                for state in states:
                    ok = True
                    for slot, (other, end, axis) in enumerate(local):
                        if other in assigned:
                            is_in = (end == 1) == (assigned[other] == 0)
                            if ((state >> slot) & 1) != (1 if is_in else 0):
                                ok = False
                                break
                    if ok:
                        surviving.append(state)
                if not surviving:
                    consistent = False
                    break
                # 局所決定性: 一本でも向きが付いていれば局所状態は一意。
                assert len(surviving) == 1
                state = surviving[0]
                for slot, (other, end, axis) in enumerate(local):
                    is_in = ((state >> slot) & 1) == 1
                    bit = 0 if ((end == 1) == is_in) else 1
                    if other not in assigned:
                        assigned[other] = bit
                        stack.append(other)
                    else:
                        assert assigned[other] == bit
        if consistent:
            # 伝播は成分の全辺に向きを与える（辺連結性）。
            assert len(assigned) == len(edge_order)
            mask = sum((assigned[edge] & 1) << index_of[edge]
                       for edge in edge_order)
            found.append(mask)
    return edge_order, sorted(found)


for L_side in (2, 3):
    edge_list, incidence = build_torus(L_side)
    all_even = even_subgraphs(edge_list, incidence)
    assert ZZ(len(all_even)) == 2 ** (len(edge_list) - L_side ** 2 + 1)

    component_results = {}
    pair_components = ZZ(0)
    empty_components = ZZ(0)
    for chosen in all_even:
        for component in edge_components(chosen, incidence, L_side):
            if component in component_results:
                continue
            edge_order, brute = brute_force_orientations(component, incidence)
            edge_order2, propagated = propagate_orientations(component, incidence)
            assert edge_order == edge_order2
            # 伝播と総当たりが集合として一致する。
            assert sorted(brute) == propagated
            assert len(brute) in (0, 2)
            if len(brute) == 2:
                full_mask = 2 ** len(edge_order) - 1
                # 二つは互いの全反転（不一致辺集合が成分全体）。
                assert brute[0] ^^ full_mask == brute[1]
                pair_components += 1
            else:
                empty_components += 1
            component_results[component] = len(brute)
    print("PASS: L=%d の全偶部分グラフの相異なる成分 %d 個で、最小辺からの"
          "伝播が総当たり列挙と一致し、曲がり型なし均衡配向は 0 個か全反転対の"
          " 2 個（対 %d 成分、空 %d 成分）" %
          (L_side, len(component_results), pair_components, empty_components))
