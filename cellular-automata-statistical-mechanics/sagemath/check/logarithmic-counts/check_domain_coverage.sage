# 対象ラベル: def_binary_ca_positive_fiber_levels
# 判定: 全数範囲の入力数と、空・非空・隣接差・非保存の各枝が実際に現れること。
# 帰属: 有限表・ZZ。意味の対応は本文を読むLLMによる検証で別に判断する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
map_counts = {0: 0, 1: 0, 2: 0}
candidates = 0
accepted = 0
rejected = 0
for size, configs, index, mapping, local in ca_maps():
    map_counts[size] += 1
    for raw_H in product((-1,0,1,2), repeat=len(mapping)):
        H = tuple(ZZ(z) for z in raw_H)
        candidates += 1
        if conserved(mapping,H):
            accepted += 1
        else:
            rejected += 1
            assert any(H[mapping[x]] != H[x] for x in range(len(mapping)))
assert map_counts == {0: 1, 1: 4, 2: 256}
assert candidates == 65604
assert accepted > 0 and rejected > 0 and accepted + rejected == candidates
fiber_inputs = empty = nonempty = adjacent = missing_adjacent = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    fiber_inputs += 1
    if D:
        nonempty += 1
    else:
        empty += 1
        assert fixed == set()
        assert sum((omega(mapping,H,n,u) for u in D),ZZ(0)) == 0
    for u in range(-2,4):
        if u in D and u+1 in D:
            adjacent += 1
        else:
            missing_adjacent += 1
assert fiber_inputs == empty + nonempty
assert empty > 0 and nonempty > 0 and adjacent > 0 and missing_adjacent > 0
zero_total = positive_total = 0
for size, mapping, n in ca_count_rows():
    if count_fixed(mapping,n) == 0:
        zero_total += 1
    else:
        positive_total += 1
assert zero_total > 0 and positive_total > 0
assert zero_total + positive_total == 2066
# 分割計数が保存条件を使わないという本文末尾の注記を、非保存の一例でも照合する。
mapping, H, n = (1,0), (ZZ(0),ZZ(1)), 2
assert not conserved(mapping,H)
assert sum((omega(mapping,H,n,u) for u in levels(mapping,H,n)),ZZ(0)) == count_fixed(mapping,n)
print('maps by cell count:',map_counts)
print('observable candidates / conserved / rejected:', candidates, accepted, rejected)
print('fiber inputs / empty / nonempty:', fiber_inputs, empty, nonempty)
print('adjacent / missing adjacent inputs:',adjacent,missing_adjacent)
print('zero / positive total inputs:',zero_total,positive_total)
print('RESULT: PASS')
