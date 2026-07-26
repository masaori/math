# =============================================================
# 共通定義ファイル (sagemath/_shared/spin_ops.sage)
#
# Mat(2,C)^{otimes M} 上の演算子 Z_m, Y_m, H_1^{(pm)}, H_2, hatZ_mu^{(pm)}, hatY_mu を
# 明示的な複素行列（CDF）として構成する。
#
# 対応する structured-latex の定義:
#   - sigma^x, sigma^y, sigma^z, sigma_k^a          : 004_transfer_matrix.mjs（転送行列の記号の定義）
#   - Z_m := sigma_1^x ... sigma_{m-1}^x sigma_m^z   : 同上
#   - Y_m := sigma_1^x ... sigma_{m-1}^x sigma_m^y   : 同上
#   - H_1^{(pm)} := Y_1 Z_2 + ... + Y_{M-1} Z_M -+ Y_M Z_1 : 同上（H1_H2 の定義）
#   - H_2 := Z_1 Y_1 + ... + Z_M Y_M                : 同上
#   - hatZ_mu^{(pm)} := -+ Z_1 e^{-i 2 pi mu/M} + sum_{j=2}^M Z_j e^{-i 2 pi j mu/M} : def_hatZ_hatY
#   - hatY_mu        := sum_{j=1}^M Y_j e^{-i 2 pi j mu/M}                          : def_hatZ_hatY
#
# 符号の規約: sgn = +1 が上付き (+)、sgn = -1 が上付き (-) に対応する。
#   H_1^{(pm)} の最終項は -+ Y_M Z_1 なので、コード上は -sgn * Y_M Z_1。
#   hatZ_mu^{(pm)} の j=1 項は -+ Z_1 e^{-i theta} なので、コード上は -sgn * Z_1 * e^{-i theta}。
#
# 使い方:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '../_shared/spin_ops.sage'))
#   O = SpinOps(4)
#   O.Zhat(2, -1)   # hatZ_2^{(-)}
# =============================================================

# ---------------------------------------------------------
# パウリ行列（structured-latex の sigma^x, sigma^y, sigma^z）
# ---------------------------------------------------------
_SIGMA_X = matrix(CDF, [[0, 1], [1, 0]])
_SIGMA_Y = matrix(CDF, [[0, -I], [I, 0]])
_SIGMA_Z = matrix(CDF, [[1, 0], [0, -1]])
_ID2 = identity_matrix(CDF, 2)


def eiph(x):
    """e^{i x}（CDF スカラー）。シンボリック化を避けるため必ず CDF で返す。"""
    return CDF(exp(CDF(I) * CDF(x)))


def comm(A, B):
    """交換子 [A, B] := A B - B A"""
    return A * B - B * A


def adpow(X, W, n):
    """n 重の交換子 underbrace([X,...,[X, W]...])_n = (ad_X)^n (W)。n=0 なら W そのもの。"""
    out = matrix(CDF, W)
    for _ in range(n):
        out = comm(X, out)
    return out


def opnorm(A):
    """行列の大きさ（1-ノルム）。差のノルムで一致判定に使う。"""
    return matrix(CDF, A).norm(1)


class SpinOps:
    """Mat(2,C)^{otimes M} 上の演算子系を明示行列で保持する。"""

    def __init__(self, M):
        if M < 2:
            raise ValueError("M >= 2 が必要")
        self.M = M
        self.d = 2 ** M
        self.SX = [None] + [self._site(_SIGMA_X, k) for k in range(1, M + 1)]
        self.SY = [None] + [self._site(_SIGMA_Y, k) for k in range(1, M + 1)]
        self.SZ = [None] + [self._site(_SIGMA_Z, k) for k in range(1, M + 1)]
        # Z_m := sigma_1^x ... sigma_{m-1}^x sigma_m^z,  Y_m := sigma_1^x ... sigma_{m-1}^x sigma_m^y
        self.Z = [None] + [self._x_prefix(m) * self.SZ[m] for m in range(1, M + 1)]
        self.Y = [None] + [self._x_prefix(m) * self.SY[m] for m in range(1, M + 1)]
        # H_2 := Z_1 Y_1 + ... + Z_M Y_M
        self.H2 = sum([self.Z[m] * self.Y[m] for m in range(1, M + 1)],
                      matrix(CDF, self.d, self.d, 0))

    def _site(self, op, k):
        """sigma_k^a = I ⊗ ... ⊗ (k 番目に op) ⊗ ... ⊗ I"""
        out = matrix(CDF, [[1]])
        for j in range(1, self.M + 1):
            out = out.tensor_product(op if j == k else _ID2)
        return out

    def _x_prefix(self, m):
        """sigma_1^x ... sigma_{m-1}^x（m=1 なら単位元）"""
        out = identity_matrix(CDF, self.d)
        for j in range(1, m):
            out = out * self.SX[j]
        return out

    def H1(self, sgn):
        """H_1^{(pm)} := Y_1 Z_2 + ... + Y_{M-1} Z_M -+ Y_M Z_1"""
        out = matrix(CDF, self.d, self.d, 0)
        for j in range(1, self.M):
            out += self.Y[j] * self.Z[j + 1]
        out += -sgn * (self.Y[self.M] * self.Z[1])
        return out

    def theta(self, mu):
        """theta_mu := 2 pi mu / M"""
        return CDF(2 * pi * mu / self.M)

    def Zhat(self, mu, sgn):
        """hatZ_mu^{(pm)} := -+ Z_1 e^{-i theta_mu} + sum_{j=2}^M Z_j e^{-i j theta_mu}"""
        t = self.theta(mu)
        out = -sgn * self.Z[1] * eiph(-t)
        for j in range(2, self.M + 1):
            out = out + self.Z[j] * eiph(-j * t)
        return matrix(CDF, out)

    def Yhat(self, mu):
        """hatY_mu := sum_{j=1}^M Y_j e^{-i j theta_mu}"""
        t = self.theta(mu)
        out = matrix(CDF, self.d, self.d, 0)
        for j in range(1, self.M + 1):
            out = out + self.Y[j] * eiph(-j * t)
        return matrix(CDF, out)

    def mu_range(self):
        """calM := {-M, ..., -1, 1, ..., M}"""
        return [m for m in range(-self.M, self.M + 1) if m != 0]


# ---------------------------------------------------------
# 双対結合定数 K_2^* := -1/2 log(tanh K_2)（_shared/defs.sage と同じ定義）
# ---------------------------------------------------------
def K_star(K):
    return RDF(-log(tanh(RDF(K))) / 2)


# ---------------------------------------------------------
# テスト用パラメータ
# ---------------------------------------------------------
SPIN_TEST_M = [3, 4, 5]
SPIN_TEST_PARAMS = [
    {'K1': 0.4, 'K2': 0.8},
    {'K1': 1.2, 'K2': 0.3},
    {'K1': 0.4407, 'K2': 0.4407},   # 臨界点上（等方的）
    {'K1': 0.05, 'K2': 0.1},        # 高温極限付近
]
SPIN_TOLERANCE = 1e-9


def report(label, worst, tol=None):
    """最大残差 worst を tol と比較して PASS/FAIL を出力する。"""
    if tol is None:
        tol = SPIN_TOLERANCE
    ok = worst <= tol
    print(f"  {label}: max residual = {worst:.3e}  ->  {'PASS' if ok else 'FAIL'}")
    return ok
