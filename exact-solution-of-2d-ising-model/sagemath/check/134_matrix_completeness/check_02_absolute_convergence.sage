# ---------------------------------------------------------
# <matrix_completeness> (2) 絶対収束判定:
#   Σ_{m} ‖B_m‖ が収束するなら Σ_m B_m は収束し、‖Σ B_m‖ ≤ Σ ‖B_m‖。
#
# 検査するもの:
#   (a) 部分和 S_N の Cauchy 性が、実数級数の尾 Σ_{m>N0} ‖B_m‖ で抑えられること
#         ‖S_N − S_M‖ ≤ Σ_{m=min+1}^{max} ‖B_m‖ ≤ Σ_{m>N0} ‖B_m‖
#       これは本文の証明が使っている評価そのもの。
#   (b) 極限が存在し、独立に計算できる閉形式と一致すること（等比型の族を使う）。
#   (c) ‖Σ B_m‖ ≤ Σ ‖B_m‖（等号に近づく族 B_m = r^m C, r>0 実も入れる）。
#   (d) 判定は十分条件であって必要条件ではないこと（Σ‖B_m‖ が発散しても
#       Σ B_m が収束する例）。本文は「ならば」しか主張していないので反例ではない。
#
# 対象: structured-latex matrix_completeness
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_completeness (2) 絶対収束判定")

n = 4
C = rand_mat(n, 14001, 1.0)
NMAX = 600

families = []
# 等比型: B_m = r^m C（閉形式 Σ = C/(1−r)）
for r in [0.5, 0.9, -0.4, 0.5 + 0.4j]:
    families.append(("B_m = (%s)^m C" % (r,),
                     [(r ** m) * C for m in range(NMAX + 1)],
                     C / (1.0 - r)))
# 指数型: B_m = A^m/m!（閉形式 Σ = exp(A)、scipy の expm という独立経路）
A = 0.7 * rand_mat(n, 14002, 1.0)
terms = []
T = np.eye(n, dtype=complex)
terms.append(T.copy())
for m in range(1, 121):
    T = (T @ A) / float(m)
    terms.append(T.copy())
families.append(("B_m = A^m/m!", terms, _expm(A)))
# 階乗型: B_m = C/m!（Σ = e·C。e は numpy.exp(1) という独立経路）
fact_terms = []
f = 1.0
for m in range(0, 61):
    if m > 0:
        f = f * float(m)
    fact_terms.append(C / f)
families.append(("B_m = C/m!", fact_terms, C * float(np.exp(1.0))))

for name, Bs, S_closed in families:
    norms = [fro(B) for B in Bs]
    total = sum(norms)
    # 部分和
    S = np.zeros((n, n), dtype=complex)
    partial = [S.copy()]
    for B in Bs:
        S = S + B
        partial.append(S.copy())

    # (a) Cauchy 性の評価
    for N0 in [0, 5, 20, 60]:
        tail = sum(norms[N0 + 1:])
        worst = 0.0
        for N in range(N0, min(N0 + 30, len(partial) - 1)):
            for M2 in range(N0, min(N0 + 30, len(partial) - 1)):
                worst = max(worst, fro(partial[N + 1] - partial[M2 + 1]))
        rep.truth(le_ok(worst, tail),
                  "(2)(a) ‖S_N−S_M‖ ≤ Σ_{m>N0}‖B_m‖ (%s, N0=%d)" % (name, N0))

    # (b) 極限と閉形式の一致（独立経路）
    rep.close(partial[-1], S_closed, "(2)(b) Σ B_m = 閉形式 (%s)" % name)

    # (c) ノルム不等式
    rep.truth(le_ok(fro(partial[-1]), total),
              "(2)(c) ‖ΣB_m‖ ≤ Σ‖B_m‖ (%s: %.6e ≤ %.6e)" % (name, fro(partial[-1]), total))
    # 全ての部分和についても
    for N in [0, 1, 5, 20, len(partial) - 1]:
        rep.truth(le_ok(fro(partial[N]), sum(norms[:N])),
                  "(2)(c) ‖S_N‖ ≤ Σ_{m<N}‖B_m‖ (%s, N=%d)" % (name, N))
    print("%-24s: ‖ΣB_m‖ = %.6e, Σ‖B_m‖ = %.6e, 比 = %.6f, 閉形式との差 = %.3e"
          % (name, fro(partial[-1]), total, fro(partial[-1]) / total,
             fro(partial[-1] - S_closed)))

