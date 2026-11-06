# SageMath Check: negated_row_configuration_is_involutive

## 対象

**対象ラベル**: `negated_row_configuration_is_involutive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_negated_row_configuration_is_involutive`（`-(-s) = s`）
- 範囲: 証明の 3 行の鎖と、写像としての等号。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖と主張 | `check_proof_lines.sage` | `M_col = 1, …, 5` の全ての `s ∈ 𝔐`（共通の準備 `_epsilon_exact.sage` の `configurations`・`neg`）と全ての `m` で、`(-(-s))(m) = -((-s)(m)) = -(-s(m)) = s(m)` と `-(-s) = s` を確かめる（258 組）。否定コントロール 1 件（`-s ≠ s`） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 整数だけで計算する。ℝ への脱出は無い。
- 範囲外: `M_col ≥ 6`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh negated_row_configuration_is_involutive
```

実行ログは `logs/` に保存する。
