load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    fibers = [edge_fiber(example, edge) for edge in example["edges"]]
    assert all(
        fibers[i].intersection(fibers[j]).cardinality() == NN(0)
        for i in range(len(fibers))
        for j in range(i + 1, len(fibers))
    )
    union = Set([])
    for fiber in fibers:
        union = union.union(fiber)
    assert union == occurrence_set(example)
    assert occurrence_set(example).cardinality() == sum(
        (fiber.cardinality() for fiber in fibers),
        NN(0),
    )

print("RESULT: PASS — edge labels partition the finite corner-occurrence set into fibers")
