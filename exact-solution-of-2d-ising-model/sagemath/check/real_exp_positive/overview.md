# SageMath Check: real_exp_positive

## 対象

**対象ラベル**: `real_exp_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_010_claim_real_exp_positive`（`x ∈ ℝ` について `exp(x) > 0`）
- 範囲: Step 1 の二つの鎖、Step 2 の鎖、最後の結論、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 1 の鎖 `exp(x)exp(-x) = exp(x+(-x)) = exp(0) = 1` | `check_step1_product_with_negative.sage` | 各辺を `QQ[x]` の 1 行 1 列の行列の部分和で作り、全次数 20 以下で比べる（`exp(-x)` は `[-x]` の部分和で作る）。`exp(0)` は `[0]` の部分和が `N ≤ 30` で厳密に `[1]` であること。値として、6 点で本文の exp のボールの積が 1 を含む。対照として `exp(x)^2 ≠ 1` | **PASS** | 21 項で厳密等号、ボールの半径 `< 2^{-200}` |
| Step 1 の背理法の鎖 `1 = exp(x)exp(-x) = 0·exp(-x) = 0` と `1 ≠ 0` | `check_step1_product_with_negative.sage` | `QQ[e,f]` で `e = 0` を代入すると `e·f = 0·f = 0` | **PASS** | 厳密等号 |
| Step 2 の等号の三行 `exp(x) = exp(x/2+x/2) = exp(x/2)exp(x/2) = (exp(x/2))^2` | `check_step2_square.sage` | 各辺を `QQ[x]` の部分和で作り全次数 20 以下で比べる。平方は数の冪の定義で作る。対照として `exp(x) ≠ 2exp(x/2)` | **PASS** | 21 項で厳密等号 |
| Step 2 の最後の行 `(exp(x/2))^2 ≥ 0` | `check_step2_square.sage` | 6 点で、`exp(x/2)` の実数のボールの平方が `exp(x)` のボールと重なる。平方の下端が 0 以上であることも見るが、Arb の偶数冪は下端を 0 未満にしないのでこの部分は必ず通り、意味があるのは重なりの側である。「実数の平方は非負」そのものは順序体の性質で、検算の対象ではない | **PASS** | 全点で成り立つ |
| 結論と主張そのもの `exp(x) > 0` | `check_statement_with_balls.sage` | 9 点（`x = -74` まで）で本文の exp のボールの下端が正。対照として、部分和 `S_1(-2)`・`S_3(-5)`・`S_9(-10)` の成分は負（`QQ` で厳密）なので、正であることは部分和からは従わない | **PASS** | 最小は `x = -74` で約 `7.28·10^{-33}` |

## 計算の帰属と範囲

- **厳密**: 係数は `QQ`。等号の行は、1 行 1 列の行列の exp が極限なので多項式環に収まらない。そこで形式冪級数として全次数 20 以下の部分で比べた。
  `exp([x])` の 20 次までの部分は部分和 `S_20([x])` の 20 次までの部分に等しい（`m > 20` の項は次数 `m` なので落ちる）。
- **`ℝ` への脱出（`RealBallField(512)`）**: 主張の値 `exp(x)` と、Step 2 の不等号「実数の平方は非負」は、値が `QQ` に収まらないので点のボールで確かめた。
  ボールは Arb の exp ではなく本文の exp から作った（共通の準備 `sagemath/_shared/one_by_one_matrix.sage` の `body_real_exp_ball`。
  中心は部分和 `S_N([x])` の成分を `QQ` で厳密に、半径は尾の評価 `2|x|^{N+1}/(N+1)!`。尾の評価は本文には無く、検算の側で導いたもの）。

範囲外のもの:

- 形式冪級数としての一致から値の一致へ移る論証は `scalar_exp_product` と `scalar_exp_zero` が担う。検算はそれらを当てた行の展開の一致を確かめた。
- 選んだ以外の点と、20 次を超える項。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_exp_positive
```

実行ログは `logs/` に保存する。
