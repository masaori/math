"""巻き付き偶奇の対称差加法性を厳密検査する。

対象: claim_winding_parity_symmetric_difference_additivity。

一辺 L=2 の全ての辺集合対 (X, Y) について、
eps_h(X △ Y) ≡ eps_h(X) + eps_h(Y) (mod 2) と
eps_v(X △ Y) ≡ eps_v(X) + eps_v(Y) (mod 2) を検査する。
計算は有限集合と ZZ の合同だけで行い、浮動小数点は使わない。
"""

L = 2

edges = [(kind, i, j) for kind in ("h", "v") for i in range(L) for j in range(L)]
subsets = [frozenset(subset) for subset in Subsets(set(edges))]


def winding_parities(subset):
    return (
        sum(ZZ(kind == "h" and j == L - 1) for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == L - 1) for kind, i, j in subset) % 2,
    )


checked = 0
for first in subsets:
    first_h, first_v = winding_parities(first)
    for second in subsets:
        second_h, second_v = winding_parities(second)
        symmetric_h, symmetric_v = winding_parities(first.symmetric_difference(second))
        assert symmetric_h == (first_h + second_h) % 2
        assert symmetric_v == (first_v + second_v) % 2
        checked += 1

assert len(subsets) == 2 ** (2 * L * L)
assert checked == len(subsets) ** 2
print(f"PASS: winding-parity-symmetric-difference-additivity "
      f"(L={L}, pairs={checked})")
