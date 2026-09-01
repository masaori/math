# SageMath Check: 切り替え不能な標準接触対が強制する反転対

**対象ラベル**: `claim_unswitchable_standard_pair_forces_doubled_edge`

一辺 $L=2$ のトーラスで、まず全向き付き辺の始点と終点が相異なることを検査する。
次に全非後退置換について、標準接触対 $\{\vec e,\vec f\}$ が切り替え可能でないなら、
像が他方自身になる等式 $\varphi(\vec f)=\vec e$、$\varphi(\vec e)=\vec f$ が
ともに起こらず、反転像の障害だけが残り、対応する台の辺が $D(\varphi)$ に属して
$D(\varphi)\ne\varnothing$ となることを検査する。

- 実行: `sage sagemath/check/unswitchable-standard-pair-forces-doubled-edge/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ で全向き付き辺の端点相異と、切り替え不能な標準接触対を持つ
  置換 $18{,}755$ 個の全てで反転対の辺の強制を確認した。

計算は有限集合の等号と部分集合の所属だけで行い、浮動小数点は使わない。
