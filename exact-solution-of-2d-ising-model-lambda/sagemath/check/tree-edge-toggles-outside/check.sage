from itertools import combinations, product

edges = tuple(range(4))
subsets = [set(choice) for size in range(5) for choice in combinations(edges, size)]
checked = 0

for forest in subsets:
    outside = set(edges) - forest
    for initial in subsets:
        for length in range(4):
            for toggles in product(tuple(forest), repeat=length):
                selected = set(initial)
                for edge in toggles:
                    before = selected & outside
                    selected.symmetric_difference_update({edge})
                    assert selected & outside == before
                assert selected & outside == initial & outside
                checked += 1

print(f"PASS: {checked} finite edge-set, initial-set, and toggle-list cases")
