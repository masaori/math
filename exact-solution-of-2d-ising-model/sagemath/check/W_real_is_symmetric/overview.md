# SageMath Check: W_real_is_symmetric

## 対象

**対象ラベル**: `W_real_is_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_claim_W_real_is_symmetric`（`W_ℝ` は対称）
- 範囲: 証明の 4 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = (W^⊤)_kl = W_lk = ((W_ℝ)_lk)_ℂ` と、単射性による `(W_ℝ)_kl = (W_ℝ)_lk`。
  共通の準備 `_W_exact.sage` は `def_W_real` の `W_ℝ := ϱ(W)` と `((W_ℝ)_kl)_ℂ = W_kl` も確かめる（`W_real_is_positive_definite` の検算も使う）。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖と主張 | `check_proof_lines.sage` | `W = (BV_2)B` を `W_is_real_symmetric_positive_definite` の検算と同じ厳密な経路で作り（`M_col = 2, 3`、`K_1 := 2 log y`、`K_2 := log x`、`x, y ∈ {2, 3}`）、全ての `k, l`（計 320 組）で各行を比べ、`W_ℝ^⊤ = W_ℝ` を確かめる。否定コントロール 1 件（対称でない行列は 2→3 行で外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W` の成分は実の数体、`W` は QQbar、`W_ℝ` は AA で持つ。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- 範囲外: 選んだ以外の `M_col`・結合定数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_real_is_symmetric
```

実行ログは `logs/` に保存する。
