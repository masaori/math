# ---------------------------------------------------------
# 161 用の補助関数（この check ディレクトリ専用）。
#
# 「1 サイトだけ反可換、他は可換」という仮定を満たす 2x2 行列の組をランダムに作る。
#
# 事実: A = n_x sigma^x + n_y sigma^y + n_z sigma^z（トレース 0）に対し
#         [A, B]_+ = 2 (n . m) I    （B = m . sigma、n . m は共役を取らない双線型形式）
#       であるから、n . m = 0 なる複素ベクトルの組を取れば A, B は反可換になる。
#       この事実そのものも check_01 の中で数値的に確かめる（仮定の作り方の妥当性検査）。
#
# 可換な組は「y_i = alpha I + beta x_i」（x_i の多項式）として作る。
# ---------------------------------------------------------
import numpy as _np161

_IU161 = complex(0.0, 1.0)
_S161 = {
    'x': _np161.array([[0, 1], [1, 0]], dtype=complex),
    'y': _np161.array([[0, -_IU161], [_IU161, 0]], dtype=complex),
    'z': _np161.array([[1, 0], [0, -1]], dtype=complex),
}
_I161 = _np161.eye(2, dtype=complex)


def rand_cvec(rng, n=3):
    """成分が複素数のランダムなベクトル。"""
    return rng.normal(size=n) + 1j * rng.normal(size=n)


def vec_to_mat(v):
    """n . sigma（トレース 0 の 2x2 行列）。"""
    return v[0] * _S161['x'] + v[1] * _S161['y'] + v[2] * _S161['z']


def rand_anticommuting_pair(rng):
    """反可換な 2x2 行列の組 (A, B) をランダムに作る。両方ともトレース 0。"""
    for _ in range(100):
        n = rand_cvec(rng)
        nn = complex(_np161.dot(n, n))
        if abs(nn) < 1e-3:
            continue
        u = rand_cvec(rng)
        m = u - (complex(_np161.dot(n, u)) / nn) * n     # n . m = 0 となるよう射影
        if float(_np161.max(_np161.abs(m))) < 1e-3:
            continue
        return vec_to_mat(n), vec_to_mat(m)
    raise RuntimeError("反可換な組を作れなかった")


def rand_commuting_pair(rng):
    """可換な 2x2 行列の組 (A, B) をランダムに作る（B は A の 1 次式）。"""
    a = (rng.normal(size=(2, 2)) + 1j * rng.normal(size=(2, 2)))
    alpha = complex(rng.normal() + 1j * rng.normal())
    beta = complex(rng.normal() + 1j * rng.normal())
    return a, alpha * _I161 + beta * a
