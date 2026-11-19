# SageMath Check: real_product_of_inverses_is_inverse_of_product

## 対象

**対象ラベル**: `real_product_of_inverses_is_inverse_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_product_of_inverses_is_inverse_of_product`（`a, b ∈ ℝ`、`a ≠ 0`、`b ≠ 0` について `a^{-1}·b^{-1} = (a·b)^{-1}`）
- 範囲: 主張と、証明の準備の 7 行の鎖・主鎖の 6 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 1〜4 行目（結合律・結合律を右辺から左辺へ・可換律・結合律） | `check_proof_lines.sage` | `QQ[a, b, ai, bi, ci]` で恒等的に等しい（`ai`・`bi`・`ci` は `a^{-1}`・`b^{-1}`・`(a·b)^{-1}` の不定元） | **PASS** | 厳密 |
| 準備の 5 行目（`def_real_quotient` の逆元、`z → b`） | 同上 | 差がイデアル `(b·bi − 1)` に入る | **PASS** | 厳密 |
| 準備の 6 行目（単位元 `x·1 = x`） | 同上 | 恒等的に等しい | **PASS** | 厳密 |
| 準備の 7 行目（`def_real_quotient` の逆元、`z → a`） | 同上 | 差がイデアル `(a·ai − 1)` に入る | **PASS** | 厳密 |
| 主鎖の 1 行目（単位元 `1·x = x` を右辺から左辺へ） | 同上 | 恒等的に等しい | **PASS** | 厳密 |
| 主鎖の 2 行目（`def_real_quotient` の逆元、`z → a·b` を右辺から左辺へ） | 同上 | 差がイデアル `((a·b)·ci − 1)` に入る | **PASS** | 厳密 |
| 主鎖の 3・4 行目（可換律・結合律） | 同上 | 恒等的に等しい | **PASS** | 厳密 |
| 主鎖の 5 行目（準備） | 同上 | 差がイデアル `(a·ai − 1, b·bi − 1)` に入る | **PASS** | 厳密 |
| 主鎖の 6 行目（単位元 `x·1 = x`） | 同上 | 恒等的に等しい | **PASS** | 厳密 |
| 鎖の両端と主張 | 同上 | `ai·bi − ci` が三つの逆元の前提のイデアルに入る。0 でない有理数の組 16 個で積が 0 でなく `x^{-1}y^{-1} = (xy)^{-1}` | **PASS** | 厳密 |
| 否定コントロール | 同上 | `(a·b)^{-1}` の前提を外すと結論は従わない。逆元の段は恒等的な等号ではない。準備の段は `b·bi = 1` だけでは閉じない | **PASS** | 3 件 |
| ℝ の単位元を引く行（`set_and_algebra_notation`）: `a·(a^{-1}·1) = a·a^{-1}（x·1 = x の x → a^{-1}）`、`a^{-1}·b^{-1} = 1·(a^{-1}·b^{-1})（1·x = x の x → a^{-1}·b^{-1} を右辺から左辺へ）`、`(a·b)^{-1}·1 = (a·b)^{-1}（x·1 = x の x → (a·b)^{-1}）` | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈の穴にそれを入れたものと `QQ` 上の多項式環（または分数体）で等しいことを確かめる。多項式環は式を正規化するので、形の左右と「右辺から左辺へ」の向きは区別できず、それはレビューの目視で確かめた。対照（`0 + 1 ≠ 0`・`2·3 ≠ 3`） | **PASS** | 厳密（3 行） |

## 計算の帰属と範囲

- **厳密**: `QQ` と多項式環 `QQ[a, b, ai, bi, ci]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の多項式としての検算であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_product_of_inverses_is_inverse_of_product
```

実行ログは `logs/` に保存する（2026-11-16）。
