# 反周期のねじれたモードが存在する

**対象ラベル**: `claim_antiperiodic_mode_exists`

体 $\overline{\mathbb Q}$ の冪根について、辺長 $1$ から $6$ まで厳密等号で検算する。一般の辺長の証明は本文と Lean が担う。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_root_membership.sage` | 証人の冪根条件 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_nontrivial_power.sage` | 証人の $L$ 乗が $1$ でないこと | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_exponent_law.sage` | 指数法則 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_root_value.sage` | 冪根条件の代入 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_difference_of_squares.sage` | 差の平方の因数分解 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_zero_difference.sage` | 平方から零への移行 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_neg_one.sage` | 体の零積から得る結論 | PASS | 2026-10-27、辺長 1〜6 で一致 |
