# SageMath Check: scalar_exp_product

## 対象

**対象ラベル**: `scalar_exp_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_008_claim_scalar_exp_product`（`exp(x)exp(y) = exp(x+y)`）
- 範囲: 証明の準備の三つの事実と、五行の等号の鎖、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の四つの鎖 `(AB)_11 = Σ_{j=1}^{1}A_1jB_j1 = A_11B_11`、`([x][y])_11 = ([x])_11([y])_11 = xy = yx = ([y])_11([x])_11 = ([y][x])_11`、`[x][y] = [([x][y])_11] = [([y][x])_11] = [y][x]`、`[x]+[y] = [([x]+[y])_11] = [([x])_11+([y])_11] = [x+y]` | `check_one_by_one_preparation.sage` | 各鎖の全ての辺を不定元の 1 行 1 列の行列で作り、Sage の積・和と、積の成分の和を直接書いたものを比べる。対照として 2 行 2 列の一般の行列は可換でない | **PASS** | 厳密等号 |
| 五行の鎖 `exp(x)exp(y) = (exp[x])_11(exp[y])_11 = (exp[x]exp[y])_11 = (exp([x]+[y]))_11 = (exp[x+y])_11 = exp(x+y)` | `check_chain_truncated_series.sage` | 各辺を `x, y` の全次数 14 以下の項で比べる。第一辺と最後の辺は Sage の多変数形式冪級数の `exp`、途中の辺は 1 行 1 列の行列の部分和で作る | **PASS** | 120 項で厳密等号 |
| 主張そのもの | `check_statement_with_balls.sage` | 本文の exp（1 行 1 列の行列の exp の成分）の値を含むボール（中心は部分和 `S_150([x])` の成分を `QQ(i)` で厳密に、半径は尾の評価 `2|x|^{151}/151!`）を作り、具体の 7 組の点で両辺のボールが重なる。対照として、可換でない 2 行 2 列の `A, B` で `exp(A)exp(B)` と `exp(A+B)` の (1,1) 成分が重ならない | **PASS** | 差の上界 `< 2^{-300}` |

## 計算の帰属と範囲

- **厳密**: 係数は `QQ`（`K = R`）と `QQ(i)`（`K = C`）。準備は多項式環の不定元で確かめた。
  五行の鎖は行列の exp が極限なので多項式環に収まらない。そこで形式冪級数として、全次数 14 以下の部分で比べた。
  `exp([x])` の 14 次までの部分は部分和 `S_14([x])` の 14 次までの部分に等しい（`m > 14` の項は全次数 `m` なので落ちる）ので、
  この比較は形式冪級数の等号の 14 次までの部分を厳密に確かめる。
- **`R` への脱出（`ComplexBallField(512)`）**: 主張の値 `exp(x)` は可算な係数に収まらないので、主張そのものを点で確かめる検算だけボールを使った。
  ボールは Arb の exp ではなく本文の exp から作った。本文の `exp(x)` がこのボールに入るのは、`scalar_exp_is_limit_of_partial_sums` の収束
  `S_M → exp(x)` と、`M > N` のときの尾の評価 `|S_M - S_N| ≤ 2|x|^{N+1}/(N+1)!`（`N + 2 ≥ 2|x|` のとき、比 `1/2` の等比級数との比較で成り立つ。
  本文には無く、検算の側で導いたもの）を `M → ∞` で合わせるからである。
  等号は両辺のボールが重なること、対照の不等号は重ならないことで確かめた。対照の `cosh(1)`・`sinh(1)` は Arb の値である。

構成上かならず一致する比較: `check_chain_truncated_series.sage` の第四辺 `E([x]+[y])` と第五辺 `E([x+y])` は Sage 上で同じ行列から作られる
（`[x]+[y] = [x+y]` は `check_one_by_one_preparation.sage` で確かめた）。`check_one_by_one_preparation.sage` の `xy = yx` は、可換な多項式環では同じ元である
（`K` の積の可換性を使う行であり、検算は両隣の `([x][y])_11` と `([y][x])_11` が Sage の行列の積として一致することを確かめる）。

範囲外のもの:

- 形式冪級数としての一致から収束する級数の値の一致へ移る論証は、`theorem_exp_product` が担う。検算は、そこで使う可換性が 1 行 1 列で成り立つこと（準備）と、各行の展開の 14 次までの一致を確かめた。
- 選んだ以外の点と、14 次を超える項。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh scalar_exp_product
```

共通の準備は `sagemath/_shared/one_by_one_matrix.sage`。実行ログは `logs/` に保存する。
