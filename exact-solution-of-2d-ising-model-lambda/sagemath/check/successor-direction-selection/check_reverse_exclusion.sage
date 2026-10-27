# 対象ラベル: claim_successor_direction_selection
# 反転方向だけが非後退の後続辺から外れることを厳密に照合する。
load('sagemath/check/successor-direction-selection/_prelude.sage')
for L in range(1, 5):
    edges = list(oriented_edges(L))
    for e in edges:
        target = endpoints_and_direction(L, e)[1]
        direction_e = endpoints_and_direction(L, e)[2]
        reversed_e = (e[0], not e[1])
        assert endpoints_and_direction(L, reversed_e)[0] == target
        assert endpoints_and_direction(L, reversed_e)[2] == (direction_e + 2) % 4
        for direction in range(4):
            candidates = [f for f in edges
                          if endpoints_and_direction(L, f)[0] == target
                          and endpoints_and_direction(L, f)[2] == direction]
            assert len(candidates) == 1
            f = candidates[0]
            in_next = endpoints_and_direction(L, f)[0] == target and f != reversed_e
            assert in_next == (direction != (direction_e + 2) % 4)
