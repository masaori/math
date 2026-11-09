from itertools import combinations

checked = 0
for n in range(2, 5):
    vertices = tuple(range(n))
    edges = tuple(combinations(vertices, 2))
    for u_bits in range(1 << n):
        unprocessed = {v for v in vertices if u_bits & (1 << v)}
        for e in edges:
            if not set(e) <= unprocessed:
                continue
            for a_bits in range(1 << len(edges)):
                selected = {edges[i] for i in range(len(edges)) if a_bits & (1 << i)}
                toggled = selected.symmetric_difference({e})
                for v in vertices:
                    if v in unprocessed:
                        continue
                    before = sum(v in edge for edge in selected)
                    after = sum(v in edge for edge in toggled)
                    assert before % 2 == after % 2
                    checked += 1
assert checked > 0
print(f"PASS: {checked} processed-vertex parity comparisons")
