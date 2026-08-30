"""置換項が固定辺の因子と軌道ごとの重みの積に分解することを厳密検査する。

対象: claim_kac_ward_term_orbit_weight_factorization。
一辺 L=2 のトーラスの向き付き辺のうち先頭六辺の全置換 6! 個を取り、残りを固定する。
四つのスピン構造それぞれについて、置換項 T^{a,b}_φ(x) と
sgn(φ)·(固定辺の K の積)·(軌道ごとの (-x)^{|C|}·成分積) を Q(ζ8)[x] で独立に
計算して一致を確かめる。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def permutation_sign(sigma):
    """転倒数による符号（def_permutation_sign と同じ定義）。"""
    inversions = sum(1 for i in range(len(sigma)) for j in range(i + 1, len(sigma))
                     if sigma[i] > sigma[j])
    return (-1) ** inversions


L = 2
oriented = edges(L)
N = len(oriented)
checked_terms = 0

for a in (0, 1):
    for b in (0, 1):
        m = matrix(K8, N, N, lambda r, s:
                   transition_entry(L, a, b, oriented[r], oriented[s]))
        for image in Permutations(range(6)):
            sigma = list(image) + list(range(6, N))
            moved = {i for i in range(N) if sigma[i] != i}

            # 左辺: 置換項の定義どおりの成分積。
            term = P(permutation_sign(sigma))
            for i in range(N):
                diagonal = P(1) if i == sigma[i] else P(0)
                term *= diagonal - x * P(m[i, sigma[i]])

            # 右辺: 固定辺の因子と軌道ごとの重みの積。
            def orbit(start):
                result = []
                current = start
                while current not in result:
                    result.append(current)
                    current = sigma[current]
                assert current == start
                return frozenset(result)

            family = {orbit(i) for i in moved}
            factored = P(permutation_sign(sigma))
            for i in range(N):
                if i not in moved:
                    factored *= P(1) - x * P(m[i, i])
            for component in family:
                weight = (-x) ** len(component)
                for i in component:
                    weight *= P(m[i, sigma[i]])
                factored *= weight

            assert term == factored
            checked_terms += 1

assert checked_terms == 4 * factorial(6)
print("PASS: permutation term factors through fixed edges and orbit weights "
      f"({checked_terms} terms)")
