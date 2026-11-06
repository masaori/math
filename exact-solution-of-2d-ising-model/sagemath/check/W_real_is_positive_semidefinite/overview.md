# SageMath Check: W_real_is_positive_semidefinite

## 対象

**対象ラベル**: `W_real_is_positive_semidefinite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_claim_W_real_is_positive_semidefinite`（すべての `u` で `u^⊤W_ℝu ≥ 0`）
- 範囲: `u = 0` の 5 行の鎖、`u ≠ 0` の側の `W_real_is_positive_definite` の当てはめ

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `u = 0` の 5 行の鎖、`u ≠ 0` の側、主張 | `check_proof_lines.sage` | `W_ℝ` は `../W_real_is_symmetric/_W_exact.sage` で作る（`M_col = 2, 3`、`x, y ∈ {2, 3}`）。零ベクトルで各行を本文の字面どおり（積の括弧）に組んで隣の行と比べ、零でない `u` 4 本で `u^⊤W_ℝu > 0` を確かめる。否定コントロール 1 件（`diag(1, −1)` では負の値が出る） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA だけで計算した。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- `u = 0` の鎖は QQ の演算で構成上成り立つ（書き写しの検査）。`u ≠ 0` の側の中身は `W_real_is_positive_definite` の検算が受け持つ。
- 範囲外: 選んだ以外の `M_col`・結合定数・`u`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_real_is_positive_semidefinite
```

実行ログは `logs/` に保存する。
