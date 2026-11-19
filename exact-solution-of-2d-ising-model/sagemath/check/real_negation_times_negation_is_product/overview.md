# SageMath Check: real_negation_times_negation_is_product

## 対象

**対象ラベル**: `real_negation_times_negation_is_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_negation_times_negation_is_product`（`a, b ∈ ℝ` について `(−a)·(−b) = a·b`）
- 範囲: 主張と、証明の 9 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 9 行の鎖（`(−a)(−b) = ((−1)a)(−b) = ((−1)a)((−1)b) = (−1)(a((−1)b)) = (−1)((a(−1))b) = (−1)(((−1)a)b) = (−1)((−1)(ab)) = (−1)(−(ab)) = −(−(ab)) = ab`） | `check_proof_lines.sage` | 符号を反転した元 `−a, −b, −(ab), −(−(ab))` を `QQ[a, b, na, nb, nab, nnab]` の不定元に置き（計算する環で既に成り立つ `(−1)·x = −x`・`−(−x) = x` を前提にしないため）、乗法の結合律・可換律の 4 段が恒等的に等しいことと、`real_minus_one_times_is_negation`・`real_double_negation` を当てる 5 段がその主張の与える置き換えでだけ成り立つことを確かめ、本来の値に置くと全ての行が `ab` になることを確かめる | **PASS** | 厳密（等号 9 個） |
| 否定コントロール | 同上 | 主張を当てる段は置き換えなしでは成り立たない。可換律の段で `(−1)` を落とした `(−1)(ab)` は 5 段目の右辺と一致しない。終点の符号を取り違えた `−(ab)` は左辺と一致しない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[a, b, na, nb, nab, nnab]` だけで計算した。浮動小数点は使わない。
- 範囲外: 多項式環での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_negation_times_negation_is_product
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
