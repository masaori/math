# ---------------------------------------------------------
# SageMath: hatY への作用の「行ベクトル × 列ベクトル」表示
#
# 主張（修正後）:
#   T_{(V_1)^{1/2}}(hatY_mu) = (hatZ_mu^{(-)}, hatY_mu) ( -i e^{ i theta} sinh K_1 ; cosh K_1 )
#   T_{V_2}(hatY_mu)         = (hatZ_mu^{(-)}, hatY_mu) (  i sinh 2K_2^*        ; cosh 2K_2^* )
#
# 原文 statement の hat(Y) 行列表示は第 1 成分が「 i e^{-i theta} sinh K_1 」であり、
# 同じ原文の scalar 表示「 -i e^{i theta} sinh(K_1) hatZ + cosh(K_1) hatY 」と符号・exp が
# 食い違っていた（誤植）。ここでは
#   (1) 修正後の列ベクトル表示が成り立つこと
#   (2) 原文の列ベクトル表示は成り立たないこと
# の両方を数値的に確定させる。
#
# 注意: 2 つの列ベクトルの差は
#   (i e^{-iθ} - (-i e^{iθ})) sinh(K1) hatZ = 2 i cos(θ) sinh(K1) hatZ
# なので、cos(theta_mu) = 0 となる mu（例: M=4 の mu = ±1, ±3）では両者がたまたま一致する。
# よって (2) の判定は「すべての mu で不一致」ではなく「ある mu で不一致」で行う。
#
# 対象: structured-latex ホロノミック量子場_p142下段_1
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

MISMATCH_FLOOR = 1e-3

print("=== hatY への作用の列ベクトル表示（修正後 vs 原文）===")
all_ok = True
for M in SPIN_TEST_M:
    O = SpinOps(M)
    for params in SPIN_TEST_PARAMS:
        K1v = RDF(params['K1'])
        K2s = K_star(params['K2'])
        A1 = CDF(I) / 2 * K1v * O.H1(-1)
        A2 = CDF(I) * K2s * O.H2
        E1, E1inv = matrix(CDF, A1.exp()), matrix(CDF, (-A1).exp())
        E2, E2inv = matrix(CDF, A2.exp()), matrix(CDF, (-A2).exp())
        fixed_worst = {'V1': 0.0, 'V2': 0.0}
        typo_max = 0.0
        typo_degenerate = []   # 両者が一致してしまう mu（cos theta_mu = 0）
        for mu in O.mu_range():
            t = O.theta(mu)
            Zm = O.Zhat(mu, -1)
            Yh = O.Yhat(mu)
            sh1, ch1 = CDF(sinh(K1v)), CDF(cosh(K1v))
            sh2, ch2 = CDF(sinh(2 * K2s)), CDF(cosh(2 * K2s))
            lhs1 = E1 * Yh * E1inv
            lhs2 = E2 * Yh * E2inv
            # (hatZ, hatY) col = col[0] * hatZ + col[1] * hatY
            fixed1 = (-CDF(I) * eiph(t) * sh1) * Zm + ch1 * Yh
            fixed2 = (CDF(I) * sh2) * Zm + ch2 * Yh
            typo1 = (CDF(I) * eiph(-t) * sh1) * Zm + ch1 * Yh   # 原文の列ベクトル表示
            fixed_worst['V1'] = max(fixed_worst['V1'], opnorm(lhs1 - fixed1))
            fixed_worst['V2'] = max(fixed_worst['V2'], opnorm(lhs2 - fixed2))
            res = opnorm(lhs1 - typo1)
            typo_max = max(typo_max, res)
            if res < MISMATCH_FLOOR:
                typo_degenerate.append(mu)
        print(f"M = {M}, K1 = {params['K1']}, K2 = {params['K2']} (K2* = {float(K2s):.6f}):")
        all_ok = report("T_{(V1)^{1/2}}(hatY) 修正後列ベクトル", fixed_worst['V1'], tol=1e-8) and all_ok
        all_ok = report("T_{V2}(hatY) 列ベクトル", fixed_worst['V2'], tol=1e-8) and all_ok
        # 2 つの列ベクトルの差は (i e^{-iθ} - (-i e^{iθ})) sinh(K1) hatZ = 2 i cos(θ) sinh(K1) hatZ
        # なので、cos(theta_mu) = 0 となる mu では両者が一致してしまう（M=4 の mu = ±1, ±3 など）。
        # したがって「すべての mu で不一致」ではなく「ある mu で不一致」を判定条件にする。
        ok = typo_max >= MISMATCH_FLOOR
        print(f"  T_{{(V1)^{{1/2}}}}(hatY) 原文列ベクトル（0 でないはず）: "
              f"max residual = {typo_max:.3e}  ->  {'PASS（不一致を確認）' if ok else 'FAIL'}")
        if typo_degenerate:
            print(f"    （両者が一致する mu = {typo_degenerate}: cos(theta_mu) = 0 のため。"
                  f"これは不一致の反例にならない）")
        all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
