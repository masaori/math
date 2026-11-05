# 閉歩道の縦辺の全列和の偶奇は隣の行で保存される

**対象ラベル**: `claim_closed_walk_vertical_row_parity_invariant`

辺長一・二・三、長さ一から六の閉歩道を列挙し、各頂点の四辺の偶奇と隣行の全列和を検算する。非後退性はこの論法では使用しない。

- 実行: `sage sagemath/check/closed-walk-vertical-row-parity-invariant/check.sage`
- 状態: PASS（2026-11-05。隣行の偶奇 11,712 件。SageMath 環境で実行）
- 計算: 整数の有限和と二で割った余りだけ。浮動小数点は使わない。
