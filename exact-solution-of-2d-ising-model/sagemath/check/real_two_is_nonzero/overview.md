# SageMath Check: real_two_is_nonzero

## 対象

**対象ラベル**: `real_two_is_nonzero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_two_is_nonzero`（`ℝ` で `2 ≠ 0`。`2` は `def_real_two` の `1 + 1`）
- 範囲: 主張と、証明の 2 行の推論

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 左の `0 < 2`（`real_zero_less_than_two`） | `check_proof_lines.sage` | `QQ`・`AA` で `0 < 1 + 1` | **PASS** | 厳密 |
| 1 行目 `0 < 2 ⇒ 0 ≠ 2`（`<` の意味の後半） | 同上 | `QQ`・`AA` で `0 ≤ 1 + 1` かつ `0 ≠ 1 + 1`。推論の形 `x < y ⇒ x ≤ y かつ x ≠ y` を有理数の標本で確かめる | **PASS** | 厳密 |
| 2 行目 `0 ≠ 2 ⇒ 2 ≠ 0`（等号の対称律の対偶） | 同上 | `QQ`・`AA` で `1 + 1 ≠ 0`。推論の形 `x ≠ y ⇒ y ≠ x` を有理数の標本で確かめる | **PASS** | 厳密 |
| 否定コントロール | 同上 | `<` を `≤` と取り違えると後半が出ない（`0 ≤ 0` だが `0 = 0`）。`2` を `1 + (−1)` と取り違えると `0 < 2`・`2 ≠ 0` が偽。`x < y` を満たさない組 `x = y = 2` では `x ≠ y` が偽 | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: `QQ`・`AA` の比較だけで計算した。浮動小数点は使わない。
- 範囲外: 推論の形は有理数の標本で確かめるだけで、ℝ の順序体の公理からの証明ではない。
  検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_two_is_nonzero
```

実行ログは `logs/` に保存する（2026-11-15）。
