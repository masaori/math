from itertools import permutations

# 対象ラベル: claim_admissible_direction_permutations
expected_by_first_image = {
    0: {(0, 1, 2, 3), (0, 1, 3, 2), (0, 2, 1, 3)},
    1: {(1, 0, 2, 3), (1, 0, 3, 2), (1, 2, 3, 0)},
    3: {(3, 0, 1, 2), (3, 1, 2, 0), (3, 2, 1, 0)},
}

all_permutations = list(permutations(range(4)))
assert len(all_permutations) == 24
for first_image in range(4):
    admissible = {
        sigma for sigma in all_permutations
        if sigma[0] == first_image
        and all(sigma[j] != (j + 2) % 4 for j in range(4))
    }
    assert admissible == expected_by_first_image.get(first_image, set())

assert sum(len(group) for group in expected_by_first_image.values()) == 9
print('PASS: the nine admissible four-direction permutations are exactly the listed ones')
