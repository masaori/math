# 対象ラベル: claim_horizontal_seam_parity_equals_column
from itertools import product


checked = 0
for size in (1, 2, 3):
    edges = [(side, row, col)
             for side in ("h", "v")
             for row in range(size)
             for col in range(size)]
    seam_edges = [("h", row, size - 1) for row in range(size)]
    for edge in edges:
        row_indicator_sum = sum(ZZ(edge == candidate) for candidate in seam_edges)
        seam_indicator = ZZ(edge[0] == "h" and edge[2] == size - 1)
        assert row_indicator_sum == seam_indicator
        checked += 1
    for length in range(1, 4):
        for walk in product(edges, repeat=length):
            base_parities = [sum(ZZ(edge == candidate) for edge in walk) % 2
                             for candidate in seam_edges]
            column_parity = sum(base_parities) % 2
            raw_column_count = sum(sum(ZZ(edge == candidate) for edge in walk)
                                   for candidate in seam_edges) % 2
            swapped_count = sum(sum(ZZ(edge == candidate) for candidate in seam_edges)
                                for edge in walk) % 2
            seam_parity = sum(ZZ(edge[0] == "h" and edge[2] == size - 1)
                              for edge in walk) % 2
            assert column_parity == raw_column_count
            assert raw_column_count == swapped_count
            assert swapped_count == seam_parity
            checked += 1

print(f"PASS: {checked} exact seam-column identities")
