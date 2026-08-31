# SageMath Check: 平行座標が離れた二つの反復横断階段の分離

**対象ラベル**: `claim_parallel_separated_staircases_disjoint`

$L=1,\ldots,5$ と $-L\le w_{\mathrm h},w_{\mathrm v}\le L$ の非零巻き付き対について、
基点 $(0,0)$ と、平行座標の差が $w_{\mathrm h}^2+w_{\mathrm v}^2>|w_{\mathrm h}w_{\mathrm v}|$
になる基点 $\pm(w_{\mathrm v},w_{\mathrm h})$ およびそれへ横断移動ベクトル
$(w_{\mathrm h},-w_{\mathrm v})$（平行座標 $0$）を足した基点の計 4 通りを取り、
分離の仮定 $|\pi_{\gamma}(Q)-\pi_{\gamma}(Q')|>|w_{\mathrm h}w_{\mathrm v}|$ を確かめたうえで、
反復回数 $t,t'\in\{1,2\}$ の二つの反復横断階段の頂点どうしが一つも一致しないことを
`ZZ` 上で全比較する。

- 実行: `sage sagemath/check/parallel-separated-staircases/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付き対 280 組、分離した基点対 1,120 組、
  二階段間の頂点比較 315,952 件を検査した。
- 計算: 有限列挙と `ZZ` の四則・絶対値・順序だけ。浮動小数点は使わない。
