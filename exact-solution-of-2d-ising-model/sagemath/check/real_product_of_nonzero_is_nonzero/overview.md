# SageMath Check: real_product_of_nonzero_is_nonzero

## 対象

**対象ラベル**: `real_product_of_nonzero_is_nonzero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_product_of_nonzero_is_nonzero`（`a, b ∈ ℝ`、`a ≠ 0`、`b ≠ 0` について `a·b ≠ 0`）
- 範囲: 主張と、証明の 5 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `b = 1·b`（乗法の単位元） | `check_proof_lines.sage` | `QQ[ai, a, b, o]` で恒等的に等しい（`ai` は `a^{-1}`、`o` は仮定 `a·b = 0` の右辺の `0` の不定元） | **PASS** | 厳密 |
| 2 行目 `1·b = (a^{-1}·a)·b`（乗法の逆元） | 同上 | 差がイデアル `(ai·a − 1)` に入る | **PASS** | 厳密 |
| 3 行目 `(a^{-1}·a)·b = a^{-1}·(a·b)`（結合則） | 同上 | 恒等的に等しい | **PASS** | 厳密 |
| 4 行目 `a^{-1}·(a·b) = a^{-1}·0`（仮定 `a·b = 0`） | 同上 | 差がイデアル `(a·b − o)` に入る | **PASS** | 厳密 |
| 5 行目 `a^{-1}·0 = 0`（`real_times_zero_is_zero`） | 同上 | 4 行目の `o` を `0` に置き換えると `0` | **PASS** | 厳密 |
| 鎖の両端と主張 | 同上 | `b` がイデアル `(ai·a − 1, a·b)` に入る。0 でない有理数の組 16 個で積が 0 でない | **PASS** | 厳密 |
| 否定コントロール | 同上 | 逆元の前提を外すと `b` はイデアル `(a·b)` に入らない。逆元の段は恒等的な等号ではない。`o` を `0` に置き換えなければ 5 行目は成り立たない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と多項式環 `QQ[ai, a, b, o]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の多項式としての検算であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_product_of_nonzero_is_nonzero
```

実行ログは `logs/` に保存する（2026-11-15）。
