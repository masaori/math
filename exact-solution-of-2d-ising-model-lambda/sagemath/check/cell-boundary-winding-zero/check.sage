"""Exact finite checks for claim_cell_boundary_winding_zero."""

checked = ZZ(0)
for L in range(1, 9):
    for i in range(L):
        for j in range(L):
            boundary = [
                ("h", i, j, 0),
                ("v", i, (j + 1) % L, 0),
                ("h", (i + 1) % L, j, 1),
                ("v", i, j, 1),
            ]
            horizontal = ZZ(sum(
                ZZ(side == "h" and col == L - 1) * (1 - 2 * direction)
                for side, row, col, direction in boundary
            ))
            vertical = ZZ(sum(
                ZZ(side == "v" and row == L - 1) * (1 - 2 * direction)
                for side, row, col, direction in boundary
            ))
            assert horizontal == 0 and vertical == 0
            assert len(boundary) == 4
            checked += 1

assert checked == sum(L * L for L in range(1, 9))
print(f"PASS: {checked} cell boundaries, including L=1 with four edge occurrences")
