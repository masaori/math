# SageMath Check: real_zero_divided_is_zero

## 対象

**対象ラベル**: `real_zero_divided_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_zero_divided_is_zero`（`x ∈ ℝ`、`x ≠ 0` について `0/x = 0`）
- 範囲: 主張と、証明の 2 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `0/x = 0·x^{-1}`（`def_real_quotient`） | `check_proof_lines.sage` | 割られる側の `0` を有理関数体 `Frac(QQ[o, x])` の不定元 `o` に置き、`o/x = o·x^{-1}` が恒等的に等しい | **PASS** | 厳密 |
| 2 行目 `0·x^{-1} = 0`（`real_zero_times_is_zero`） | 同上 | 2 行目の `o` を `0` に置き換えると `0`。0 でない有理数の `x` 4 個でも鎖を確かめる | **PASS** | 厳密 |
| 否定コントロール | 同上 | 割られる側を `1` に取り違えると `0` にならない。`o` を `0` に置き換えなければ 2 段目は成り立たない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と有理関数体 `Frac(QQ[o, x])` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の有理関数としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_zero_divided_is_zero
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
