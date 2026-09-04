"""動辺集合で制限した非共有端点対の和を軌道項と切断横断項へ分解する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

非共有端点を持つ有向辺対を同時に平行移動した軌道ごとにまとめる。
各軌道では辞書式最小の辺対を代表に取る。代表を (u,v) だけ平行移動した
とき、終点順序の反転指示値が変わるかどうかは、終点二つの辞書式順序が
座標の mod L 切断を横切って反転するかだけで決まる。始点についても同じ
である。従って、動辺集合に実際に含まれる対だけに制限した和は

  代表の寄与 × 動辺対の個数
  + 終点二つの切断横断数
  + 始点二つの切断横断数                         (mod 2)

へ分かれる。本検算はこの等式を軌道ごと、および全軌道の和について確かめる。
有限集合と F_2 の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-active-pair-orbit-cut-decomposition/construction.sage")

for side in (2, 3):
    total_keys = ZZ(0)
    total_orbits = ZZ(0)
    total_corrected = ZZ(0)
    total_pairs = ZZ(0)
    if side == 2:
        keys = []
        for doubled, single in sorted(all_fibers):
            selectors = [
                selected for selected in base_edge_subsets
                if selected.issubset(single)
                and is_even_edge_subset(doubled.union(selected))
            ]
            if selectors and character_is_trivial_general(side, single):
                keys.append((doubled, single))
    else:
        keys = [
            (frozenset(), single)
            for single in sorted(
                even_subgraphs_three, key=lambda item: tuple(sorted(item)))
            if single
            and character_is_trivial_general(side, single)
            and curved_free_orientations(side, single)
        ]
    for doubled, single in keys:
        orientations = curved_free_orientations(side, single)
        standard, _ = standard_orientation(side, single, orientations)
        orbit_count, corrected_count, pair_count = \
            active_nonincident_orbit_decomposition(
                side, active_edges(doubled, single, standard))
        total_keys += 1
        total_orbits += orbit_count
        total_corrected += corrected_count
        total_pairs += pair_count
    checks[side] = (total_keys, total_orbits, total_corrected, total_pairs)
    print("L=%d: keys=%d active-orbits=%d cut-corrected=%d active-pairs=%d"
          % ((side,) + checks[side]))
    assert total_keys > 0 and total_pairs > 0

print("PASS: 動辺集合で制限した非共有端点対の和を、軌道代表の寄与と"
      "終点・始点の座標切断横断数へ分解")
