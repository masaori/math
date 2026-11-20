# 対象ラベル: claim_maximal_ordered_subfield_odd_degree_root
# 住処: 実代数的数 AA（Qbar の可算部分体）。浮動小数点を使わない。
# 本文の二つの根拠を、奇数次の代数的多項式の有限標本で確かめる。
# 極大性を満たす全ての部分体に対する量化の証明は Lean が担う。

R.<t> = PolynomialRing(AA)
s = AA(2).sqrt()
samples = [t, t^3 - 2, t^3 + s*t + 1, (t^2 + 1)*(t - s), t^5 - 3*t + s]

for f in samples:
    n = f.degree()
    assert n % 2 == 1
    assert f[n] != 0
    assert all(f[k] == 0 for k in range(n + 1, n + 4))
    roots = f.roots(AA, multiplicities=False)
    assert roots
    assert any(f(beta) == 0 and beta in AA for beta in roots)

print("PASS: 5 exact odd-degree algebraic polynomial samples")
