from itertools import combinations, product

coords = [(ZZ(r), ZZ(c)) for r in range(2) for c in range(2)]
subsets = [set(chosen) for size in range(5) for chosen in combinations(coords, size)]


def boundary(cells):
    edges = {(False, (r + dr, c)) for r, c in cells for dr in (0, 1)}
    edges |= {(True, (r, c + dc)) for r, c in cells for dc in (0, 1)}
    return {
        (vertical, (r, c)) for vertical, (r, c) in edges
        if (((r, c) in cells) != (((r, c - 1) if vertical else (r - 1, c)) in cells))
    }


checked = 0
for left, right in product(subsets, repeat=2):
    for vertical in (False, True):
        for r in range(-1, 3):
            for c in range(-1, 3):
                first = (ZZ(r), ZZ(c))
                second = (ZZ(r), ZZ(c - 1)) if vertical else (ZZ(r - 1), ZZ(c))
                # Membership in a symmetric difference is exclusive disjunction.
                a, b = first in left, first in right
                x, y = second in left, second in right
                assert ((first in (left.symmetric_difference(right))) != (second in (left.symmetric_difference(right)))) == ((a != b) != (x != y))
                # Commutativity and associativity group terms by cell set.
                assert ((a != b) != (x != y)) == ((a != x) != (b != y))
    assert boundary(left.symmetric_difference(right)) == (boundary(left).symmetric_difference(boundary(right)))
    checked += 1

print(f"PASS: cell-set pairs={checked}, boundary preserves symmetric difference")
