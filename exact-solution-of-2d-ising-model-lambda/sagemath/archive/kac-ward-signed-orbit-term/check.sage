"""置換項と行列式の置換展開を閉路軌道重みで厳密検査する。

対象: claim_kac_ward_signed_orbit_term_product。
一辺 L=2 の先頭六向き付き辺の全置換と四つのスピン構造について、
定義どおりの置換項と、軌道ごとの -x^|C| 倍の重みの積を Q(ζ8)[x] で比較する。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def permutation_sign(sigma):
    inversions = sum(1 for i in range(len(sigma)) for j in range(i + 1, len(sigma))
                     if sigma[i] > sigma[j])
    return (-1) ** inversions


def orbit_family(sigma):
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


L = 2
oriented = edges(L)
N = len(oriented)
checked_terms = 0

for a in (0, 1):
    for b in (0, 1):
        m = matrix(K8, N, N, lambda r, s:
                   transition_entry(L, a, b, oriented[r], oriented[s]))
        assert all(m[i, i] == 0 for i in range(N))
        determinant_from_terms = P(0)
        determinant_from_orbits = P(0)
        for image in Permutations(range(6)):
            sigma = list(image) + list(range(6, N))

            term = P(permutation_sign(sigma))
            for i in range(N):
                term *= (P(1) if i == sigma[i] else P(0)) - x * P(m[i, sigma[i]])

            orbit_term = P(1)
            for component in orbit_family(sigma):
                weight = -(x ** len(component))
                for i in component:
                    weight *= P(m[i, sigma[i]])
                orbit_term *= weight

            assert term == orbit_term
            determinant_from_terms += term
            determinant_from_orbits += orbit_term
            checked_terms += 1

        assert determinant_from_terms == determinant_from_orbits

assert checked_terms == 4 * factorial(6)
print("PASS: signed permutation terms equal products of closed-orbit weights "
      f"({checked_terms} terms)")
