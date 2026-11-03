# SageMath Check: transpose_of_finite_sum_of_matrices

## 対象

**対象ラベル**: `transpose_of_finite_sum_of_matrices`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_transpose_of_finite_sum_of_matrices`（行列の有限和の転置は転置の有限和）
- 範囲: 証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_induction_chains.sage` | `r = 1` の 2 段と、帰納法の段の 4 段（`def_finite_sum_of_matrices` → `transpose_of_matrix_sum` → 帰納法の仮定 → `def_finite_sum_of_matrices`）を、`X_j` の成分を不定元にして。有限和は定義どおり左から足して組む。否定コントロール 1 件: 最後の項を落とすと一致しない | **PASS** | 162 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。行列の成分（と係数）は不定元で代表させる（鎖の各段は多項式の恒等式なので、どの複素数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n = 1..3`、項の数 `r = 1..4`（帰納法の段は `r → r+1`）。主張は成分ごとの等式（有限和は帰納法の段）なので、大きさによらず同じ段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_of_finite_sum_of_matrices
```

実行ログは `logs/` に保存する。
