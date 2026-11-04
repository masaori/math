# 対象ラベル: Z_equals_trace_of_W
# 共通の準備。
# - 行列の冪は本文 def_exp (1) の X^0 := I、X^{m+1} := X^m X をそのまま再帰で組む（power_by_definition）。
#   Sage 組み込みの X^m とも一致することを確かめ、独立な経路として使う。
# - 一般の行列は、成分を QQ 上の多項式環の不定元に置いたもの（generic_matrix）と、
#   QQ(i) の乱数行列（種を固定。random_matrix_QQi）の二通りで取る。不定元で成り立つ等号は
#   成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
# - 本文の V_1, V_2, B = V_1^{1/2} は ../../_shared/row_configurations.sage の成分の式と
#   スペクトル射影で、exp(K_1/2) と exp(K_2) を不定元 q, r に置いた QQ(q,r) で厳密に組む。
# 浮動小数点と RR / CC への脱出はない。
load("../../_shared/row_configurations.sage")

KI = QuadraticField(-1, 'i')


def power_by_definition(X, m):
    """def_exp (1): X^0 := I、X^{m+1} := X^m X。"""
    if m == 0:
        return identity_matrix(X.base_ring(), X.nrows())
    return power_by_definition(X, m - 1) * X


def generic_matrix(R, names):
    """names の不定元を行優先に並べた正方行列（R は多項式環）。"""
    s = ZZ(len(names)).sqrt()
    return matrix(R, s, s, [R(v) for v in names])


def generic_ring(prefixes, s):
    names = [f"{p}_{a}_{b}" for p in prefixes for a in range(1, s + 1) for b in range(1, s + 1)]
    R = PolynomialRing(QQ, names)
    out = {}
    for p in prefixes:
        out[p] = generic_matrix(R, [f"{p}_{a}_{b}" for a in range(1, s + 1) for b in range(1, s + 1)])
    return R, out


def random_matrix_QQi(s, seed):
    set_random_seed(seed)
    return matrix(KI, s, s, [KI(QQ.random_element(num_bound=5, den_bound=4))
                             + KI.gen() * QQ.random_element(num_bound=5, den_bound=4)
                             for _ in range(s * s)])


def generic_families():
    """(説明, 行列の辞書を返す関数) の並び。不定元は s = 1, 2、乱数は s = 3, 4。"""
    fams = []
    for s in (1, 2):
        fams.append((f"不定元 s={s}", lambda prefixes, s=s: generic_ring(prefixes, s)[1]))
    for s in (3, 4):
        fams.append((f"QQ(i) 乱数 s={s}",
                     lambda prefixes, s=s: {p: random_matrix_QQi(s, 1000 * s + j) for j, p in enumerate(prefixes)}))
    return fams


QR = Frac(PolynomialRing(QQ, ['q', 'r']))
q_, r_ = QR.gens()


def body_matrices(M_col):
    """本文の B := V_1^{1/2} = exp((1/2)K_1D)、V_1、V_2 を QQ(q,r) で返す（q := exp(K_1/2)、r := exp(K_2)）。
       D := Σ_m σ_m^z σ_{m+1}^z（σ_{M_col+1}^z := σ_1^z）は site_pauli のクロネッカー積から組む。
       B は D のスペクトル射影で exp((1/2)K_1 λ) = q^λ として、V_1・V_2 は def_transfer_matrix の成分の式で
       exp(K_1 n) = q^{2n}、exp(K_2 n) = r^n として組む（V_1 は B を経由しない別経路）。"""
    D = sum(site_pauli('z', m, M_col) * site_pauli('z', m % M_col + 1, M_col) for m in range(1, M_col + 1))
    B = exp_by_spectral_projectors(D, lambda lam: q_ ** lam, QR)
    V1 = V1_by_components(M_col, lambda n: q_ ** (2 * n), QR)
    V2 = V2_by_components(M_col, lambda n: r_ ** n, QR)
    return B, V1, V2
