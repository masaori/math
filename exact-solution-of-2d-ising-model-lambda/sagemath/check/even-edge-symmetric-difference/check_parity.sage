from itertools import combinations

def subsets(edges):
    return [frozenset(c) for k in range(len(edges) + 1) for c in combinations(edges, k)]

def incidence_count(v, edge_set):
    return sum(1 for e in edge_set if v in e)

checked = 0
for graph in [graphs.PathGraph(4), graphs.CycleGraph(4), graphs.CompleteGraph(4)]:
    vertices = graph.vertices()
    edges = [frozenset(e) for e in graph.edges(labels=False)]
    choices = subsets(edges)
    for A in choices:
        for B in choices:
            for v in vertices:
                Av = {e for e in A if v in e}
                Bv = {e for e in B if v in e}
                assert incidence_count(v, A.symmetric_difference(B)) == len(Av) + len(Bv) - 2 * len(Av & Bv)
            if all(incidence_count(v, A) % 2 == 0 and incidence_count(v, B) % 2 == 0 for v in vertices):
                assert all(incidence_count(v, A.symmetric_difference(B)) % 2 == 0 for v in vertices)
            checked += 1
print(f'PASS: {checked} pairs')
