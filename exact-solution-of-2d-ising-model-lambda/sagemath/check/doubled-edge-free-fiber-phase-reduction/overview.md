# SageMath Check: 反転対の無いファイバーの位相寄与の簡約

**対象ラベル**: `claim_doubled_edge_free_fiber_phase_reduction`

一辺 $L=2$ の全非後退置換を $(D,E_1)$ のファイバーへ分け、$D=\varnothing$ の
各ファイバーを、接触なし、$\mathcal B_L$、$\mathcal A_L^{(-4)}$、
$\mathcal A_L^{(4)}$ の四集合へ分類する。四つのスピン構造ごとに
$\mathcal B_L$ の位相寄与の総和が零であり、ファイバー全体の和が残る三集合の和に
等しいことを厳密に検査する。

- 実行: `sage sagemath/check/doubled-edge-free-fiber-phase-reduction/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 反転対の無い $32$ ファイバーの置換 $497$ 個を四集合へ分類し、
  四スピン構造について位相反転部分の零和と簡約等式 $128$ 件を確認した
  （零和に含まれる被加数は延べ $1{,}664$ 個）。

計算は有限集合の分類と $\mathbb Q(\zeta_8)$ の等号だけで行い、浮動小数点は使わない。
