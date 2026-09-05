"""切断を横切る辺を動かすプラケット変形での同時変化を調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

偶部分グラフを結ぶ基本の局所変形はプラケット（単位面の境界 4 辺）との
対称差である。切断（mod L の巻き戻り）に接するプラケットの差分は
切断を横切る辺を動かす。各鍵 (D, E) と各プラケット P について、
E' = E △ P が同じ鍵の族に属するとき、標準形配向での

  動辺数、頂点項（頂点局所量の積の符号指数）、非共有端点対項、標的指数

の四つの mod 2 変化を計算する。恒等式から
「動辺数の変化＋頂点項の変化＋対項の変化 = 標的指数の変化」は毎回成り立つ。
調べるのは、この同時変化がプラケットの切断旗（行・列が巻き戻るか）と
プラケット近傍の局所配置（E と D の入り方）だけで決まるか、である。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-plaquette-deformation/construction.sage")

for side in (2, 3):
    keys = collect_keys(side)
    key_set = set(keys)
    terms = {}
    for doubled, single in keys:
        terms[(doubled, single)] = key_terms(side, doubled, single)

    deformation_count = ZZ(0)
    cut_deformation_count = ZZ(0)
    flag_only_classes = {}
    local_classes = {}
    local_with_d_classes = {}
    reduced_classes = {}
    for doubled, single in keys:
        base_terms = terms[(doubled, single)]
        for row in range(side):
            for column in range(side):
                plaquette = plaquette_edges(side, row, column)
                deformed = frozenset(single.symmetric_difference(plaquette))
                if (doubled, deformed) not in key_set:
                    continue
                new_terms = terms[(doubled, deformed)]
                change = tuple(
                    (new_value + old_value) % 2
                    for new_value, old_value in zip(new_terms, base_terms))
                assert (change[0] + change[1] + change[2]) % 2 == change[3]
                flags = plaquette_cut_flags(side, row, column)
                pattern = plaquette_local_pattern(side, row, column, single)
                doubled_pattern = plaquette_local_pattern(
                    side, row, column, doubled)
                flag_only_classes.setdefault(flags, set()).add(change)
                local_classes.setdefault(
                    (flags, pattern), set()).add(change)
                local_with_d_classes.setdefault(
                    (flags, pattern, doubled_pattern), set()).add(change)
                reduced = (change[0], (change[1] + change[2]) % 2, change[3])
                reduced_classes.setdefault(
                    (flags, pattern, doubled_pattern), set()).add(reduced)
                deformation_count += 1
                if flags != (ZZ(0), ZZ(0)):
                    cut_deformation_count += 1

    mixed_flag_only = sum(
        1 for values in flag_only_classes.values() if len(values) > 1)
    mixed_local = sum(
        1 for values in local_classes.values() if len(values) > 1)
    mixed_local_with_d = sum(
        1 for values in local_with_d_classes.values() if len(values) > 1)
    mixed_reduced = sum(
        1 for values in reduced_classes.values() if len(values) > 1)
    component_varies = [ZZ(0)] * 4
    for values in local_with_d_classes.values():
        if len(values) <= 1:
            continue
        for index in range(4):
            if len({value[index] for value in values}) > 1:
                component_varies[index] += 1
    print("L=%d: keys=%d deformations=%d cut-deformations=%d "
          "flag-classes=%d mixed=%d local-classes=%d mixed=%d "
          "local+D-classes=%d mixed=%d reduced-mixed=%d "
          "component-varies(moved,vertex,pair,target)=%s"
          % (side, len(keys), deformation_count, cut_deformation_count,
             len(flag_only_classes), mixed_flag_only,
             len(local_classes), mixed_local,
             len(local_with_d_classes), mixed_local_with_d,
             mixed_reduced, component_varies))
    assert deformation_count > 0
    assert cut_deformation_count > 0
    if side == 2:
        assert mixed_local_with_d == 0
    else:
        assert mixed_local_with_d > 0
        assert component_varies[0] == 0
        assert component_varies[3] == 0
    assert mixed_reduced == 0

print("PASS: プラケット変形で、頂点項と非共有端点対項の和の変化・動辺数の変化・"
      "標的指数の変化は切断旗と近傍配置だけで決まり（混在零）、"
      "二項への割り方だけが近傍配置では決まらない")
