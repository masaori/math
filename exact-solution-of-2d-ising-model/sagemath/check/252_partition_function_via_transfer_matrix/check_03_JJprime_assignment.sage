# 252-03: J と J' の割り当ての訂正が正しいことの確認（反例探し）
#
# 本文 def_transfer_matrix の conversion.notes は、原文の割り当て
#   （V_1 の行内相互作用に J、V_2 の行間相互作用に J'）
# では M ≠ N のとき Z(J,J') と一致せず、Z(J',J) と一致してしまうので、
# V_1 に J'（行内、周期 N）、V_2 に J（行間、転送 M 回）と入れ替えて訂正した、と述べている。
#
# この主張そのものを検証する:
#   (a) 訂正後の割り当て … tr((V_1V_2)^M) = Z(J,J')
#   (b) 原文の割り当て   … tr((V_1V_2)^M) = Z(J',J)
#   (c) M ≠ N かつ J ≠ J' では Z(J,J') ≠ Z(J',J)（＝(a) と (b) は実際に区別できる）
# (c) が成り立たないパラメータでしか試していなければ、この check は無意味である。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("def_transfer_matrix: J/J' の割り当ての訂正（M≠N, J≠J' で識別可能）")

ASYM = [(2, 3), (3, 2), (2, 4), (4, 2), (3, 4), (4, 3)]
for (M, N) in ASYM:
    for (J, Jp) in [(0.3, 0.7), (0.1, 1.3), (1.1, 0.05), (0.2, 0.9414)]:
        Z = brute_force_Z(M, N, J, Jp)
        Zswap = brute_force_Z(M, N, Jp, J)
        tr_fixed = trace_transfer(M, N, J, Jp)          # 訂正後: V_1←J', V_2←J
        tr_orig = trace_transfer(M, N, Jp, J)           # 原文の割り当て（J と J' を入れ替えたもの）

        rep.close(tr_fixed, Z, "(a) M=%d N=%d: 訂正後 tr = Z(J,J')" % (M, N))
        rep.close(tr_orig, Zswap, "(b) M=%d N=%d: 原文の割り当て tr = Z(J',J)" % (M, N))
        sep = abs(Z - Zswap) / max(abs(Z), abs(Zswap))
        rep.truth(sep > 1e-3, "(c) M=%d N=%d J=%.3g J'=%.3g: Z(J,J') と Z(J',J) が実際に異なる"
                  % (M, N, J, Jp))
        print("  M=%d N=%d J=%.4g J'=%.4g : Z(J,J')=%.6e  Z(J',J)=%.6e  相対差=%.3f"
              % (M, N, J, Jp, Z, Zswap, sep))

rep.finish()
