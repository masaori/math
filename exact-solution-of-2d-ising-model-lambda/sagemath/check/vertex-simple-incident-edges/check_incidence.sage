# 対象ラベル: claim_vertex_simple_incident_edges
from itertools import permutations

for length in range(1, 7):
    for targets in permutations(range(length)):
        # The edge with label j runs from the preceding target to target[j].
        sources = (targets[-1],) + targets[:-1]
        for k in range(length):
            vertex = targets[k]
            target_sum = sum(ZZ(t == vertex) for t in targets)
            source_sum = sum(ZZ(s == vertex) for s in sources)
            assert target_sum == 1
            assert source_sum == target_sum
            assert source_sum + target_sum == 2

# A single labelled loop has two endpoint incidences at its one vertex.
assert sum(ZZ(x == 0) for x in (0, 0)) == 2
print("PASS: labelled incidence count for all permutations of lengths 1 through 6")
