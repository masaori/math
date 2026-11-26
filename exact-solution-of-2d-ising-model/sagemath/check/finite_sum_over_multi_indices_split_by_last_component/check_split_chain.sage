# 対象ラベル: finite_sum_over_multi_indices_split_by_last_component
# Σ_{I∈𝓘_{M+1}} a(I) = Σ_{t=1}^{2} Σ_{K∈𝓘_M} a(K,t) の証明の準備（ν(K,t) = 2(ν(K)−1)+t、ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)）と
# 本体の 9 行（左辺の Σ_{I∈𝓘_{M+1}} と 7 行目以降の Σ_{K∈𝓘_M} は msum で組む）を M = 1,…,5 で確かめる。ν は def_kronecker、ν^{-1} は ν の値から引いた逆写像、
# 𝓘_M の上の和は def_finite_sum_of_complex_numbers_over_multi_indices（Σ_{k=1}^{2^M} a(ν^{-1}(k))）で組む。
# 帰属: ν は ZZ、a(I) は QQ 上の多項式環の不定元。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
import itertools


def nu(I):
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2 ** (M - k) for k in range(1, M + 1))


def nu_inv_table(M):
    tab = {}
    for I in itertools.product([1, 2], repeat=M):
        tab[nu(I)] = I
    assert sorted(tab) == list(range(1, 2 ** M + 1))          # ν は全単射
    return tab


def fsum(zs, P):
    if len(zs) == 0:
        return P(0)
    s = zs[0]
    for w in zs[1:]:
        s = s + w
    return s


def msum(f, M, P):
    """def_finite_sum_of_complex_numbers_over_multi_indices: Σ_{I∈𝓘_M} f(I) := Σ_{k=1}^{2^M} f(ν^{-1}(k))。
    ν^{-1}(k) は 𝓘_M を列挙して ν(I) = k の I を探して引く（nu_inv_table とは別の経路）。"""
    elems = list(itertools.product([1, 2], repeat=M))
    return fsum([f([I for I in elems if nu(I) == k][0]) for k in range(1, 2 ** M + 1)], P)


count = 0
for M in range(1, 6):
    inv_M = nu_inv_table(M)
    inv_M1 = nu_inv_table(M + 1)
    # 準備: ν(K,t) = 2(ν(K)−1)+t（6 行の各値）
    for K in itertools.product([1, 2], repeat=M):
        for t in [1, 2]:
            Kt = K + (t,)
            s = sum((K[k - 1] - 1) * 2 ** (M - k) for k in range(1, M + 1))
            lines = [
                nu(Kt),
                1 + sum((Kt[k - 1] - 1) * 2 ** (M + 1 - k) for k in range(1, M + 2)),
                1 + sum((K[k - 1] - 1) * 2 ** (M + 1 - k) for k in range(1, M + 1)) + (t - 1) * 2 ** 0,
                1 + sum((K[k - 1] - 1) * 2 ** (M - k) * 2 for k in range(1, M + 1)) + (t - 1) * 1,
                1 + 2 * s + (t - 1),
                1 + 2 * (nu(K) - 1) + (t - 1),
                2 * (nu(K) - 1) + t,
            ]
            for i in range(len(lines) - 1):
                assert lines[i] == lines[i + 1], (M, K, t, i)
    # 準備: ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)
    for k in range(1, 2 ** M + 1):
        for t in [1, 2]:
            assert nu(inv_M[k] + (t,)) == 2 * (nu(inv_M[k]) - 1) + t == 2 * (k - 1) + t
            assert inv_M1[2 * (k - 1) + t] == inv_M[k] + (t,)
    # 本体の 9 行（左辺の Σ_{I∈𝓘_{M+1}} と 7 行目以降の Σ_{K∈𝓘_M} は msum で組む）
    names = ["a_" + "".join(map(str, I)) for I in itertools.product([1, 2], repeat=M + 1)]
    P = PolynomialRing(QQ, names)
    a = {I: P.gen(i) for i, I in enumerate(itertools.product([1, 2], repeat=M + 1))}
    n = 2 ** M
    lines = [
        msum(lambda I: a[I], M + 1, P),
        fsum([a[inv_M1[j]] for j in range(1, 2 ** (M + 1) + 1)], P),
        fsum([a[inv_M1[j]] for j in range(1, 2 * n + 1)], P),
        fsum([a[inv_M1[2 * k - 1]] + a[inv_M1[2 * k]] for k in range(1, n + 1)], P),
        fsum([a[inv_M1[2 * (k - 1) + 1]] + a[inv_M1[2 * (k - 1) + 2]] for k in range(1, n + 1)], P),
        fsum([a[inv_M[k] + (1,)] + a[inv_M[k] + (2,)] for k in range(1, n + 1)], P),
        fsum([a[inv_M[k] + (1,)] for k in range(1, n + 1)], P) + fsum([a[inv_M[k] + (2,)] for k in range(1, n + 1)], P),
        msum(lambda K: a[K + (1,)], M, P) + msum(lambda K: a[K + (2,)], M, P),
        fsum([msum(lambda K: a[K + (1,)], M, P)], P) + msum(lambda K: a[K + (2,)], M, P),
        fsum([msum(lambda K, t=t: a[K + (t,)], M, P) for t in [1, 2]], P),
    ]
    for i in range(len(lines) - 1):
        assert lines[i] == lines[i + 1], (M, i)
    # 比べる側: 𝓘_{M+1} の全ての元を Sage の sum で足す（独立な経路）
    assert sum(a.values()) == lines[-1]
    # 対照: 最後の成分が 2 の項を落とすと一致しない
    assert lines[0] != fsum([a[inv_M[k] + (1,)] for k in range(1, n + 1)], P)
    count += 1
print(f"M = 1,…,5 の {count} 通りで準備と本体の各行を確かめた")
print("RESULT: PASS")
