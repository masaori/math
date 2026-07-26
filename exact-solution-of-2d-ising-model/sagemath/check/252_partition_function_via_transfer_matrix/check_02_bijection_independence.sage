# 252-02: 行・列の番号と 𝔐 = Map({1,…,N},{-1,1}) の同一視（全単射）の取り方に依らないこと
#
# def_transfer_matrix は「全単射をひとつ固定して同一視する。以下の議論はこの全単射の
# 取り方に依らない」と述べている。実際に別の全単射（乱数で作った置換、逆順、
# ビット反転に対応する置換）で V_1, V_2 を作り直し、tr((V_1V_2)^M) が一致することを見る。
#
# 併せて、V_1, V_2 の行列そのものは全単射を変えると（一般に）変わることも確認する
# ——「行列は変わるがトレースは変わらない」ことが確認したい内容だからである。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

import numpy as np

rep = CheckReport("def_transfer_matrix: tr((V_1V_2)^M) は 𝔐 と行番号の全単射に依らない")

rng = np.random.default_rng(int(20250726))

for (M, N) in MN_PAIRS:
    base = spin_maps(N)
    orders = {
        'identity': list(base),
        'reversed': list(reversed(base)),
        'flip-all': [tuple(-x for x in mu) for mu in base],
    }
    perm = rng.permutation(len(base))
    orders['random-perm'] = [base[int(k)] for k in perm]

    for (J, Jp) in JJ_PAIRS[:3]:
        ref = trace_transfer(M, N, J, Jp, order=orders['identity'])
        for name, od in orders.items():
            val = trace_transfer(M, N, J, Jp, order=od)
            rep.close(val, ref, "M=%d N=%d J=%.3g J'=%.3g order=%s" % (M, N, J, Jp, name))
        # 行列そのものは（identity 以外では）変わっていること＝チェックが空回りしていないこと
        V1a, _ = transfer_matrices(N, J, Jp, order=orders['identity'])
        V1b, _ = transfer_matrices(N, J, Jp, order=orders['random-perm'])
        differs = float(np.max(np.abs(V1a - V1b))) > 1e-8
        rep.truth(differs, "M=%d N=%d: 全単射を変えると V_1 の行列表示は実際に変わる" % (M, N))
        print("  M=%d N=%d J=%.3g J'=%.3g : tr=%.10e （4 通りの全単射で一致、V_1 の表示は相違=%s）"
              % (M, N, J, Jp, ref, differs))

rep.finish()
