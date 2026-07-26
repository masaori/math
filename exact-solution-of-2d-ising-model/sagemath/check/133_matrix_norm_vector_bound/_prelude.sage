# ---------------------------------------------------------
# _prelude.sage — 行列ノルム・指数関数・ad の検証（check 130〜146）の共通補助。
#
# `sagemath/_shared/` は編集禁止なので、各 check ディレクトリに同一内容で置いてある。
# 使う前に `_shared/operators.sage` を load しておくこと（hatZ_op 等をここで使う）。
#
# 方針:
#   - ノルムは <def_matrix_norm> の Frobenius ノルム。
#     numpy.linalg.norm（既定）と、定義どおりの二重ループと、tr(A^* A) の 3 経路を用意し、
#     「定義の写し間違い」自体を検出できるようにする。
#   - 試験行列には乱数だけでなく、退化した行列（零・冪零・ランク1・非対角化可能）と
#     Ising 側の実際の作用素（臨界点近傍のパラメータを含む）を混ぜる。
# ---------------------------------------------------------
import numpy as _np


def as_mat(A):
    return _np.asarray(A, dtype=complex)


def fro(A):
    """<def_matrix_norm> の Frobenius ノルム（numpy 経路）。"""
    return float(_np.linalg.norm(as_mat(A)))


def fro_naive(A):
    """定義そのまま Σ_{i,j}|a_ij|^2 の平方根を素の二重ループで計算する独立経路。"""
    A = as_mat(A)
    s = 0.0
    for i in range(A.shape[0]):
        for j in range(A.shape[1] if A.ndim == 2 else 1):
            s += float(abs(A[i, j] if A.ndim == 2 else A[i]) ** 2)
    return float(_np.sqrt(s))


def fro_trace(A):
    """tr(A^* A) の平方根として計算する独立経路（<def_frobenius_inner_product> の経路）。"""
    A = as_mat(A)
    return float(_np.sqrt(abs(_np.trace(A.conj().T @ A))))


def fro_svd(A):
    """特異値の平方和の平方根として計算する独立経路。"""
    A = as_mat(A)
    s = _np.linalg.svd(A, compute_uv=False)
    return float(_np.sqrt(float(_np.sum(s ** 2))))


def vec_norm(w):
    """K^d のノルム（<def_matrix_norm>）。"""
    w = _np.asarray(w, dtype=complex)
    return float(_np.sqrt(float(_np.sum(_np.abs(w) ** 2))))


def rand_mat(n, seed, scale=1.0):
    g = _np.random.default_rng(int(seed))
    n = int(n)
    return float(scale) * (g.standard_normal((n, n)) + 1j * g.standard_normal((n, n)))


def rand_vec(n, seed, scale=1.0):
    g = _np.random.default_rng(int(seed))
    n = int(n)
    return float(scale) * (g.standard_normal(n) + 1j * g.standard_normal(n))


def degenerate_matrices():
    """退化した（一番危ない）行列たち。"""
    out = []
    out.append(("零行列 4x4", _np.zeros((4, 4), dtype=complex)))
    out.append(("単位行列 4x4", _np.eye(4, dtype=complex)))
    out.append(("冪零 Jordan 4x4", _np.diag(_np.ones(3, dtype=complex), 1)))
    u = _np.array([1.0, 2.0, -1.0, 0.5], dtype=complex)
    v = _np.array([0.3, -1.0, 2.0, 1.0j], dtype=complex)
    out.append(("ランク 1 4x4", _np.outer(u, v.conj())))
    out.append(("非対角化可能 2x2", _np.array([[1.0, 1.0], [0.0, 1.0]], dtype=complex)))
    out.append(("重根 3x3 Jordan", _np.array([[2.0, 1.0, 0.0],
                                              [0.0, 2.0, 1.0],
                                              [0.0, 0.0, 2.0]], dtype=complex)))
    return out


def ising_matrices(Ms=(2, 3)):
    """Ising 側の実際の作用素。臨界点近傍のパラメータ（OP_TEST_PARAMS）を含む。"""
    out = []
    for M in Ms:
        M = int(M)
        out.append(("hatZ^(-)_1 (M=%d)" % M, hatZ_op(1, M, '-')))
        out.append(("hatY_1 (M=%d)" % M, hatY_op(1, M)))
        out.append(("H_1^(-) (M=%d)" % M, H1_op(M, '-')))
        out.append(("H_2 (M=%d)" % M, H2_op(M)))
        for p in OP_TEST_PARAMS:
            tag = "M=%d,K1=%g,K2=%g" % (M, p['K1'], p['K2'])
            out.append(("i K_1 H_1^(-) [%s]" % tag,
                        1j * float(p['K1']) * H1_op(M, '-')))
            out.append(("i K_2^* H_2 [%s]" % tag,
                        1j * float(K_star(p['K2'])) * H2_op(M)))
            out.append(("V_1 [%s]" % tag, V1_op(float(p['K1']), M)))
    return out


def test_matrices(n_random=6, n=4, scale=1.0, seed0=1000, with_ising=True):
    """乱数 + 退化行列 (+ Ising 作用素) の (名前, 行列) リスト。"""
    out = [("乱数 %dx%d #%d" % (int(n), int(n), k), rand_mat(n, seed0 + k, scale))
           for k in range(int(n_random))]
    out += degenerate_matrices()
    if with_ising:
        out += ising_matrices()
    return out


def le_ok(x, y, slack=1e-12):
    """x <= y を、両辺のスケールに対する相対 slack を許して判定する。

    倍精度の丸めで「厳密には成り立つ不等式」が 1e-16 程度破れることがあるため、
    不等式の検証では等号ぎりぎりを許容する。slack を超える破れは FAIL にする。
    """
    x = float(x)
    y = float(y)
    return x <= y + float(slack) * max(1.0, abs(x), abs(y))


def E_real_partial(a, N):
    """E_N(a) = Σ_{m=0}^{N} a^m/m!（<real_exp_series_converges>）を素朴に足す。"""
    a = float(a)
    term = 1.0
    s = 1.0
    for m in range(1, int(N) + 1):
        term = term * a / float(m)
        s += term
    return s


def exp_series(A, N):
    """S_N(A) = Σ_{m=0}^{N} A^m/m!（<matrix_exp_series_converges>）。"""
    A = as_mat(A)
    n = A.shape[0]
    term = _np.eye(n, dtype=complex)
    s = term.copy()
    for m in range(1, int(N) + 1):
        term = (term @ A) / float(m)
        s = s + term
    return s


def ad_matrix(X):
    """ad_X を Mat(n,C) ≅ C^{n^2} 上の n^2 × n^2 行列として表示する。

    行優先の並べ方 vec(Y)_{i n + j} := Y_{ij} に対し
        vec(XY) = (X ⊗ I) vec(Y),   vec(YX) = (I ⊗ X^T) vec(Y)
    であるから ad_X の行列表示は kron(X, I) - kron(I, X^T)。
    （この経路は交換子の逐次計算とは独立に ad_X の指数を計算するために使う。）
    """
    X = as_mat(X)
    n = X.shape[0]
    Id = _np.eye(n, dtype=complex)
    return _np.kron(X, Id) - _np.kron(Id, X.T)


def vec_row(Y):
    return as_mat(Y).reshape(-1)


def unvec_row(y, n):
    return _np.asarray(y, dtype=complex).reshape(int(n), int(n))
