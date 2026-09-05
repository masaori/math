"""共有端点対の寄与と頂点局所位相を合わせた頂点量の局所性を調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

標準形配向の動辺集合について、端点を共有する動辺対の反転指示値を
共有頂点（二つ共有するときは辞書式最小の共有頂点）へ割り付け、
その頂点の局所行列式と合わせた頂点量

  w(v) = (局所行列式 det_v) × (-1)^{v へ割り付けた共有端点対の寄与和}

を定義する。頂点の局所配置（四つの辺スロットの動辺の出入り）と
四つの切断隣接旗（上下左右の隣接座標が mod L で巻き戻るか）の組を
署名とし、w(v) が署名だけで決まるか（鍵にも位置にも依らないか）を
全数で調べる。切断隣接旗を落とした局所配置だけの分類で混在する
署名の個数も数え、切断隣接が必要かどうかを固定する。

併せて、頂点量の積と非共有端点対の和から従来の符号指数が再構成される
ことを各鍵で検算する。有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを
使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-incident-pair-vertex-locality/construction.sage")

for side in (2, 3):
    classes = {}
    unflagged = {}
    vertex_total = ZZ(0)
    key_total = ZZ(0)
    for doubled, single in collect_keys(side):
        orientations = curved_free_orientations(side, single)
        standard, _ = standard_orientation(side, single, orientations)
        moved = active_edges(doubled, single, standard)
        assigned, disjoint_sum = incident_pair_assignment(side, moved)
        vertices = sorted({vertex for edge in moved
                           for vertex in endpoints(side, edge)})
        product_value = K8(1)
        incident_total = ZZ(0)
        for vertex in vertices:
            determinant = vertex_local_determinant(side, moved, vertex)
            incident = assigned.get(vertex, ZZ(0))
            weighted = determinant * K8(ZZ(-1) ** incident)
            signature = vertex_slot_states(side, vertex, moved)
            flags = vertex_wrap_flags(side, vertex)
            classes.setdefault((signature, flags), set()).add(weighted)
            unflagged.setdefault(signature, set()).add(weighted)
            product_value *= weighted
            incident_total += incident
            vertex_total += 1

        n_four = degree_four_count(side, single) if single else ZZ(0)
        normalized = (product_value * K8(ZZ(-1) ** disjoint_sum)
                      / K8(ZZ(2) ** n_four))
        assert normalized in (K8(1), K8(-1))
        reconstructed = (ZZ(len(moved)) + ZZ(normalized == K8(-1))) % 2
        assert reconstructed == untwisted_sign_exponent(
            side, doubled, single, standard)
        key_total += 1

    mixed_flagged = sorted(
        key for key, values in classes.items() if len(values) > 1)
    mixed_unflagged = sorted(
        key for key, values in unflagged.items() if len(values) > 1)
    print("L=%d: keys=%d vertices=%d flagged-classes=%d mixed=%d "
          "unflagged-classes=%d unflagged-mixed=%d"
          % (side, key_total, vertex_total, len(classes),
             len(mixed_flagged), len(unflagged), len(mixed_unflagged)))
    assert key_total > 0
    assert not mixed_flagged
    assert mixed_unflagged

print("PASS: 共有端点対の寄与と頂点局所行列式を合わせた頂点量は、"
      "局所配置と切断隣接旗の署名だけで決まり（混在零）、"
      "切断隣接旗を落とすと決まらない")
