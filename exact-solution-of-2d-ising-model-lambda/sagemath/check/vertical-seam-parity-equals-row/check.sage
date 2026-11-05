# 対象ラベル: claim_vertical_seam_parity_equals_row
from itertools import product


checked = 0
for size in (1, 2, 3):
    edges = [(side, row, col)
             for side in ("h", "v")
             for row in range(size)
             for col in range(size)]
    seam_edges = [("v", size - 1, row) for row in range(size)]
    for edge in edges:
        column_indicator_sum = sum(ZZ(edge == candidate) for candidate in seam_edges)
        seam_indicator = ZZ(edge[0] == "v" and edge[1] == size - 1)
        assert column_indicator_sum == seam_indicator
        checked += 1
    for length in range(1, 4):
        for walk in product(edges, repeat=length):
            base_parities = [sum(ZZ(edge == candidate) for edge in walk) % 2
                             for candidate in seam_edges]
            row_parity = sum(base_parities) % 2
            raw_row_count = sum(sum(ZZ(edge == candidate) for edge in walk)
                                   for candidate in seam_edges) % 2
            swapped_count = sum(sum(ZZ(edge == candidate) for candidate in seam_edges)
                                for edge in walk) % 2
            seam_parity = sum(ZZ(edge[0] == "v" and edge[1] == size - 1)
                              for edge in walk) % 2
            assert row_parity == raw_row_count
            assert raw_row_count == swapped_count
            assert swapped_count == seam_parity
            checked += 1

print(f"PASS: {checked} exact seam-row identities")
