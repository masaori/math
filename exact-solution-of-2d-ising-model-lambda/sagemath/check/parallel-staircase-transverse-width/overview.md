# SageMath Check: 平行階段の横断座標の幅と帯外条件

**対象ラベル**: `claim_parallel_staircase_transverse_width_bound`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列について、平行階段の横断座標が
$0$ と $Lw_{\mathrm h}w_{\mathrm v}$ の間に収まることを `ZZ` で検査する。
さらに、横断座標の下端が周期持ち上げの有限帯の上端より一つ大きくなる基点を取り、
平行階段の全頂点が帯の全水準と異なることを厳密に比較する。

- 実行: `sage sagemath/check/parallel-staircase-transverse-width/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本、平行階段の頂点 18,336 個、帯の水準との比較 133,560 件を全列挙した。
- 計算: 有限列挙、整数の絶対値・場合分け・四則と順序だけ。浮動小数点は使わない。
