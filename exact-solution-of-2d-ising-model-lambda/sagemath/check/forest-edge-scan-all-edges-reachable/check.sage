from itertools import combinations


checked = 0
for n in range(1, 5):
    vertices = list(range(n))
    pairs = list(combinations(vertices, 2))
    for mask in range(1 << len(pairs)):
        allowed = {edge for i, edge in enumerate(pairs) if mask & (1 << i)}
        chosen = set()
        for u, v in pairs + list(reversed(pairs)):
            current = Graph([vertices, list(chosen)])
            if (u, v) in allowed and current.shortest_path(u, v) == []:
                chosen.add((u, v))
        final = Graph([vertices, list(chosen)])
        for u, v in allowed:
            assert final.shortest_path(u, v) != []
            checked += 1

print(f"PASS: {checked} inspected edges")
