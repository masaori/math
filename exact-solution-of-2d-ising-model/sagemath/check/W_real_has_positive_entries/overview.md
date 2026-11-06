# SageMath Check: W_real_has_positive_entries

## 対象

**対象ラベル**: `W_real_has_positive_entries` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_W_real_has_positive_entries`（`W_ℝ` の成分はすべて正）
- 範囲: 証明の 2 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = w_ℂ` と、単射性による `(W_ℝ)_kl = w`、`w > 0` による主張。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `w` の取り方、2 行の鎖と主張 | `check_proof_lines.sage` | `W = (BV_2)B` と `W_ℝ := ϱ(W)` を `W_real_is_symmetric` の共通の準備 `_W_exact.sage` で作り（`M_col = 2, 3`、`K_1 := 2 log y`、`K_2 := log x`、`x, y ∈ {2, 3}`）、全ての `k, l`（計 320 組）で `W_kl = w_ℂ` を満たす `w > 0` を取り、各行の一致と `(W_ℝ)_kl = w > 0` を確かめる。否定コントロール 3 件（同じ手順を関数 `check_entry` にし、成分 0・負の成分・実数でない成分を持つ 2 次の行列で外れることを確かめる）。`w` は `W_kl` の実部で、`W_ℝ` を作る式と同じなので `(W_ℝ)_kl = w` は構成上成り立つ（主張の性質上避けられない。検算の要は `w > 0` と鎖の一致） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `W` は QQbar、`W_ℝ`・`w` は AA で持つ。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- 範囲外: 選んだ以外の `M_col`・結合定数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_real_has_positive_entries
```

実行ログは `logs/` に保存する。
