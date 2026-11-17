# SageMath Check: 二次体の非零元の逆元

**対象ラベル**: `claim_quadratic_inverse_mem`

**実行日**: 2026-11-17

## 確認内容

本文の共役との積、ノルム、逆元の式鎖を等号ごとに検査する。係数は `QQ`、値は `QQbar` に置き、丸めを使わない。全称命題は Lean 二版で示す。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_conjugate_representation.sage` | 表示の代入 | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_conjugate_square_difference.sage` | 平方差 | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_conjugate_square_root.sage` | s の平方 | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_conjugate_embedded_norm.sage` | 有理数の埋め込み | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_conjugate_named_norm.sage` | ノルムの定義 | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_norm_zero_coefficients.sage` | 零ノルムの係数 | PASS | 厳密な有理係数標本 81 組で等号成立 |
| `check_inverse_coefficients.sage` | 逆元候補の係数 | PASS | 厳密な有理係数標本 80 組で等号成立 |
| `check_inverse_reassociation.sage` | 積の交換結合 | PASS | 厳密な有理係数標本 80 組で等号成立 |
| `check_inverse_norm_substitution.sage` | 共役との積の代入 | PASS | 厳密な有理係数標本 80 組で等号成立 |
| `check_inverse_unit.sage` | 逆元候補の単位積 | PASS | 厳密な有理係数標本 80 組で等号成立 |
| `check_inverse_uniqueness.sage` | 逆元の一意性 | PASS | 厳密な有理係数標本 80 組で等号成立 |
