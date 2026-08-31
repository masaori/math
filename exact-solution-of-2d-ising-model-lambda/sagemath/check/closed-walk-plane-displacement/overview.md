# SageMath Check: 閉歩道の平面変位

**対象ラベル**: `claim_representative_increment`, `claim_edge_representative_displacement`, `claim_closed_walk_plane_displacement`

三つの主張を有限列挙で厳密検査する。

- 剰余類を一つ進めたときの代表: $L=1,\dots,6$ の全剰余類 $y$ について
  $s(y+\bar1)$ が「$s(y)\le L-2$ なら $s(y)+1$、$s(y)=L-1$ なら $0$」に一致する（21 件）。
- 辺ごとの代表座標の差: $L=1,\dots,4$ の全向き付き辺について
  $s(i')-s(i)=\delta_{\mathrm{row}}-L\,c_{\mathrm v}(1-2d)$ と
  $s(j')-s(j)=\delta_{\mathrm{col}}-L\,c_{\mathrm h}(1-2d)$ が成り立つ（120 件）。
- 閉歩道の変位の総和: $L=1,2,3$、長さ $8$ までの全閉じた非後退辺列について
  $\sum_k\delta_{\mathrm{row}}(\vec e_k)=L\,w_{\mathrm v}(\gamma)$ と
  $\sum_k\delta_{\mathrm{col}}(\vec e_k)=L\,w_{\mathrm h}(\gamma)$ が成り立つ（34,112 本）。

- 実行: `sage sagemath/check/closed-walk-plane-displacement/check.sage`
- 状態: PASS（2026-08-31）
- 計算: `ZZ` の加減乗除と有限列挙だけ。浮動小数点は使わない。
