"""向き付き切断線横断数の偶奇が無向きの切断線偶奇に等しいことを検査する。

対象: claim_directed_winding_parity
"""

from itertools import product


for length in range(1, 9):
    for horizontal_data in product((0, 1), repeat=2 * length):
        crossings = horizontal_data[:length]
        directions = horizontal_data[length:]
        winding = sum(ZZ(c) * (1 - 2 * ZZ(d)) for c, d in zip(crossings, directions))
        parity = sum(ZZ(c) for c in crossings) % 2
        assert winding % 2 == parity

    for vertical_data in product((0, 1), repeat=2 * length):
        crossings = vertical_data[:length]
        directions = vertical_data[length:]
        winding = sum(ZZ(c) * (1 - 2 * ZZ(d)) for c, d in zip(crossings, directions))
        parity = sum(ZZ(c) for c in crossings) % 2
        assert winding % 2 == parity

print("PASS: directed winding parity for all binary data of lengths 1,...,8")
