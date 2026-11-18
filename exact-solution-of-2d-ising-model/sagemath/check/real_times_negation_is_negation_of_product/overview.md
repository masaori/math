# SageMath Check: real_times_negation_is_negation_of_product

## 対象

**対象ラベル**: `real_times_negation_is_negation_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_times_negation_is_negation_of_product`（`x, t ∈ ℝ` について `x·(−t) = −(x·t)`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖（`x(−t) = (−t)x = −(tx) = −(xt)`） | `check_proof_lines.sage` | 符号を反転した元 `−t, −(tx), −(xt)` を `QQ[x, t, nt, ntx, nxt]` の不定元に置き（計算する環で既に成り立つ `x(−t) = −(xt)` を前提にしないため）、乗法の可換則の 1 行目が恒等的に等しいことと、`real_negation_times_is_negation_of_product` を当てる 2 行目・符号反転の中で可換則を当てる 3 行目が、符号反転を `(−1)·(積)` に置いたときにだけ成り立つことを確かめ、本来の値に置くと全ての行が `−(xt)` になることを確かめる。本文で引く側の代入の実例 11 件（`complex_conjugate_of_product` の `(x, v)` は不定元 `w` で `(w, v)` と置いた）で両辺が等しいことも確かめる | **PASS** | 厳密（等号 3 個、実例 11 件） |
| 否定コントロール | 同上 | 主張を当てる段は置き換えなしでは成り立たない。符号を落とした `xt`、因子を取り違えた `(−x)x` は左辺と一致しない。2 行目の置き換えで `−(tx)` を `(−1)(tt)` と取り違えると 3 行目と一致しない | **PASS** | 4 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[x, t, nt, ntx, nxt]` と `QQ[a, b, c, d, f, v, w, mu, ka, j, k, g, pi_]` だけで計算した（`π` は不定元 `pi_` で置いた）。浮動小数点は使わない。
- 範囲外: 多項式環での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_times_negation_is_negation_of_product
```

実行ログは `logs/` に保存する（2026-11-18、SageMath 10.9）。
