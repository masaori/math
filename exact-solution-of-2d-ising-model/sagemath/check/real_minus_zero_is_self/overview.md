# SageMath Check: real_minus_zero_is_self

## 対象

**対象ラベル**: `real_minus_zero_is_self` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_minus_zero_is_self`（`a ∈ ℝ` について `a - 0 = a`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `a - 0 = a + (-0)`（`def_real_difference`） | `check_proof_lines.sage` | 差の定義 `y + (-z)` の `-z` を不定元に置き、`y → a`・`-z → n`（`-0` を不定元 `n`）を当てたものが 1 行目の右辺と記号で一致する（`QQ` では `-0 = 0` が先に成り立つので値では区別できないため） | **PASS** | 厳密 |
| 2 行目 `a + (-0) = a + 0`（`real_negation_of_zero_is_zero`） | 同上 | `-0` を `QQ[a, n]` の不定元 `n` に置き、1 行目の右辺の `n` を `0` に置き換えると 2 行目になる | **PASS** | 厳密 |
| 3 行目 `a + 0 = a`（加法の単位元） | 同上 | `QQ[a, n]` で恒等的に等しい | **PASS** | 厳密 |
| 否定コントロール | 同上 | `n` を `0` に置き換えなければ 2 段目は成り立たない。差の向きを取り違えた `0 - a` は `a` と一致しない。`-0` を `0` そのものに取り違えると 1 行目と一致しない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[a, n]` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` での一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_minus_zero_is_self
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
