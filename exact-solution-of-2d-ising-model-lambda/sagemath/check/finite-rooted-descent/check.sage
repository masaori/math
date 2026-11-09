from itertools import combinations

checked = 0
for n in range(1, 4):
    vertices = frozenset(range(n))
    root = 0
    edge_choices = (frozenset(), frozenset({0}))
    subsets = [frozenset(c) for k in range(n + 1) for c in combinations(vertices, k)]
    states = [(U, A) for U in subsets for A in edge_choices]
    terminal = frozenset({root})
    for mask in range(1 << len(states)):
        P = {states[i] for i in range(len(states)) if mask & (1 << i)}
        if any(root not in U for U, _ in P):
            continue
        def successors(U):
            return [(U - {v}, B) for v in U - {root} for B in edge_choices]
        if any(U != terminal and not any(s in P for s in successors(U)) for U, _ in P):
            continue
        for U, A in P:
            reachable = {(U, A)}
            for _ in range(n):
                reachable |= {s for X, _ in tuple(reachable) for s in successors(X) if s in P}
            assert any(X == terminal for X, _ in reachable)
            checked += 1

print(f"PASS: {checked} admissible finite initial states")
