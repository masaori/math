# SageMath Check: epsilon_real_commutes_with_W_real

## 対象

**対象ラベル**: `epsilon_real_commutes_with_W_real` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_commutes_with_W_real`（`ε_ℝW_ℝ = W_ℝε_ℝ`）
- 範囲: 証明の 3 行の鎖 `ε_ℝW_ℝ = ϱ(εW) = ϱ(Wε) = W_ℝε_ℝ`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖と主張 | `check_proof_lines.sage` | `W = (BV_2)B` と `W_ℝ := ϱ(W)` を `W_real_is_symmetric` の共通の準備 `_W_exact.sage` で作り（`M_col = 2, 3`、`K_1 := 2 log y`、`K_2 := log x`、`x, y ∈ {2, 3}`）、`ε = σ^x⊠⋯⊠σ^x`・`ε_ℝ := ϱ(ε)` と、積を成分の和（`def_real_matrix_product`・`mat_mult`）で作って、`εW = Wε` と鎖の 4 つの値の一致を 8 組で確かめる。否定コントロール 1 件（左上の成分だけ 1 の行列は `ε` と可換でなく、2→3 行で外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W`・`ε` は QQbar、`W_ℝ`・`ε_ℝ` は AA で持つ。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- 範囲外: 選んだ以外の `M_col`・結合定数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_commutes_with_W_real
```

実行ログは `logs/` に保存する。
