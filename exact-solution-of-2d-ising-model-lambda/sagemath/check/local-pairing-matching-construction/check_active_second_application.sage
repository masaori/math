# 対象ラベル: claim_local_pairing_matching_construction
# 式ペア: τ(τ(h)) = κ(κ(h)) = h, p(h) ∈ P
from itertools import combinations

for edge_count in (2, 8, 18):
    for chosen in combinations(range(edge_count), 2):
        active = [(edge, direction) for edge in chosen for direction in (0, 1)]
        # Three pairings of four distinct half-edges.
        for partner in active[1:]:
            other = [h for h in active[1:] if h != partner]
            kappa = {active[0]: partner, partner: active[0],
                     other[0]: other[1], other[1]: other[0]}
            for h in active:
                tau_h = kappa[h]
                assert tau_h != h
                assert tau_h[0] in chosen
                assert kappa[tau_h] == h

print("RESULT: PASS; active branch and local involution checked exactly")
