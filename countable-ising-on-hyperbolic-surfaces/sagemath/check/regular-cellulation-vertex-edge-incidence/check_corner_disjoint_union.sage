load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    corner_sets = [vertex_corner_set(example, vertex) for vertex in example["vertices"]]
    assert all(
        corner_sets[i].intersection(corner_sets[j]).cardinality() == NN(0)
        for i in range(len(corner_sets))
        for j in range(i + 1, len(corner_sets))
    )
    union = Set([])
    for corner_set in corner_sets:
        union = union.union(corner_set)
    assert union == occurrence_set(example)
    assert sum((corner_set.cardinality() for corner_set in corner_sets), NN(0)) == occurrence_set(example).cardinality()

print("RESULT: PASS — arrival vertices partition the finite corner-occurrence set")
