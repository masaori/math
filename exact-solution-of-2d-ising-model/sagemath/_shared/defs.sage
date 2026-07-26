# =============================================================
# 共通定義ファイル (sagemath/_shared/defs.sage)
#
# Typst parts/004_転送行列/000_definition_転送行列の記号の定義.typ に対応
# 各 check_*.sage ファイルから load() して使う
#
# 使い方:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '../_shared/defs.sage'))
#
#   または相対パス:
#   load('<適切な相対パス>/sagemath/_shared/defs.sage')
# =============================================================

# ---------------------------------------------------------
# 基本変数
# ---------------------------------------------------------
var('K1 K2')
var('theta_mu')

# 虚数単位 (SageMath の I)
i = I

# ---------------------------------------------------------
# 双対結合定数 K_i^*
#   K_i^* := -1/2 log(tanh K_i)
#   ⟺ sinh(K_i) sinh(K_i^*) = 1
# ---------------------------------------------------------
K1_star = -log(tanh(K1)) / 2
K2_star = -log(tanh(K2)) / 2

# ---------------------------------------------------------
# 略記号 c_i, s_i, c_i^*, s_i^*
#   c_i := cosh(2 K_i)
#   s_i := sinh(2 K_i)
#   c_i^* := cosh(2 K_i^*)
#   s_i^* := sinh(2 K_i^*)
# ---------------------------------------------------------
c_1 = cosh(2*K1)
s_1 = sinh(2*K1)
c_2 = cosh(2*K2)
s_2 = sinh(2*K2)

c_1_star = cosh(2*K1_star)
s_1_star = sinh(2*K1_star)
c_2_star = cosh(2*K2_star)
s_2_star = sinh(2*K2_star)

# ---------------------------------------------------------
# alpha_1, alpha_2
#   alpha_1 := tanh(K_1) * tanh(K_2^*)
#   alpha_2 := tanh(K_2^*) / tanh(K_1)
#   (alpha_2 = (tanh K_1)^{-1} tanh K_2^*)
# ---------------------------------------------------------
alpha_1 = tanh(K1) * tanh(K2_star)
alpha_2 = tanh(K2_star) / tanh(K1)

# ---------------------------------------------------------
# gamma_1(theta), gamma_2(theta)
#   gamma_1(theta) := c_1 c_2^* - s_1 s_2^* cos(theta)
#   gamma_2(theta) := i * e^{i theta} * s_2^* * (c_1 cos(theta) - i sin(theta) - s_1 c_2)
# ---------------------------------------------------------
def gamma_1(th):
    return c_1 * c_2_star - s_1 * s_2_star * cos(th)

def gamma_2(th):
    return i * exp(i * th) * s_2_star * (c_1 * cos(th) - i * sin(th) - s_1 * c_2)

# ---------------------------------------------------------
# A(theta) 行列
#   A(theta) := mat(gamma_1(theta), gamma_2(theta);
#                   -gamma_2(-theta), gamma_1(theta))
# ---------------------------------------------------------
def A_theta(th):
    return matrix([
        [gamma_1(th),   gamma_2(th)],
        [-gamma_2(-th), gamma_1(th)]
    ])

# ---------------------------------------------------------
# theta_mu の定義
#   theta_mu := (2 pi mu) / M
# ---------------------------------------------------------
def theta_of_mu(mu_val, M_val):
    return (2 * pi * mu_val) / M_val

# ---------------------------------------------------------
# a(theta_mu) の定義
#   a(theta_mu) := sqrt( (1 - alpha_1 e^{i theta}) / (1 - alpha_1 e^{-i theta})
#                        * (1 - alpha_2^{-1} e^{i theta}) / (1 - alpha_2^{-1} e^{-i theta}) )
# ---------------------------------------------------------
def a_theta(th):
    return sqrt_cc(
        (1 - alpha_1 * exp(i*th)) / (1 - alpha_1 * exp(-i*th))
        * (1 - (1/alpha_2) * exp(i*th)) / (1 - (1/alpha_2) * exp(-i*th))
    )

