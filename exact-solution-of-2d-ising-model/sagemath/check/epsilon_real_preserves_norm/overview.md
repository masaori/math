# SageMath Check: epsilon_real_preserves_norm

## 対象

**対象ラベル**: `epsilon_real_preserves_norm` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_preserves_norm`（`‖ε_ℝu‖ = ‖u‖`）
- 範囲: 証明の準備（`χ(k) := ord(-ord^{-1}(k))`、`χ(χ(k)) = k` の 5 行、`χ` の全単射性、`(ε_ℝu)_k = u_{χ(k)}` の 3 行）と主張の 4 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と 4 行の鎖 | `check_proof_lines.sage` | `ε` を `σ_1^x⋯σ_{M_col}^x`（共通の準備 `_epsilon_exact.sage`）で作り `ε_ℝ := ϱ(ε)` とする。`M_col = 1, 2, 3, 4` で負の成分も含む有理数のベクトル `u` を 5 本ずつ（計 20 本、種は固定）取り、全ての `k` で `χ(χ(k))` の 5 行の値と `(ε_ℝu)_k` の 3 行の値が一致すること、`χ` の値が `{1,…,d}` をちょうど一度ずつ取ること、ノルムの 4 行の値が一致することを確かめる。否定コントロール 1 件（`2ε_ℝ` ではノルムが保たれない） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `ε` は QQbar、`ε_ℝ`・`u` とノルム（`AA` の平方根）は AA で持つ。浮動小数点は使わない。
  ノルムの平方根は ℝ の元だが、ここでは代数的数として厳密に比べている。
- 範囲外: `M_col ≥ 5`、選んだ以外の `u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_preserves_norm
```

実行ログは `logs/` に保存する。
