# 対象ラベル: claim_dual_broken_edges_winding_zero
from itertools import product

winding_rows = []
for length in range(1, 7):
    for spins in product((1, -1), repeat=length):
        codes = [ZZ(spin == -1) for spin in spins]
        shifted = codes[1:] + codes[:1]
        broken = [ZZ(spins[i] != spins[(i+1) % length]) for i in range(length)]
        winding_rows.append((codes, shifted, broken))
