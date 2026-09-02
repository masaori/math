# SageMath Check: 反転対を持つファイバーの位相寄与の簡約

**対象ラベル**: `claim_doubled_edge_fiber_phase_reduction`

一辺 $L=2$ の全非後退置換を $(D,E_1)$ のファイバーへ分け、$D\ne\varnothing$ の
各ファイバーを、接触なし、$\mathcal B_L$、$\mathcal A_L^{(-4)}$、
$\mathcal A_L^{(4)}$、$\mathcal R_L$（接触対を持つが標準対が切り替え不能）の
五集合へ分類する。四つのスピン構造ごとに $\mathcal B_L$ の位相寄与の総和が零であり、
ファイバー全体の和が残る四集合の和に等しいことを厳密に検査する。

- 実行: `sage sagemath/check/doubled-edge-fiber-phase-reduction/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 反転対を持つ $577$ ファイバーの置換 $30{,}287$ 個を五集合へ分類し、
  四スピン構造について位相反転部分の零和と簡約等式 $2{,}308$ 件を確認した
  （零和に含まれる被加数は延べ $17{,}328$ 個、切り替え不能な残余は $18{,}755$ 個）。

計算は有限集合の分類と $\mathbb Q(\zeta_8)$ の等号だけで行い、浮動小数点は使わない。
