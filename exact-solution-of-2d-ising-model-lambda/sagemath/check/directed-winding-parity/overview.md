# SageMath Check: 整数巻き付き数の偶奇

**対象ラベル**: `claim_directed_winding_parity`

長さ $1$ から $8$ までのすべての切断線指示値列と向きの列について、本文の定義どおり

$$
w=\sum_k c_k(1-2d_k),\qquad p=\left(\sum_k c_k\right)\bmod2
$$

を整数環で計算し、$w\bmod2=p$ を横向き・縦向きの両方について検査する。

- 実行: `sage sagemath/check/directed-winding-parity/check.sage`
- 状態: PASS（2026-08-31）
- 計算: `ZZ` 上の有限和と二で割った余りだけ。浮動小数点は使わない。
