import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../homology-class-generating-polynomial/_prelude.sage"))

first_homology_group = {
    quotient_map(cycle)
    for cycle in first_cycle_space
}


def edge_subset_monomial(chosen):
    return u ** (len(edges) - len(chosen)) * v ** len(chosen)


sector_polynomial_sum = sum(
    homology_class_generating_polynomial(homology_class)
    for homology_class in first_homology_group
)

expanded_fiber_sum = sum(
    edge_subset_monomial(chosen)
    for homology_class in first_homology_group
    for chosen in even_edge_subsets
    if homology_class_map(chosen) == homology_class
)

even_subgraph_polynomial = sum(
    edge_subset_monomial(chosen)
    for chosen in even_edge_subsets
)
