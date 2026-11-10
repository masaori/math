# 対象ラベル: claim_grid_edge_endpoint_encoding_injective

from itertools import product

def endpoints(direction, row, column):
    if direction == 0:
        return frozenset(((row, column), (row, column + 1)))
    return frozenset(((row, column), (row + 1, column)))

coordinates = tuple(ZZ(n) for n in range(-4, 5))
encodings = tuple(product((0, 1), coordinates, coordinates))
images = {endpoints(*encoding) for encoding in encodings}
assert len(images) == len(encodings)
print(f"PASS: {len(encodings)} coordinate edges have distinct endpoint sets")
