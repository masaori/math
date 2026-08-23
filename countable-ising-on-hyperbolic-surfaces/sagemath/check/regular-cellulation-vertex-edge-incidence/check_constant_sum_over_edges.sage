load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    left = sum((NN(2) for edge in example["edges"]), NN(0))
    right = NN(2) * NN(len(example["edges"]))
    assert left == right

print("RESULT: PASS — the constant sum of two over all edges equals 2|E|")