# 遅く収束する族 B_m = C/(m+1)^2（Σ‖B_m‖ = ‖C‖π^2/6 で収束）についても、
# 部分和の Cauchy 性が実数級数の尾で抑えられることを確認する（閉形式との比較はしない：
# 20 万項でも打ち切り誤差が 5e-6 残り、倍精度では 1e-9 まで詰められないため）。
Bs = [C / float((m + 1) ** 2) for m in range(20001)]
norms = [fro(B) for B in Bs]
S = np.zeros((n, n), dtype=complex)
partial = [S.copy()]
for B in Bs:
    S = S + B
    partial.append(S.copy())
rep.truth(le_ok(sum(norms), fro(C) * float(np.pi ** 2 / 6.0)),
          "(2) 遅い族: Σ‖B_m‖ ≤ ‖C‖π^2/6（%.6f ≤ %.6f）"
          % (sum(norms), fro(C) * float(np.pi ** 2 / 6.0)))
for N0 in [0, 10, 100, 1000]:
    tail = sum(norms[N0 + 1:])
    worst = max(fro(partial[N + 1] - partial[N0 + 1])
                for N in range(N0, min(N0 + 200, len(Bs))))
    rep.truth(le_ok(worst, tail), "(2) 遅い族の Cauchy 性 (N0=%d)" % N0)

# (c) 等号に近づく族: B_m = r^m C（r>0 実）では ‖ΣB_m‖ = Σ‖B_m‖ ちょうど
for r in [0.5, 0.8, 0.95]:
    Bs = [(r ** m) * C for m in range(NMAX + 1)]
    S = sum(Bs)
    total = sum(fro(B) for B in Bs)
    rep.close(fro(S), total, "(2)(c) 等号 B_m = r^m C, r=%g" % r)
    print("等号族 r=%g: ‖ΣB_m‖ = %.12e, Σ‖B_m‖ = %.12e" % (r, fro(S), total))

# (d) 十分条件であって必要条件ではない: Σ‖B_m‖ 発散でも ΣB_m 収束
# B_m := (-1)^m/(m+1) · C。Σ‖B_m‖ = ‖C‖ Σ 1/(m+1) は発散するが、
# Σ B_m = (log 2) C（交代級数）。交代級数の剰余評価 ‖S_N − S‖ ≤ ‖C‖/(N+2) で判定する
# （倍精度で 1e-9 まで詰めるには 1e9 項必要なので、rep.close ではなく剰余評価を使う）。
NALT = 100000
S = np.zeros((n, n), dtype=complex)
total_partial = 0.0
for m in range(NALT + 1):
    B = ((-1.0) ** m / float(m + 1)) * C
    S = S + B
    total_partial += fro(B)
S_closed = float(np.log(2.0)) * C
rep.truth(total_partial > 10.0,
          "(2)(d) Σ‖B_m‖ は発散する（10 万項で %.3f、調和級数）" % total_partial)
rep.truth(le_ok(fro(S - S_closed), fro(C) / float(NALT + 2)),
          "(2)(d) それでも ΣB_m は収束（交代級数の剰余評価 ‖S_N−log2·C‖ ≤ ‖C‖/(N+2)）")
print("(d) Σ‖B_m‖(10万項) = %.3f, ‖S_N − log2·C‖ = %.3e (≤ ‖C‖/(N+2) = %.3e)"
      % (total_partial, fro(S - S_closed), fro(C) / float(NALT + 2)))
print("    ⇒ 絶対収束判定は十分条件であり必要条件ではない（本文は「ならば」しか主張していない）")

rep.finish()
