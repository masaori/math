"""奇数辺長の全辺鍵で K=U=0 となり、平方恒等式の同じ項が消えることを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum,
      claim_signed_even_subgraph_square_stratified,
      claim_selection_sum_character_evaluation。

奇数辺長の全辺鍵 (D,E)=(空集合,E_L) では、対角共変な符号反転完全
マッチングにより置換側の位相和 K は零になる。選択側では E_L の二つの
巻き付き偶奇がともに 1 で、水平一周閉路 H_0 の巻き付き偶奇が (1,0)
なので文字 chi_{E_L}(H_0)=-1 となり、U も零になる。従って行列式の層別と
符号付き偶部分グラフ多項式の平方の層別で、次数 2L^2 のこの添字の項は
両側とも零で一致する。

一般の奇数辺長の論法は有限集合と整数の偶奇だけで閉じる。検査では L=3 の
全 75,776 置換を前段のマッチングで一回被覆して位相和の対消滅を確かめ、
選択集合を定義から列挙して四つのスピン構造の選択和が全て零であること、
全辺鍵の次数が 18=2L^2 であることを等号 assert で固定する。浮動小数点は使わない。
"""

load("sagemath/check/translation-full-key-stabilizer-orbit-involution/check.sage")


side = 3
full_edges = frozenset(base_edge_list(side))


def is_even_base_subset(edge_subset):
    degrees = {(row, column): ZZ(0)
               for row in range(side) for column in range(side)}
    for edge in edge_subset:
        start, end = endpoints(side, edge + (0,))
        degrees[start] += 1
        degrees[end] += 1
    return all(degree % 2 == 0 for degree in degrees.values())


def base_subset_winding(edge_subset):
    return tuple(
        sum(seam_parities(side, edge + (0,))[axis] for edge in edge_subset) % 2
        for axis in (0, 1)
    )


def even_subgraph_sign(a, b, edge_subset):
    horizontal, vertical = base_subset_winding(edge_subset)
    exponent = ((1 + a) * horizontal + (1 + b) * vertical
                + horizontal * vertical)
    return ZZ(-1) ** exponent


# 置換側: 前段で構成したマッチングの各対で四位相が反転する。
phase_sums = [K8(0), K8(0), K8(0), K8(0)]
seen = set()
for key, partner_key in matched.items():
    if key in seen:
        continue
    first_vector = phase_vector(side, side3_by_key[key])
    second_vector = phase_vector(side, side3_by_key[partner_key])
    assert second_vector == tuple(-value for value in first_vector)
    phase_sums = [phase_sums[index] + first_vector[index] + second_vector[index]
                  for index in range(4)]
    seen.add(key)
    seen.add(partner_key)
assert len(seen) == 75776
assert tuple(phase_sums) == (K8(0), K8(0), K8(0), K8(0))

# 選択側: 水平一周閉路が全辺集合の文字を反転する証人である。
horizontal_cycle = frozenset(("h", 0, column) for column in range(side))
assert is_even_base_subset(full_edges)
assert is_even_base_subset(horizontal_cycle)
assert base_subset_winding(full_edges) == (ZZ(1), ZZ(1))
assert base_subset_winding(horizontal_cycle) == (ZZ(1), ZZ(0))
full_h, full_v = base_subset_winding(full_edges)
cycle_h, cycle_v = base_subset_winding(horizontal_cycle)
assert ZZ(-1) ** (full_h * cycle_v + full_v * cycle_h) == -1

selectors = [frozenset(edge_subset) for edge_subset in Subsets(set(full_edges))
             if is_even_base_subset(edge_subset)]
assert len(selectors) == 1024
selection_sums = []
for a in (0, 1):
    for b in (0, 1):
        value = sum((even_subgraph_sign(a, b, selected)
                     * even_subgraph_sign(a, b, full_edges - selected)
                     for selected in selectors), ZZ(0))
        selection_sums.append(value)
assert tuple(selection_sums) == (ZZ(0), ZZ(0), ZZ(0), ZZ(0))

# 二つの層別でこの添字が持つ次数は同じ 2|D|+|E|=2L^2 で、係数は双方零。
degree = 2 * len(frozenset()) + len(full_edges)
assert degree == 2 * side * side == 18
assert tuple(K8(value) for value in selection_sums) == tuple(phase_sums)

print("PASS: L=3 の全辺鍵で K=U=0、次数 18 の層別項が両側で消滅")
