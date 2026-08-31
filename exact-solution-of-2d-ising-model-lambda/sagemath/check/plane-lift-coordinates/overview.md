# SageMath Check: 非後退辺列の平面持ち上げの座標式

**対象ラベル**: `claim_plane_lift_coordinates`

一辺 $L=1,2,3$ の周期正方格子について、長さ $6$ までのすべての非後退辺列 $\gamma$ を列挙し、
平面持ち上げ $P_k(\gamma)$ を `def_plane_lift` の漸化式で計算して、すべての時点 $k$ で

$$P_k(\gamma)=\Bigl(s(i'_k)+L\sum_{t\le k}c_{\mathrm v}(\vec e_t)(1-2d_t),\ s(j'_k)+L\sum_{t\le k}c_{\mathrm h}(\vec e_t)(1-2d_t)\Bigr)$$

が成り立つことを検査する（$(i'_k,j'_k)=\operatorname{tgt}(\vec e_k)$）。
$L=1,2$ の自己ループ・多重辺も辺番号と向きを保ったまま列挙する。

- 実行: `sage sagemath/check/plane-lift-coordinates/check.sage`
- 状態: PASS（2026-08-31。件数は実行出力に記録）
- 計算: 有限集合の全列挙と `ZZ` の等式比較だけ。浮動小数点は使わない。
