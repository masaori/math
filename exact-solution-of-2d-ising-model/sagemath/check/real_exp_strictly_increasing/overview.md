# SageMath Check: real_exp_strictly_increasing

## 対象

**対象ラベル**: `real_exp_strictly_increasing` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_011_claim_real_exp_strictly_increasing`（`x < y` なら `exp(x) < exp(y)`）
- 範囲: Step 1 の準備の鎖と二つの収束の鎖、`E(a) = exp(a)`、`exp(a) > 1` の鎖、Step 2 の鎖、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 1 の準備 `‖[u]_R‖ = √(Σ_{i,j=1}^{1}|([u]_R)_ij|^2) = √(|([u]_R)_11|^2) = √(|u|^2) = |u|` | `check_one_by_one_norm.sage` | 7 点の `u ∈ QQ` で、本文のノルムの定義（成分の絶対値の平方和の非負平方根）を `AA` で厳密に取り、各辺が一致する。もう一つの平方根 `-|u|` は `u ≠ 0` で負 | **PASS** | 厳密等号 |
| Step 1 の準備 `[u]_R - [v]_R = [([u]-[v])_11] = [([u])_11 - ([v])_11] = [u-v]_R` | `check_one_by_one_norm.sage` | `QQ[u,v]` の不定元で、各辺を成分から作って比べる | **PASS** | 厳密等号 |
| Step 1 の二つの収束の鎖 `‖[E_N(a)] - [E(a)]‖ = |E_N(a) - E(a)| → 0`、`‖[E_N(a)] - [exp(a)]‖ = |E_N(a) - exp(a)| = |Σ_{m=0}^{N} a^m/m! - exp(a)| → 0` | `check_step1_exp_greater_than_one.sage` | 等号の行は準備の鎖で確かめた。`E_N(a) = Σ a^m/m!` の行は検算の `E_N` がこの和で定義されているので構成上かならず一致し、中身は次の行の `E_N(a) = (S_N([a]))_11` が担う。`→ 0` の行は、5 点の `a > 0` で `N = 10,…,320` について `|E_N(a) - exp(a)|` の上界と `E(a) - E_N(a)` の上界の式が単調に減り、`2^{-200}` を下回ること（下の「構成上かならず一致する比較」を参照） | **PASS** | 全点で成り立つ |
| 極限の一意性の帰結 `E(a) = exp(a)` | `check_step1_exp_greater_than_one.sage` | `E(a)` を囲むボールと `exp(a)` を囲むボールが重なる。あわせて、二つの列が同じ列であること `E_N(a) = (S_N([a]))_11` を `QQ[a]` で `N ≤ 25` について確かめる | **PASS** | 重なる、厳密等号 |
| `exp(a) = E(a) ≥ E_1(a) = 1 + a > 1` | `check_step1_exp_greater_than_one.sage` | `E_1(a) = a^0/0! + a^1/1! = 1 + a` を `QQ[a]` で。5 点で `E_N(a)` が `N ≤ 60` で単調非減少で `1 + a > 1` 以上（`QQ` で厳密）、`exp(a)` のボールの下端が `1 + a` 以上で 1 より大きい。対照として `a = 0` では `exp(0) = 1`、`a = -1/2` では `exp(a) < 1` | **PASS** | 全点で成り立つ |
| Step 2 の等号 `exp(y) = exp(x+(y-x)) = exp(x)exp(y-x)` | `check_step2_chain.sage` | `x + (y-x) = y` を `QQ[x,y]` で。`d := y - x` と置き、`QQ[x,d]` の部分和で全次数 14 以下で比べる。5 組の点でボールが重なる | **PASS** | 120 項で厳密等号 |
| Step 2 の不等号と最後の等号 `exp(x)exp(y-x) > exp(x)·1 = exp(x)` | `check_step2_chain.sage` | 5 組の点で、`exp(y-x)` のボールの下端が 1 より大きく、`exp(x)` のボールの下端が正で、積のボールの下端が `exp(x)` のボールの上端より大きい | **PASS** | 全組で成り立つ |
| 主張そのもの | `check_statement_with_balls.sage` | 7 組の点（差が `10^{-9}` の組と、`-74 < -73` の組を含む）で `exp(x)` のボールの上端が `exp(y)` のボールの下端より小さい。対照として、部分和 `S_2` は `-3 < -2` で大小が逆になる（`QQ` で厳密） | **PASS** | 全組で成り立つ |

## 計算の帰属と範囲

- **厳密**: 係数は `QQ`、平方根は `AA`。`E_N(a)` は本文 `real_exp_series_converges` どおり数の和として作り、行列は使わない。
  Step 2 の等号は、行列の exp が極限なので形式冪級数として全次数 14 以下の部分で比べた。
- **`ℝ` への脱出（`RealBallField(512)`）**: `E(a)`・`exp(a)` と不等号の行は、値が `QQ` に収まらないので点のボールで確かめた。
  `exp` のボールは本文の exp から作った（共通の準備 `sagemath/_shared/one_by_one_matrix.sage` の `body_real_exp_ball`）。
  `E(a)` のボールは中心 `E_320(a)`、半径 `2a^{321}/321!` である。`N + 2 ≥ 2a` のとき `0 ≤ E(a) - E_N(a) ≤ 2a^{N+1}/(N+1)!` が、
  比 `1/2` の等比級数との比較で成り立つ（本文には無く、検算の側で導いたもの）。

構成上かならず一致する比較: `E(a)` のボールと `exp(a)` のボールは、どちらも同じ部分和の値（`E_N(a) = (S_N([a]))_11` を厳密に確かめた）を中心に持つ。
そのためボールの重なりは、二つの列が同じ列であることを数値で示すにとどまる。極限の一意性そのものは `matrix_norm_triangle_inequality` (4) が担う。
同じ理由で、`E(a) - E_N(a)` の上界は `E(a)` を独立に作らず尾の評価の式の値そのものなので、この行の検算は式が `N` とともに減ることを見るだけである。
`|E_N(a) - exp(a)|` の上界は `exp(a)` のボールの半径を含むので、`N` が既定の次数（`max(150, ⌈8a⌉)`）を超えると半径で頭打ちになる（単調性の検査は等号を許す）。

範囲外のもの:

- 選んだ以外の点と、14 次を超える項。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_exp_strictly_increasing
```

実行ログは `logs/` に保存する。
