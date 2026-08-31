# SageMath Check: 反復横断階段とその周期並進の分離

**対象ラベル**: `claim_period_translates_of_iterated_staircase_disjoint`

$L=1,\ldots,5$ と $-L\le w_{\mathrm h},w_{\mathrm v}\le L$ の非零巻き付き対について、
反復横断階段の平行座標が $0$ と $w_{\mathrm h}w_{\mathrm v}$ の間に収まり、一周期の
平行座標増分 $L(w_{\mathrm h}^2+w_{\mathrm v}^2)$ がその幅を真に超えることを検査する。
さらに二基点・三反復回数について、階段の頂点集合が周期並進 $z=-2,-1,1,2$ の各像と
交わらないことを `ZZ` 上で全比較する。

- 実行: `sage sagemath/check/period-translates-of-iterated-staircase/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付き対 280 組、階段頂点 16,800 個、
  非零周期並進との頂点比較 908,544 件を検査した。
- 計算: 有限列挙と `ZZ` の四則・絶対値・順序だけ。浮動小数点は使わない。