# ---------------------------------------------------------
# ヘルパー関数: arg^{[0, 2pi)}
# ---------------------------------------------------------
def arg_02pi(z):
    """arg^([0, 2pi)) の数値計算"""
    z_val = CC(z)
    if z_val == 0:
        raise ValueError("arg is undefined for 0")
    a = z_val.argument()  # (-pi, pi]
    if a < 0:
        a += 2 * RR(pi)
    return a

# ---------------------------------------------------------
# ヘルパー関数: sqrt (本プロジェクト定義)
#   偏角を [0, 2pi) で取り、半分にする
# ---------------------------------------------------------
def sqrt_cc(z):
    """本プロジェクト定義の sqrt（arg/2 ベース, arg in [0, 2pi)）"""
    z_val = CC(z)
    if z_val == 0:
        return CC(0)
    r = abs(z_val)
    a = arg_02pi(z_val)
    return CC(r.sqrt() * exp(I * a / 2))

# ---------------------------------------------------------
# テスト用パラメータセット
# ---------------------------------------------------------
DEFAULT_TEST_PARAMS = [
    {'K1': 0.4, 'K2': 0.8},
    {'K1': 1.2, 'K2': 0.3},
    {'K1': 10.4, 'K2': 1.8},
    {'K1': 0.4407, 'K2': 0.4407},   # 臨界点上（等方的）
    {'K1': 0.2, 'K2': 0.813},       # 臨界点上（非等方的）
    {'K1': 0.05, 'K2': 0.1},        # 高温極限付近
    {'K1': 0.3, 'K2': 5.0},         # 極端な非対称
]

DEFAULT_M_VAL = 100
DEFAULT_TOLERANCE = 1e-10

# ---------------------------------------------------------
# 共通の数値検証ルーチン
# ---------------------------------------------------------
def numerical_check(expr1, expr2, test_params=None, M_val=None, tol=None, label=""):
    """
    expr1 と expr2 が数値的に等しいかを検証する。
    expr1, expr2 は K1, K2, theta_mu を含むシンボリック式。

    Returns: True if all checks pass, False otherwise.
    """
    if test_params is None:
        test_params = DEFAULT_TEST_PARAMS
    if M_val is None:
        M_val = DEFAULT_M_VAL
    if tol is None:
        tol = DEFAULT_TOLERANCE

    if label:
        print(f"\n--- Numerical Verification: {label} ---")
    else:
        print("\n--- Numerical Verification ---")

    mu_list = [m for m in range(-M_val, M_val + 1) if m != 0]
    all_ok = True

    for params in test_params:
        val_K1 = params['K1']
        val_K2 = params['K2']
        print(f"Parameters: K1={val_K1}, K2={val_K2}, M={M_val}")

        for mu in mu_list:
            th = (2 * pi * mu) / M_val
            subs_dict = {K1: val_K1, K2: val_K2, theta_mu: th}
            v1 = CC(expr1.subs(subs_dict))
            v2 = CC(expr2.subs(subs_dict))
            # 絶対誤差ではなく**相対誤差**で判定する。
            # 理由: c_1 = cosh(2K_1) は K_1 = 10.4 で ~5e8 に達し、式の値が 1e3〜1e9 の
            # 桁になる。絶対誤差 1e-10 で判定すると、倍精度の丸め（相対 ~1e-16）でしかない
            # 差を「不一致」と報告してしまう（実際に 028 の check_06 がそれで FAIL していた）。
            scale = max(1.0, abs(v1), abs(v2))
            err = abs(v1 - v2) / scale
            if err > tol:
                print(f"  MISMATCH at mu={mu}: relative |expr1 - expr2| = {err}")
                print(f"    expr1 = {v1}")
                print(f"    expr2 = {v2}")
                all_ok = False

    if all_ok:
        print("RESULT: PASS")
    else:
        print("RESULT: FAIL")
        # **失敗を終了コードで伝える。**
        # これが無いと、RESULT: FAIL を出しても終了コードが 0 のままになり、
        # run-all-checks.sh が PASS と誤認する（実際にそうなっていた）。
        import sys
        sys.exit(1)

    return all_ok
