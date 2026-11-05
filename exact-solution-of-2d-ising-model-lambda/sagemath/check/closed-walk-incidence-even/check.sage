# Closed cyclic edge lists: compare endpoint counts before reducing modulo two.
from itertools import product

checked = 0
for vertices in range(1, 5):
    for length in range(1, 7):
        for walk in product(range(vertices), repeat=length):
            for v in range(vertices):
                source_sum = sum(ZZ(walk[k] == v) for k in range(length))
                target_sum = sum(ZZ(walk[(k + 1) % length] == v) for k in range(length))
                assert target_sum == source_sum
                assert (source_sum + target_sum) % 2 == 0
                checked += 1
print(f"PASS: {checked} closed-walk vertex incidences")
