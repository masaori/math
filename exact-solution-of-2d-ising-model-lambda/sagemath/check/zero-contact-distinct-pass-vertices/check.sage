"""Finite exact check for claim_zero_contact_iff_distinct_pass_vertices."""

from itertools import product


checked = 0
for length in range(1, 6):
    for targets in product(range(3), repeat=length):
        contact_count = ZZ(sum(
            1 for a in range(length) for b in range(length)
            if a < b and targets[a] == targets[b]
        ))
        distinct_pass_vertices = len(set(targets)) == length
        assert (contact_count == 0) == distinct_pass_vertices
        checked += 1

assert checked == 363
assert ZZ(sum(1 for a in range(3) for b in range(3)
              if a < b and (0, 1, 0)[a] == (0, 1, 0)[b])) == 1
print(f"PASS: {checked} finite target sequences, including a contact at the first passage")
