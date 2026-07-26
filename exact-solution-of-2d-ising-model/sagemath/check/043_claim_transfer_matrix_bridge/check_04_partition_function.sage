# ---------------------------------------------------------
# SageMath: 分配関数の定義（スピン配置の直接和）と転送行列表示の一致
#   Z(J,J') = tr( (V_1 V_2)^{N_row} )   （K_1 = J'、K_2 = J）
#   成分定義・パウリ表示のどちらで計算しても同じ値になること。
#   併せて K_1 と K_2 を取り違えると（M != N_row のとき）合わないことも確認する。
# 対象: structured-latex partition_function_in_pauli_form
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

MISMATCH_FLOOR = 1e-3

print("=== Z の直接和 vs tr((V_1V_2)^{N_row}) ===")
all_ok = True
for (N_row, M) in Z_CASES:
    for (K1v, K2v) in [(0.4, 0.8), (0.7, 0.3)]:
        O = SpinOps(M)
        Zd = Z_direct(N_row, M, K1v, K2v)
        Vc = V1_component(M, K1v) * V2_component(M, K2v)
        Vp = V1_pauli(O, K1v) * V2_pauli(O, K2v)
        Ztr_c = CDF((Vc ** N_row).trace())
        Ztr_p = CDF((Vp ** N_row).trace())
        r_c = abs(Ztr_c - Zd) / abs(Zd)
        r_p = abs(Ztr_p - Zd) / abs(Zd)
        # 取り違え（K_1 <-> K_2）: N_row != M なら一致しないはず
        Vsw = V1_pauli(O, K2v) * V2_pauli(O, K1v)
        Zsw = CDF((Vsw ** N_row).trace())
        r_sw = abs(Zsw - Zd) / abs(Zd)
        swap_note = ("（取り違えは不一致: rel=%.2e）" % r_sw) if N_row != M else "（N_row = M なので取り違えても一致）"
        ok = max(r_c, r_p) <= 1e-9
        if N_row != M:
            ok = ok and (r_sw >= MISMATCH_FLOOR)
        print(f"  N_row={N_row}, M={M}, K1(=J')={K1v}, K2(=J)={K2v}: "
              f"Z={Zd:.8e}, 成分定義 rel={r_c:.2e}, パウリ表示 rel={r_p:.2e} "
              f"{swap_note} -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
