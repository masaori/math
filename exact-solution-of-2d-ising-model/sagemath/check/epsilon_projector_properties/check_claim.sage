# 対象ラベル: epsilon_projector_properties
# 主張そのもの（鎖を通らず定義から直接）:
#   (1) (P^{(+)})^2 = P^{(+)}
#   (2) im P^{(+)} = F^{(+)}。P^{(+)} の列が張る空間（im P^{(+)} = {P^{(+)}x}）と εf = f の解空間が、
#       QQ 上の部分空間として一致することを確かめる。どちらも QQ 係数の行列で定まるので、ℂ 上でも一致する
#       （QQ 上の基底は ℂ 上でも一次独立で、階数は係数体を広げても変わらない）。
#   対照として、(1/2)(I - ε) の像は F^{(+)} と一致しない（共通部分は零）ことも見る。
# 帰属: Mat(2^M, QQ)。
load("_prelude.sage")

for M in M_COL_RANGE:
    E, P = projector(M)
    n = 2 ** M
    I = identity_matrix(QQ, n)
    assert P * P == P
    image = P.column_space()
    fixed = (E - I).right_kernel()
    assert image == fixed
    assert image.dimension() == 2 ** (M - 1)
    other = ((I - E) / 2).column_space()
    assert other != fixed and other.intersection(fixed).dimension() == 0
    print(f"  M_col={M}: P^2 = P、im P = F^(+)（次元 {image.dimension()}）、(1/2)(I-ε) の像は F^(+) と交わらない")

print("RESULT: PASS")
