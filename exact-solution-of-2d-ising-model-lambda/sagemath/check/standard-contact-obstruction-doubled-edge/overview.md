# SageMath Check: 標準接触対の反転像の障害と反転対の辺

**対象ラベル**: `claim_standard_contact_obstruction_witnesses_doubled_edge`

標準接触対 $\{\vec e,\vec f\}$ が
$\varphi(\vec f)=\iota(\vec e)$ または
$\varphi(\vec e)=\iota(\vec f)$ を満たすとき、対応する台の辺が
$D(\varphi)$ に属することを検査する。あわせて、一辺 $L=2$ では標準接触対が
切り替え不能な置換の全てがこの反転像による障害に覆われることを確認する。

- 実行: `sage sagemath/check/standard-contact-obstruction-doubled-edge/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ で反転像による障害を全数検査し、標準接触対が
  切り替え不能な置換 $18{,}755$ 個の全てで $D(\varphi)\ne\varnothing$ を確認した。

計算は有限集合の等号と部分集合の所属だけで行い、浮動小数点は使わない。
