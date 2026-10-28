from itertools import permutations, product
from pathlib import Path

check_dir = Path('sagemath/check/mode-small-matrix-forbidden-term').resolve()
for name in ('check_selected_entry.sage', 'check_zero_factor.sage', 'check_product_zero.sage'):
    load(str(check_dir / name))

# 対象ラベル: claim_opposite_direction_permutation_term_zero
# 逆方向の列を選ぶ置換項は、その成分を零因子に持つ。
R = PolynomialRing(QQbar, 'x')
x = R.gen()
z = QQbar.zeta(8)

def mode_matrix(varpi, varsigma):
    return matrix(QQbar, [
        [varpi, z * varsigma, 0, z**(-1) * varsigma**(-1)],
        [z**(-1) * varpi, varsigma, z * varpi**(-1), 0],
        [0, z**(-1) * varsigma, varpi**(-1), z * varsigma**(-1)],
        [z * varpi, 0, z**(-1) * varpi**(-1), varsigma**(-1)],
    ])

all_permutations = list(permutations(range(4)))
for L in range(1, 4):
    root = QQbar.zeta(2 * L)
    for a, b in product(range(2), repeat=2):
        horizontal = [root**k for k in range(2 * L) if root**(k * L) == (-1)**a]
        vertical = [root**k for k in range(2 * L) if root**(k * L) == (-1)**b]
        for varpi, varsigma in product(horizontal, vertical):
            A = identity_matrix(R, 4) - x * mode_matrix(varpi, varsigma).change_ring(R)
            for sigma in all_permutations:
                for i in range(4):
                    if sigma[i] == (i + 2) % 4:
                        check_selected_entry(A, sigma, i)
                        check_zero_factor(A, x, i)
                        check_product_zero(A, sigma)

assert sum(all(sigma[i] != (i + 2) % 4 for i in range(4))
           for sigma in all_permutations) == 9
print('PASS: opposite-direction factors vanish for all modes with L=1,2,3')
