# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: t(i,j) = 基点から縦、横の順に辿る辺列の B 所属数の剰余類
# 帰属: Z/2Z、NN、ZZ。有限和の定義を辺番号と端点から独立に検査する。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = 0
empty_paths = 0
for case in _rc_cases:
    L = case['L']
    for (i, j), parity in case['t'].items():
        path = [edge_number_vertical(L, projection(L, r), 0)
                for r in range(representative(L, i))]
        path += [edge_number_horizontal(L, i, projection(L, c))
                 for c in range(representative(L, j))]
        vertex = (projection(L, 0), projection(L, 0))
        count = NN(0)
        for edge in path:
            start, finish = endpoints(L, edge)
            assert start == vertex
            count += NN(edge in case['B'])
            vertex = finish
        assert vertex == (i, j)
        assert parity == _rc_ring(count)
        assert parity.parent() == _rc_ring
        empty_paths += NN(not path)
        checked += 1
assert empty_paths == len(_rc_cases)
print("RESULT: PASS (道和の定義: %d 頂点、空の道 %d 個)" % (checked, empty_paths))
