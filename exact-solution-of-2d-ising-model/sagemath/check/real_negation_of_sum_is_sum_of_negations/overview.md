# SageMath Check: real_negation_of_sum_is_sum_of_negations

## 対象

**対象ラベル**: `real_negation_of_sum_is_sum_of_negations` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_negation_of_sum_is_sum_of_negations`（`x, y ∈ ℝ` について `−(x+y) = (−x)+(−y)`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖（`−(x+y) = (−1)(x+y) = (−1)x+(−1)y = (−x)+(−y)`） | `check_proof_lines.sage` | 符号を反転した元 `−(x+y), −x, −y` を `QQ[x, y, nxy, nx, ny]` の不定元に置き（計算する環で既に成り立つ `−(x+y) = (−x)+(−y)` を前提にしないため）、分配則の 2 行目が恒等的に等しいことと、`real_minus_one_times_is_negation` を当てる 1 行目・3 行目が、符号反転を `(−1)·(元)` に置いたときにだけ成り立つことを確かめ、本来の値に置くと全ての行が `−x−y` になることを確かめる。本文で引く側の代入の実例 9 件（文字が衝突する箇所は別の不定元で置いた）で両辺が等しいことも確かめる | **PASS** | 厳密（等号 3 個、実例 9 件） |
| 否定コントロール | 同上 | 主張を当てる段は置き換えなしでは成り立たない。一方の符号だけを反転した `(−x)+y`、符号を反転しない `x+y` は左辺と一致しない。3 行目の置き換えで `−y` を `(−1)x` と取り違えると 3 行目と一致しない | **PASS** | 4 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[x, y, nxy, nx, ny]` と `QQ[a, b, c, d, e, f, u, v, w, z, s, xm, th, k, pi_]` だけで計算した（`π` は不定元 `pi_` で置いた）。浮動小数点は使わない。
- 範囲外: 多項式環での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_negation_of_sum_is_sum_of_negations
```

実行ログは `logs/` に保存する（2026-11-18、SageMath 10.9）。
