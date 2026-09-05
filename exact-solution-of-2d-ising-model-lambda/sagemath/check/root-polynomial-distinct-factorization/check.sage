# 対象ラベル: claim_root_polynomial_distinct_factorization

R.<t> = PolynomialRing(QQbar)


def root_polynomial(n):
    return t^n + QQbar(-1)


def linear_factor_product(values):
    return prod((t - w) for w in values) if values else R.one()


def main():
    for n in [1, 2, 3, 4, 5, 6]:
        f = root_polynomial(n)
        roots = [w for (w, multiplicity) in f.roots(QQbar)]
        assert len(roots) == n
        assert len(set(roots)) == n

        g = f
        for k in range(n + 1, n + 4):
            assert g[k] == f[k]
            assert f[k] == (t^n)[k] + R(-1)[k]
            assert (t^n)[k] + R(-1)[k] == 0 + 0
            assert 0 + 0 == 0
        assert g[n] == f[n]
        assert f[n] == (t^n)[n] + R(-1)[n]
        assert (t^n)[n] + R(-1)[n] == 1 + 0
        assert 1 + 0 == 1
        chosen = []
        for j in range(n + 1):
            product = linear_factor_product(chosen)
            assert f == product * g
            assert all(g[k] == 0 for k in range(n - j + 1, n + 2))
            assert g[n - j] == 1
            assert all(w^n == 1 for w in chosen)
            assert len(set(chosen)) == j

            if j == n:
                continue

            # 根を現在の商から取る。既出根の除外で相異性を先取りしない。
            new_root = g.roots(QQbar)[0][0]
            assert g(new_root) == 0
            m = n - j
            quotient, remainder = g.quo_rem(t - new_root)
            assert remainder == 0
            assert g == (t - new_root) * quotient
            assert all(quotient[k] == 0 for k in range(m, n + 3))
            assert 1 == g[m]
            assert g[m] == ((t - new_root) * quotient)[m]
            assert ((t - new_root) * quotient)[m] == quotient[m - 1]
            assert quotient[n - (j + 1)] == 1
            assert f == product * g
            assert product * g == product * (t - new_root) * quotient
            assert product * (t - new_root) * quotient == linear_factor_product(chosen + [new_root]) * quotient
            assert f(new_root) == (product * (t - new_root) * quotient)(new_root)
            assert (product * (t - new_root) * quotient)(new_root) == 0
            assert 0 == f(new_root)
            assert f(new_root) == new_root^n + (-1)
            assert new_root^n == 1
            assert new_root not in chosen

            # 本文の修復した相異性の段をそのまま確かめる。
            # 既出の各根を先頭へ取り出した残り B と現在の商 g から h = B g を作る。
            for i in range(j):
                remaining = chosen[:i] + chosen[i + 1:]
                B = linear_factor_product(remaining)
                assert product == (t - chosen[i]) * B
                assert all(B[l] == 0 for l in range(j, j + 3))

                h = B * g
                assert f == product * g
                assert product * g == ((t - chosen[i]) * B) * g
                assert ((t - chosen[i]) * B) * g == (t - chosen[i]) * (B * g)
                assert (t - chosen[i]) * (B * g) == (t - chosen[i]) * h
                assert f == (t - chosen[i]) * h
                for k in range(n, n + 3):
                    assert h[k] == (B * g)[k]
                    assert (B * g)[k] == 0
                assert all(h[k] == 0 for k in range(n, n + 3))
                assert new_root != chosen[i]

            quotient, remainder = g.quo_rem(t - new_root)
            assert remainder == 0
            assert g == (t - new_root) * quotient
            chosen.append(new_root)
            g = quotient

        print(f"n={n}: j=0,...,{n} の分解・係数上界・先頭係数・根の所属・相異性が通過")

    print("すべて通過")


main()
