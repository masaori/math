# ---------------------------------------------------------
# <matrix_norm_submultiplicativity> の「等号に近づく場合」と「逆向きの不等式は破れる」。
#
# (a) 等号ちょうどのランク 1 の族:
#       A := u v^*,  B := v w^*  とすると AB = ‖v‖^2 u w^* なので
#       ‖AB‖ = ‖v‖^2 ‖u‖‖w‖ = (‖u‖‖v‖)(‖v‖‖w‖) = ‖A‖‖B‖。
#     すなわち劣乗法性の評価は「これ以上良くできない」。これを数値で確認する。
#
# (b) 逆向きの不等式 ‖AB‖ ≥ ‖A‖‖B‖ は破れる:
#       AB = O だが A ≠ O, B ≠ O となる（直交するランク 1 の）ペアを作る。
#     さらに、単位行列の絡む例（‖I·I‖ = √n < n = ‖I‖^2, n≥2）も示す。
#     これは主張が「等式ではなく不等式」であることの確認である。
#
# 対象: structured-latex matrix_norm_submultiplicativity
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_submultiplicativity: 等号（ランク1）と逆向き不等式の破れ")

# --- (a) 等号ちょうどのランク 1 --------------------------------------
print("[a] ランク 1 の族での比 ‖AB‖/(‖A‖‖B‖)")
for k in range(8):
    n = 2 + (k % 4)
    u = rand_vec(n, 9000 + k, 1.0)
    v = rand_vec(n, 9100 + k, 1.0)
    w = rand_vec(n, 9200 + k, 1.0)
    A = np.outer(u, v.conj())
    B = np.outer(v, w.conj())
    lhs = fro(A @ B)
    rhs = fro(A) * fro(B)
    rep.close(lhs, rhs, "[a] ランク1 等号 #%d (n=%d)" % (k, n))
    rep.truth(le_ok(lhs, rhs), "[a] 等号側でも ≤ が破れない #%d" % k)
    print("   n=%d: ‖AB‖=%.12e, ‖A‖‖B‖=%.12e, 比=%.15f" % (n, lhs, rhs, lhs / rhs))

# 冪の等号: A = u u^* / ‖u‖ とすると ‖A^m‖ = ‖A‖^m
u = rand_vec(5, 9300, 1.0)
u = u / vec_norm(u)
A = np.outer(u, u.conj())
P = np.eye(5, dtype=complex)
for m in range(1, 9):
    P = P @ A
    rep.close(fro(P), fro(A) ** m, "[a] ‖A^%d‖ = ‖A‖^%d（射影 A=uu^*）" % (m, m))

# --- (b) 逆向きの不等式は破れる ---------------------------------------
print("[b] 逆向き ‖AB‖ ≥ ‖A‖‖B‖ の反例")
# 直交するランク 1: AB = O だが A,B ≠ O
e1 = np.array([1, 0, 0, 0], dtype=complex)
e2 = np.array([0, 1, 0, 0], dtype=complex)
e3 = np.array([0, 0, 1, 0], dtype=complex)
A = np.outer(e1, e2.conj())     # e1 e2^*
B = np.outer(e3, e1.conj())     # e3 e1^*   ⇒ AB = (e2^* e3) e1 e1^* = O
rep.close(A @ B, np.zeros((4, 4), dtype=complex), "[b] AB = O")
rep.truth(fro(A) > 0 and fro(B) > 0, "[b] A ≠ O かつ B ≠ O")
rep.truth(not le_ok(fro(A) * fro(B), fro(A @ B)),
          "[b] ‖AB‖ ≥ ‖A‖‖B‖ は破れる（0 ≥ %.3f は偽）" % (fro(A) * fro(B)))
print("   AB=O の例: ‖AB‖=%.3e, ‖A‖‖B‖=%.6f" % (fro(A @ B), fro(A) * fro(B)))

# 単位行列: ‖I·I‖ = √n < n = ‖I‖^2 （n ≥ 2）
for n in [2, 4, 8, 16]:
    Id = np.eye(n, dtype=complex)
    rep.close(fro(Id @ Id), float(np.sqrt(n)), "[b] ‖I·I‖ = √n (n=%d)" % n)
    rep.close(fro(Id) * fro(Id), float(n), "[b] ‖I‖^2 = n (n=%d)" % n)
    rep.truth(fro(Id @ Id) < fro(Id) * fro(Id),
              "[b] n=%d で真の不等号 √n=%.4f < n=%d" % (n, np.sqrt(n), n))

# 冪零行列: A^2 = O だが ‖A‖ > 0
J = np.diag(np.ones(3, dtype=complex), 1)   # 4x4 冪零
rep.truth(fro(J @ J @ J @ J) == 0.0 and fro(J) > 0.0,
          "[b] 冪零 J: ‖J^4‖=0 だが ‖J‖^4=%.3f" % (fro(J) ** 4))

rep.finish()
