# 辺部分集合の切断線の偶奇は巻き付き偶奇に等しい

**対象ラベル**: `claim_edge_set_horizontal_seam_parity_equals_winding_parity`, `claim_edge_set_vertical_seam_parity_equals_winding_parity`

代表 $s(y)=L-1$ と $y=\pi(-1)$ の同値、一辺ごとの等式の三行（辺番号の分解・代表の同値・切断線の指示子）、
辺部分集合の式鎖の五行（一辺ごとの等式・有限和の交換・一点の指示子の和・単射の像との共通部分・巻き付き偶奇）を
横と縦の両方で検算する。辺長一・二は全ての辺部分集合、辺長三は固定した種の無作為な 3,000 個。

- 実行: `sage sagemath/check/edge-set-seam-parity-equals-winding-parity/check.sage`
- 状態: PASS（2026-11-14。6,582 件の厳密な等式。conda-forge 版の SageMath で実行）
- 計算: 整数の有限和と二で割った余りだけ。浮動小数点は使わない。
