# SageMath Check: real_negation_times_is_negation_of_product

## 対象

**対象ラベル**: `real_negation_times_is_negation_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_negation_times_is_negation_of_product`（`x, t ∈ ℝ` について `(−x)·t = −(x·t)`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖（`(−x)t = ((−1)x)t = (−1)(xt) = −(xt)`） | `check_proof_lines.sage` | 符号を反転した元 `−x, −(xt)` を `QQ[x, t, nx, nxt]` の不定元に置き（計算する環で既に成り立つ `(−1)·y = −y` を前提にしないため）、乗法の結合則の 1 段が恒等的に等しいことと、`real_minus_one_times_is_negation` を当てる 2 段がその主張の与える置き換えでだけ成り立つことを確かめ、本来の値に置くと全ての行が `−(xt)` になることを確かめる。本文で引く側の代入（`(x, t) → (bd, e), (bd, f), (bd, ac), (1/2, Σγ)`）の実例で両辺が等しいことも確かめる | **PASS** | 厳密（等号 3 個、実例 4 件） |
| 否定コントロール | 同上 | 主張を当てる段は置き換えなしでは成り立たない。結合則の段で `(−1)` を落とした `xt`、因子を取り違えた `(−1)(xx)` は 3 行目と一致しない。終点の符号を取り違えた `xt` は左辺と一致しない | **PASS** | 4 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[x, t, nx, nxt]` と `QQ[a, b, c, d, e, f, s]` だけで計算した。浮動小数点は使わない。
- 範囲外: 多項式環での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_negation_times_is_negation_of_product
```

実行ログは `logs/` に保存する（2026-11-18、SageMath 10.9）。
