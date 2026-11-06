# SageMath Check: epsilon_entries_in_row_configuration_numbering

## 対象

**対象ラベル**: `epsilon_entries_in_row_configuration_numbering` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_entries_in_row_configuration_numbering`（`ε` の成分を 1 行ぶんのスピン配置の番号で読む）
- 範囲: 証明の準備の 2 本の 3 行の含意（`s'(m) = -s(m)` と `s'(m) ≠ -s(m)` の場合）、`s' = -s` の 5 行の鎖、`s' ≠ -s` の 4 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の含意・場合ごとの鎖 | `check_proof_lines.sage` | 共通の準備 `_epsilon_exact.sage` で `𝔐`・`ord`・`ι`・`ν` を定義どおりに作り、`ε` を `σ_1^x⋯σ_{M_col}^x`（`def_global_spin_flip_matrix`）とクロネッカー積表示の両方で作る。`M_col = 1, 2, 3, 4` の全ての `(s, s')`（計 340 組）で、準備の含意の各段、`ord = ν∘ι`、場合ごとの鎖の各行の値の一致（`s' ≠ -s` では `0` の因子の在ることも）を確かめる。否定コントロール 1 件（`σ^x` を単位行列に替えると `s' = -s` の成分が `1` でなくなる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 行列は QQbar で持つ。浮動小数点は使わない。ℝ への脱出は無い。
- 範囲外: `M_col ≥ 5`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_entries_in_row_configuration_numbering
```

実行ログは `logs/` に保存する。
