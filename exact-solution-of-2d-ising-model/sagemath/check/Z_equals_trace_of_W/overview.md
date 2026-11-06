# SageMath Check: Z_equals_trace_of_W

## 対象

**対象ラベル**: `Z_equals_trace_of_W` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_002_claim_Z_equals_trace_of_W`（`(Z(K_1,K_2))_ℂ = tr(W^{N_row})`）
- 範囲: 証明の準備 1〜3 の全ての行、本体の鎖の 6 等号、最後の `(Z(K_1,K_2))_ℂ = tr(W^{N_row})` の 2 等号、主張

記号は証明のとおり `B := V_1^{1/2}`、`W = (BV_2)B`、行列の冪は `def_exp` (1) の `X^0 := I`、`X^{m+1} := X^m X`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 2 `(X(YX)^k)Y = (XY)^{k+1}` の `k = 0` の鎖 5 等号と、`k → k+1` の鎖 6 等号 | `check_open_product_power.sage` | 各行を本文の括弧どおりに組み、隣の行と厳密に比べる。`k = 0..4`。帰納法の仮定の行は、`k` での主張を同じ行列で確かめてから使う。冪は `def_exp` (1) の再帰で組み、Sage 組み込みの冪とも一致を見る。対照: `(X(YX)^k)Y ≠ (YX)^{k+1}`（積の順序が効く比較であること） | **PASS** | 140 等号 |
| 準備 3 `W^{k+1} = ((B(V_2V_1)^k)V_2)B` の `k = 0` の鎖 6 等号と、`k → k+1` の鎖 12 等号 | `check_W_power.sage` | 準備 1 を満たす一般の組（`B`・`V_2` を独立に取り `V_1 := BB`、`W := (BV_2)B`）で、各行を括弧どおりに組んで比べる。`k = 0..3`。対照: `V_1` を `B` と独立に取ると、`BB = V_1` に依る行（準備 1 を引く `(CV_2)(BB) = (CV_2)V_1` と、帰納法の仮定の行）だけが崩れる | **PASS** | 216 等号 |
| 準備 1 `BB = V_1`（`def_transfer_matrix_square_root`）と `W = (BV_2)B`（`def_symmetrized_transfer_matrix`） | `check_claim_with_transfer_matrices.sage` | 本文の行列そのもので、`B = exp((1/2)K_1D)` を `D` のスペクトル射影から、`V_1` を `def_transfer_matrix` の成分の式から別経路で組み、`BB = V_1` を厳密に比べる。`M_col = 1, 2, 3`。`W = (BV_2)B` は定義の書き写しなので同じ式で組むだけである | **PASS** | 成り立つ |
| 本体の鎖 `tr((V_1V_2)^n) = ⋯ = tr(W^n)` の 6 等号 | `check_main_chain.sage` | 準備 1 を満たす一般の組で、`n = 1..6`、各行のトレースを隣の行と比べる。対照: 巡回性の行の両側の行列（トレースを取る前）は一般に異なる。`V_1` を独立に取ると、`BB = V_1` に依る等号（準備 1 を引く第 1→2 等号と、準備 3 を引く第 5→6 等号）だけが崩れる | **PASS** | 144 等号 |
| 主張 `tr((V_1V_2)^n) = tr(W^n)` と `(Z(K_1,K_2))_ℂ = tr(W^{N_row})` | `check_claim_with_transfer_matrices.sage` | 本文の `V_1, V_2, B` で `n = 1..4`（`M_col = 1, 2, 3`）。`Z` は `def_partition_function_2d_ising` を全配位の和として転送行列を経由せずに計算し、`(N_row, M_col) ∈ {(1,1),(1,2),(2,1),(2,2),(2,3),(3,2),(3,3),(4,2)}` で `tr(W^{N_row})` と比べる。対照: 平方根でない `B' := V_1`（`B'B' ≠ V_1`）で `W' := (B'V_2)B'` と置くと、`n = 1..4` のどれでも `tr((V_1V_2)^n) ≠ tr(W'^n)` | **PASS** | 成り立つ |

`(Z(K_1,K_2))_ℂ = tr((V_1V_2)^{N_row})` の行は `partition_function_via_transfer_matrix` の適用で、その検算は
`sagemath/check/252_partition_function_via_transfer_matrix/` にある。ここでは主張の行で `Z` を定義から直接計算して両端を比べた。

## 計算の帰属と範囲

- **厳密**: 一般の行列は、成分を `QQ` 上の多項式環の不定元に置いたもの（1 次と 2 次）と、`QQ(i)` の乱数行列（3 次と 4 次。種を固定）。
  不定元で成り立つ等号は成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
- **本文の行列**: `exp(K_1/2)`・`exp(K_2)` を有理関数体 `QQ(q,r)` の不定元 `q, r` に置いた。`B = exp((1/2)K_1D)` は `D` の整数の固有値 `λ` の
  スペクトル射影で `exp((1/2)K_1λ) = q^λ` として、`V_1`・`V_2` の成分の `exp(K_1n)`・`exp(K_2n)` は `q^{2n}`・`r^n` として組んだ。
  実数の exp の指数法則（`exp(K_1/2)^{2n} = exp(K_1n)` など）を前提にした置き方で、ℝ への脱出はこの置き方の一点に閉じる。浮動小数点は使わない。
- 結合律の行（`mat_mult_associative`）: Sage の行列の積は結合的なので、括弧の位置だけが違う二行は必ず等しくなる。この検算が確かめるのは、その行で因子の並びが変わっていないことであって、括弧の付け替えそのものではない（括弧の付け替えの正しさは `mat_mult_associative` の検算と人手証明が担う）。
- 範囲外: 一般の行列の次数 5 以上、`k ≥ 5`（準備 2）・`k ≥ 4`（準備 3）・`n ≥ 7`（本体）、`M_col ≥ 4`。一般の場合は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh Z_equals_trace_of_W
```

実行ログは `sagemath/check/Z_equals_trace_of_W/logs/` に保存する。
