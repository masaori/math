# SageMath Check: pauli_y_is_i_times_real_factor

## 対象

**対象ラベル**: `pauli_y_is_i_times_real_factor`

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`
- ブロック: `Z_Y_anticommutation_claim_pauli_y_is_i_times_real_factor`（σ^y = iR^y）
- 範囲: 証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖の全行 | `check_chain.sage` | `σ^y = (0 -i; i 0) = (0 (-1)·i; i 0) = (0 i·(-1); i 0) = (0 i·(-1); i·1 0) = (i·0 i·(-1); i·1 i·0) = i(0 -1; 1 0) = iR^y` の 7 段（`pauli_matrix_products` → `multiply_by_minus_one` → 積の可換律 → 積の単位元 → `complex_times_zero_is_zero` → `def_matrix_scalar_multiple` → `def_real_factor_of_pauli_y`）。各行は人手の式どおりに組み、スカラー倍は `def_matrix_scalar_multiple` の成分の式で組む。否定コントロール 1 件: 符号を逆にした `(0 1; -1 0)` の `i` 倍は `σ^y` にならない | **PASS** | 7 段 |

共通の準備は `sagemath/_shared/pauli_sites_exact.sage`（σ^x, σ^y, σ^z, I は `pauli_matrix_products` の成分）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲: 主張は 2 次の具体的な行列 1 つについての等式なので、鎖の全行をそのまま確かめた。

- 1 行目の `σ^y` は共通の準備の行列、2 行目以降は人手の式どおりに組んだ行列で、2 行目は 1 行目と構成上一致する（`pauli_matrix_products` の成分を写すだけの行）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh pauli_y_is_i_times_real_factor
```

実行ログは `logs/` に保存する。
