# SageMath Check: open_chain_endpoint_product_sum

## 対象

**対象ラベル**: `open_chain_endpoint_product_sum`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_005_claim_open_chain_endpoint_product_sum`（Σ_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col−1}、K ∈ ℝ）
- 範囲: Step 1（Φ の復元）、Step 2 の M_col = 2 の鎖（3 行）と M_col ≥ 3 の鎖（4 行）、exp(KE(s)) の鎖（3 行）、被加数の鎖（4 行）、主張の鎖（12 行）の全ての行と主張。

## 組み方

共通の準備は `sagemath/_shared/open_chain_spin_sums.sage`（組合せの層 `QQ[x, y]` と実数の層 `RealBallField(200)` の組み方は
`open_chain_partition_sum` の overview と同じ）。

- Step 2 の二つの鎖は ZZ で厳密に、M_col = 2..8 の全ての配置。M_col ≥ 3 の 2 行目は s(1)·Π_{m=2}^{M_col−1} s(m)s(m)·s(M_col) を、3 行目は 1 の有限積を、
  def_finite_product_of_real_numbers の畳み込みで組む（M_col = 2 では因子の無い積を呼ばない）。
- exp(KE(s)) の鎖と被加数の鎖は球で M_col = 2..7、K ∈ K_SAMPLES（`open_chain_partition_sum` と同じ 8 点）。
- ς で付け替えた和は {0,1}^{M_col−1} の上の和を def_sum_over_binary_words_of_real_numbers の順序で組む。組合せの層では「ς の値」「1·b = b」「a·1 = a」「a(−1) = −a」「a + (−1)b = a − b」の五行が隣の行と同じ多項式になるので、実数の層だけで別に組んで確かめる。
- 主張の鎖は組合せの層で厳密に（被加数を s(M_col)s(1)·Π w(t_m(s)) で直接組んだ左辺とも一致させる）、実数の層で球で。
  K = 0 では値が 0 なので、各行が 0 を含み半径が 1e-40 未満であることを見る。
- 主張は右辺を Sage の `sinh` でも確かめる。

## 証明の行との対応

| 証明の行 | 確かめ方 |
|---|---|
| Step 1: 復元が Φ の左右の逆 | 厳密。M_col = 2..8 |
| Step 2（M_col = 2）の 3 行 | 厳密（ZZ） |
| Step 2（M_col ≥ 3）の 4 行と 3 行目の根拠 s(m)s(m) = 1 | 厳密（ZZ）。M_col = 3..8 |
| exp(KE(s)) の鎖 3 行（def_open_chain_spin_energy、ℝ の分配則、real_exp_of_finite_sum） | 球 |
| 被加数の鎖 1 行目（ℝ の可換性）・2 行目（Step 2 の等式）・3 行目（exp(KE(s)) の鎖）・4 行目（finite_product_of_real_products） | 球 |
| 主張の鎖 1〜4 行目（直前の等式・Φ による付け替え・ς による付け替え・expansion_of_finite_product_of_two_term_sums_of_real_numbers） | 厳密（QQ[x,y]）と球 |
| 主張の鎖 5〜9 行目（ς の値・1·b = b・a·1 = a・a(−1) = −a・a + (−1)b = a − b） | 球 |
| 主張の鎖 10〜12 行目（c + c = 2c・def_cosh_sinh・冪の定義） | 厳密と球 |
| 主張 | 球。右辺は Sage の sinh |

否定コントロール（種類ごとに外れる件数を確かめる）: 端点の対にならない因子 s(2) を一つ残すと s(2) = −1 の配置で外れる（252 件）、端点因子を落とすと cosh の側の値になって外れる（7 件）、
二元集合の和で符号を落とすと外れる（7 件）、右辺を cosh にすると外れる（42 件）。

浮動小数点（球）を使うのは exp の値を含む行だけである（ℝ への脱出）。検算は上の範囲に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | Step 1・Step 2・被加数・主張の鎖の全ての行、主張、否定コントロール | 実行済み | PASS（18340 件、否定コントロール 308 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh open_chain_endpoint_product_sum
```
