# SageMath Check: 置換ファイバー位相和と偶部分グラフ選択和の一致

**対象ラベル**: `def_fiber_phase_weight`, `def_signed_selection_sum`

一辺 $L=2$ の全非後退置換を、反転対の辺集合 $D$ と単純通過の辺集合 $E$ で
ファイバーに分ける。各ファイバーと四つのスピン構造について、置換側の位相和
$\mathcal K^{a,b}_L(D,E)$ を $\mathbb Q(\zeta_8)$ で、偶部分グラフ対側の符号付き選択和
$\mathcal U^{a,b}_L(D,E)$ を $\mathbb Z$ で定義から直接計算し、両者を比較する。

- 実行: `sage sagemath/check/kac-ward-fiber-signed-selection-equality/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ の全 $609$ ファイバーと四つのスピン構造、合計 $2{,}436$ 件で
  $\mathcal K^{a,b}_L(D,E)=\mathcal U^{a,b}_L(D,E)$ が成立した。
- 帰結: 多項式全体の一致だけでなく、一般の証明で目標にすべき等式は
  $(D,E)$ ごとの一致である。接触の無い置換、回転差が正負 $4$ の置換、残余を合わせた
  位相和が、同じ添字の偶部分グラフ選択和へ一致する数え上げを構成する必要がある。

計算は有限集合の列挙、整数の四則、円分体 $\mathbb Q(\zeta_8)$ の厳密和だけで行い、
浮動小数点は使わない。
