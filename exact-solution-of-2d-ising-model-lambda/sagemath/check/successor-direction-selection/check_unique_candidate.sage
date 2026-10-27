# 対象ラベル: claim_successor_direction_selection
# 始点と方向を固定した候補が一意であることを、辺長一を含め厳密な有限計算で照合する。
load('sagemath/check/successor-direction-selection/_prelude.sage')
for L in range(1, 5):
    edges = list(oriented_edges(L))
    for e in edges:
        target = endpoints_and_direction(L, e)[1]
        for direction in range(4):
            candidates = [f for f in edges
                          if endpoints_and_direction(L, f)[0] == target
                          and endpoints_and_direction(L, f)[2] == direction]
            assert len(candidates) == 1
