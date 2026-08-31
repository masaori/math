# SageMath Check: 反復横断階段の平行座標の幅

**対象ラベル**: `claim_iterated_staircase_parallel_width_bound`

$L=1,\ldots,5$ と $-L\le w_{\mathrm h},w_{\mathrm v}\le L$ の非零巻き付き対について、
二基点 $(0,0),(2,-3)$・反復回数 $t=1,2,3$ の反復横断階段の全頂点の平行座標が、
基点の平行座標から $\min\{0,w_{\mathrm h}w_{\mathrm v}\}$ 以上
$\max\{0,w_{\mathrm h}w_{\mathrm v}\}$ 以下のずれに収まることを `ZZ` 上で検査する。

- 実行: `sage sagemath/check/iterated-staircase-parallel-width/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付き対 280 組、平行座標のずれ 16,800 件を検査した。
- 計算: 有限列挙と `ZZ` の四則・絶対値・順序だけ。浮動小数点は使わない。
