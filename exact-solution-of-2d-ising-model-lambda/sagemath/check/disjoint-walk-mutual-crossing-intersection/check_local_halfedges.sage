# 対象ラベル: claim_disjoint_walk_mutual_crossing_intersection
# 四半辺を二本の歩道へ割り当てたときの局所等式。整数で全六通りを検査する。
from itertools import combinations

halves = {'left', 'up', 'right', 'down'}
for first_tuple in combinations(sorted(halves), 2):
    first = set(first_tuple)
    second = halves - first
    intersection = (ZZ('left' in first) * ZZ('up' in second)
                    + ZZ('down' in first) * ZZ('right' in second)) % 2
    crossing = ZZ(first == {'left', 'right'} or first == {'up', 'down'})
    assert intersection == crossing, (first, second)
print('RESULT: PASS local halfedge equality')
