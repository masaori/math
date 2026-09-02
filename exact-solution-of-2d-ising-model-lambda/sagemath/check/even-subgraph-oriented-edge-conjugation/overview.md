# SageMath Check: 偶部分グラフ上の向き反転共役の反例

**対象ラベル**: `claim_selection_even_subgraph_action_character`,
`claim_path_reversal_fiber_preserving_involution`

一辺 $L=2$ の非後退置換 $\varphi$ と、その単純通過辺集合 $E$ に含まれる偶部分グラフ
$H$ の全 $78{,}752$ 組について、$H$ 上だけ二つの向きを交換する対合 $\rho_H$ による共役
$\rho_H\circ\varphi\circ\rho_H$ が、選択和の文字に対応する置換側の作用になるかを検査する。

- 実行: `sage sagemath/check/even-subgraph-oriented-edge-conjugation/check.sage`
- 状態: PASS（2026-09-03）
- 方法: 有限集合・有限写像と $\mathbb Q(\zeta_8)$ の等号だけ。浮動小数点は使わない。
- 結果: 共役は全組で反転対辺集合 $D$ と単純通過辺集合 $E$ を保ったが、$43{,}664$ 組で
  非後退性を壊した。非後退性を保った像についても、期待する文字符号
  $(-1)^{\varepsilon_{L,\mathrm h}(E)\varepsilon_{L,\mathrm v}(H)
  +\varepsilon_{L,\mathrm v}(E)\varepsilon_{L,\mathrm h}(H)}$ と位相寄与の比が一致しないものが
  四スピン構造を合わせて $7{,}680$ 件あった。従って、この共役を空・非自明文字の
  ファイバー位相和を消す作用には使わない。
