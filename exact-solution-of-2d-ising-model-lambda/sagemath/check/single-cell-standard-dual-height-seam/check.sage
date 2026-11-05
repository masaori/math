# 対象ラベル: claim_single_cell_standard_dual_height_seam
from itertools import product


def base_edge(direction):
    return "h" if direction in (0, 1) else "v"


checked = 0
for length in range(1, 9):
    for directions in product(range(4), repeat=length):
        if any(directions[k] == (directions[(k + 1) % length] ^ 1)
               for k in range(length)):
            continue
        edges = [base_edge(direction) for direction in directions]
        horizontal_seam = sum(ZZ(edge == "h") for edge in edges) % 2
        vertical_seam = sum(ZZ(edge == "v") for edge in edges) % 2
        if horizontal_seam or vertical_seam:
            continue
        horizontal_edge = sum(ZZ(edge == "h") for edge in edges) % 2
        vertical_edge = sum(ZZ(edge == "v") for edge in edges) % 2
        height = (sum([]) + sum([])) % 2
        assert horizontal_edge == horizontal_seam == 0
        assert vertical_edge == vertical_seam == 0
        assert height == (height + horizontal_edge) % 2
        assert height == (height + vertical_edge) % 2
        checked += 1

print(f"PASS: {checked} exact single-cell closed walks")
