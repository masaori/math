# 横切断線の偶奇は最終列の横辺の全行和に等しい

**対象ラベル**: `claim_horizontal_seam_parity_equals_column`

一辺ごとの指示子の等式と、通過回数の剰余、有限二重和の交換、切断線偶奇への同定を行別に検算する。閉歩道の仮定は不要である。

- 実行: `sage sagemath/check/horizontal-seam-parity-equals-column/check.sage`
- 状態: PASS（2026-11-05。6,800 件の厳密な等式。micromamba の SageMath 環境で実行）
- 計算: 整数の有限和と二で割った余りだけ。浮動小数点は使わない。
