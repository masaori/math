# SageMath Check: trace_of_W_power_via_W_real

## 対象

**対象ラベル**: `trace_of_W_power_via_W_real` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_claim_trace_of_W_power_via_W_real`（`tr(W^q) = (Σ_k ((W_ℝ)^q)_kk)_ℂ`）
- 範囲: `W^q` の成分が実数であること、`(W^q)_ℝ = (W_ℝ)^q`、4 行の鎖
  `tr(W^q) = Σ_k (W^q)_kk = Σ_k (((W^q)_ℝ)_kk)_ℂ = Σ_k (((W_ℝ)^q)_kk)_ℂ = (Σ_k ((W_ℝ)^q)_kk)_ℂ`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張の前半と 4 行の鎖 | `check_proof_lines.sage` | `W` を `W_real_is_symmetric` の検算と同じ厳密な経路（`../W_real_is_symmetric/_W_exact.sage`、`M_col = 2, 3`、`K_1 := 2 log y`、`K_2 := log x`、`x, y ∈ {2, 3}`）で作り、`q = 0,…,4`（計 40 組）で `(W^q)_ℝ = (W_ℝ)^q` と鎖の各行を比べる。否定コントロール 1 件 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W` は QQbar、`W_ℝ` は AA で持つ。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- 範囲外: 選んだ以外の `M_col`・結合定数・冪。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_of_W_power_via_W_real
```

実行ログは `logs/` に保存する。
