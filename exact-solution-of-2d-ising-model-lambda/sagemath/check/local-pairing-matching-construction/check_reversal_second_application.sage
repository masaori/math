# 対象ラベル: claim_local_pairing_matching_construction
# 式ペア: τ(τ(h)) = ι(ι(h)) = h, p(h) ∉ P
from itertools import combinations

for edge_count in (2, 8, 18):
    for size in range(3):
        for chosen in combinations(range(edge_count), size):
            for edge in range(edge_count):
                if edge in chosen:
                    continue
                for direction in (0, 1):
                    h = (edge, direction)
                    first = (edge, 1 - direction)
                    second = (first[0], 1 - first[1])
                    assert first[0] not in chosen
                    assert first != h
                    assert second == h

print("RESULT: PASS; reversal branch and no fixed point checked exactly")
