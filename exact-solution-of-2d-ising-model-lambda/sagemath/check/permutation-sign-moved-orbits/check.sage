"""置換符号が動く軌道の長さだけで決まることを厳密検査する。

対象: claim_permutation_sign_moved_orbit_product。
六元集合の全置換について、転倒数で定めた符号と
動く軌道ごとの (-1)^(|C|-1) の積を ZZ で独立に計算する。
"""


def inversion_sign(sigma):
    inversions = sum(1 for i in range(len(sigma)) for j in range(i + 1, len(sigma))
                     if sigma[i] > sigma[j])
    return ZZ(-1) ** inversions


def moved_orbit_family(sigma):
    moved = {i for i in range(len(sigma)) if sigma[i] != i}

    def orbit(start):
        result = []
        current = start
        while current not in result:
            result.append(current)
            current = sigma[current]
        assert current == start
        return frozenset(result)

    return {orbit(i) for i in moved}


checked = 0
for image in Permutations(range(6)):
    sigma = list(image)
    orbit_product = prod(ZZ(-1) ** (len(orbit) - 1)
                         for orbit in moved_orbit_family(sigma))
    assert inversion_sign(sigma) == orbit_product
    checked += 1

assert checked == factorial(6)
print(f"PASS: permutation sign factors over moved orbits ({checked} permutations)")
