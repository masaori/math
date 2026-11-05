from itertools import product


def ends(edge, size):
    side, row, col = edge
    return ((row, col), ((row + (side == "v")) % size,
                         (col + (side == "h")) % size))


checked = 0
for size in range(1, 4):
    edges = [(side, row, col)
             for side in ("h", "v")
             for row in range(size)
             for col in range(size)]
    for length in range(1, 5):
        for start in range(size):
            for directions in product(range(4), repeat=length):
                vertices = [(start, 0)]
                walk = []
                for direction in directions:
                    row, col = vertices[-1]
                    step = ((0, 1), (0, -1), (1, 0), (-1, 0))[direction]
                    next_vertex = ((row + step[0]) % size,
                                   (col + step[1]) % size)
                    edge = (("h", row, col) if direction == 0 else
                            ("h", row, (col - 1) % size) if direction == 1 else
                            ("v", row, col) if direction == 2 else
                            ("v", (row - 1) % size, col))
                    walk.append(edge)
                    vertices.append(next_vertex)
                if vertices[-1] != vertices[0]:
                    continue
                for row in range(size):
                    for col in range(size):
                        four = [("h", row, col), ("h", row, (col - 1) % size),
                                ("v", row, col), ("v", (row - 1) % size, col)]
                        four_count = sum(sum(ZZ(edge == named) for edge in walk)
                                         for named in four)
                        endpoint_count = sum(
                            ZZ((row, col) == end)
                            for edge in walk for end in ends(edge, size))
                        assert four_count == endpoint_count
                        assert endpoint_count % 2 == 0
                        assert sum(sum(ZZ(edge == named) for edge in walk) % 2
                                   for named in four) % 2 == 0
                        checked += 1
print(f"PASS: {checked} closed-walk four-edge incidences")
