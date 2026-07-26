# =========================================================================
# check_02: conjugate_index_of_check_Z_Y (1)(2)(3)
#
#  (1) θ~_{M+1-μ} = 2π - θ~_μ
#  (2) e^{-i j θ~_{M+1-μ}} = e^{i j θ~_μ}   (j ∈ Z)
#  (3) Ž_{M+1-μ} = Ž_{1-μ},  Y̌_{M+1-μ} = Y̌_{1-μ}
#
#  あわせて、本文の書き換え（1-μ → M+1-μ）が値を変えないことを
#  H_1^{(+)}, H_2 の表示で直接確認する:
#      H_1^{(+)} = (1/M) Σ_μ Y̌_μ Ž_{M+1-μ} e^{-i θ~_μ} = (1/M) Σ_μ Y̌_μ Ž_{1-μ} e^{-i θ~_μ}
#      H_2       = (1/M) Σ_μ Ž_{M+1-μ} Y̌_μ         = (1/M) Σ_μ Ž_{1-μ} Y̌_μ
#
# 対象: structured-latex conjugate_index_of_check_Z_Y
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_02: 共役添字 M+1-μ ===")

ok_all = True
w1 = 0.0
w2 = 0.0
w3 = 0.0
wH = 0.0

for M in MATRIX_M:
    O = SpinOps(M)
    for mu in check_M(M):
        t = th_tilde(M, mu)
        # (1)
        w1 = max(w1, abs(float(th_tilde(M, M + 1 - mu) - (RDF(2 * pi) - t))))
        # (2)
        for j in range(-2 * M, 2 * M + 1):
            w2 = max(w2, abs(eiph(-j * th_tilde(M, M + 1 - mu)) - eiph(j * t)))
        # (3)
        w3 = max(w3, opnorm(checkZ(O, M + 1 - mu) - checkZ(O, 1 - mu)),
                 opnorm(checkY(O, M + 1 - mu) - checkY(O, 1 - mu)))
    # 書き換えが H の表示を変えないこと
    s1n = matrix(CDF, O.d, O.d, 0); s1o = matrix(CDF, O.d, O.d, 0)
    s2n = matrix(CDF, O.d, O.d, 0); s2o = matrix(CDF, O.d, O.d, 0)
    for mu in check_M(M):
        t = th_tilde(M, mu)
        s1n = s1n + checkY(O, mu) * checkZ(O, M + 1 - mu) * eiph(-t)
        s1o = s1o + checkY(O, mu) * checkZ(O, 1 - mu) * eiph(-t)
        s2n = s2n + checkZ(O, M + 1 - mu) * checkY(O, mu)
        s2o = s2o + checkZ(O, 1 - mu) * checkY(O, mu)
    wH = max(wH, opnorm(s1n / M - O.H1(+1)), opnorm(s1o / M - O.H1(+1)),
             opnorm(s2n / M - O.H2), opnorm(s2o / M - O.H2),
             opnorm(s1n - s1o), opnorm(s2n - s2o))

ok_all &= report("(1) θ~_{M+1-μ} = 2π - θ~_μ", RDF(w1), TOL)
ok_all &= report("(2) e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}", RDF(w2), TOL)
ok_all &= report("(3) Ž_{M+1-μ} = Ž_{1-μ}, Y̌_{M+1-μ} = Y̌_{1-μ}", RDF(w3), TOL)
ok_all &= report("H_1^{(+)}, H_2 の表示が書き換えで変わらない", RDF(wH), TOL)
print(f"  （M = {MATRIX_M}、j は -2M..2M）")

print("check_02:", "PASS" if ok_all else "FAIL")
