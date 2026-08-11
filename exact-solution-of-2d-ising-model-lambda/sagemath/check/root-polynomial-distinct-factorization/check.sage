# 対象ラベル: claim_root_polynomial_distinct_factorization

R.<t> = PolynomialRing(QQbar)


def root_polynomial(n):
    return t^n + QQbar(-1)


def main():
    for n in [1, 2, 3, 4, 5, 6]:
        f = root_polynomial(n)
        roots = [w for (w, multiplicity) in f.roots(QQbar)]
        assert len(roots) == n
        assert len(set(roots)) == n

        g = f
        chosen = []
        for j in range(n + 1):
            product = prod((t - w) for w in chosen) if chosen else R.one()
            assert f == product * g
            assert all(g[k] == 0 for k in range(n - j + 1, n + 2))
            assert g[n - j] == 1
            assert all(w^n == 1 for w in chosen)
            assert len(set(chosen)) == j

            if j == n:
                continue

            new_root = next(w for w in roots if g(w) == 0)
            assert new_root not in chosen
            quotient, remainder = g.quo_rem(t - new_root)
            assert remainder == 0
            assert g == (t - new_root) * quotient
            chosen.append(new_root)
            g = quotient

        print(f"n={n}: j=0,...,{n} の分解・係数上界・先頭係数・根の所属・相異性が通過")

    print("すべて通過")


main()
