# SageMath Check: open_chain_endpoint_product_sum

## 対象

**対象ラベル**: `open_chain_endpoint_product_sum`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_005_claim_open_chain_endpoint_product_sum`（Σ_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col−1}、K ∈ ℝ）
- 範囲: Step 1（Φ の復元）、Step 2 の M_col = 2 の鎖（3 行）と M_col ≥ 3 の鎖（11 行）、exp(KE(s)) の鎖（3 行）、被加数の鎖（4 行）、主張の鎖（15 行）の全ての行と主張。

## 組み方

共通の準備は `sagemath/_shared/open_chain_spin_sums.sage`（組合せの層 `QQ[x, y]` と実数の層 `RealBallField(200)` の組み方は
`open_chain_partition_sum` の overview と同じ）。

- Step 2 の二つの鎖は ZZ で厳密に、M_col = 2..8 の全ての配置。M_col ≥ 3 の鎖の積（Π_{m=1}^{M_col−2} s(m+1) など）は
  def_finite_product_of_real_numbers の畳み込みで組み、括弧は鎖の行の括弧どおりに掛ける（M_col = 2 では因子の無い積を呼ばない）。
- M_col ≥ 3 の鎖の行ごとの根拠は、サイトの値を非可換な自由代数 QQ⟨a_1,…,a_M⟩ の生成元に取って確かめる（M_col = 3..8）。
  結合則だけで移れる 3 行目（finite_product_of_real_numbers_splits_off_first_factor）・4 行目（def_finite_product_of_real_numbers の帰納の式）・
  5〜7 行目（ℝ の乗法の結合則）・10 行目（finite_product_of_real_ones）・11 行目（ℝ の乗法の単位元 p·1 = p）は自由代数でも隣の行と一致し、可換則を使う 2 行目・8 行目（finite_product_of_real_products）は
  可換な多項式環 QQ[a_1,…,a_M] で一致する。
  5〜7 行目は、行の式から作った積を評価しない二分木でも、書いた代入の位置に結合則を 1 回当てると次の行の木になることを確かめる（M_col = 3..8）。
- exp(KE(s)) の鎖と被加数の鎖は球で M_col = 2..7、K ∈ K_SAMPLES（`open_chain_partition_sum` と同じ 8 点）。
- ς で付け替えた和は {0,1}^{M_col−1} の上の和を def_sum_over_binary_words_of_real_numbers の順序で組む。組合せの層では「ς の値」「ℝ の乗法の単位元 1·exp(K·1) = exp(K·1)」「K·1 = K」「ℝ の乗法の可換則 K(−1) = (−1)K」「real_minus_one_times_is_negation の (−1)K = −K」「real_minus_one_times_is_negation の (−1)exp(−K) = −exp(−K)」「def_real_difference の x + (−y) = x − y」の七行が隣の行と同じ多項式になるので、実数の層だけで別に組んで確かめる。
- 主張の鎖は組合せの層で厳密に（被加数を s(M_col)s(1)·Π w(t_m(s)) で直接組んだ左辺とも一致させる）、実数の層で球で。
  K = 0 では値が 0 なので、各行が 0 を含み半径が 1e-40 未満であることを見る。
- 主張は右辺を Sage の `sinh` でも確かめる。

## 証明の行との対応

| 証明の行 | 確かめ方 |
|---|---|
| Step 1: 復元が Φ の左右の逆 | 厳密。M_col = 2..8 |
| Step 2（M_col = 2）の 3 行 | 厳密（ZZ） |
| Step 2（M_col ≥ 3）の 11 行と、9 行目の根拠 s(m+1)s(m+1) = 1・10 行目の根拠 Π_{m=1}^{M_col−2}1 = 1・11 行目の根拠 s(1)·1 = s(1) | 厳密（ZZ）。M_col = 3..8。3〜7・10・11 行目は自由代数、2・8 行目は可換な多項式環でも |
| exp(KE(s)) の鎖 3 行（def_open_chain_spin_energy、ℝ の分配則、real_exp_of_finite_sum） | 球 |
| 被加数の鎖 1 行目（ℝ の乗法の可換則 s(M_col)s(1) = s(1)s(M_col)、set_and_algebra_notation）・2 行目（Step 2 の等式）・3 行目（exp(KE(s)) の鎖）・4 行目（finite_product_of_real_products） | 球 |
| 主張の鎖 1〜4 行目（直前の等式・Φ による付け替え・ς による付け替え・expansion_of_finite_product_of_two_term_sums_of_real_numbers） | 厳密（QQ[x,y]）と球 |
| 主張の鎖 5〜11 行目（ς の値・ℝ の乗法の単位元 1·exp(K·1) = exp(K·1)・K·1 = K（set_and_algebra_notation の 1·p = p・p·1 = p）・ℝ の乗法の可換則 K(−1) = (−1)K・real_minus_one_times_is_negation の (−1)K = −K・real_minus_one_times_is_negation の (−1)exp(−K) = −exp(−K)・def_real_difference） | 球。8・9 行目の根拠の等式は K ∈ K_SAMPLES で厳密（QQ）、10・11 行目の根拠の等式は QQ[x,y] で厳密 |
| 主張の鎖 12〜15 行目（u に依らない c の二元集合 {−1,1} 上の和は c + c・real_sum_of_two_equal_terms_is_twice（a → Π_m(exp(K) − exp(−K))）・def_cosh_sinh・冪の定義） | 厳密と球 |
| 主張 | 球。右辺は Sage の sinh |

否定コントロール（種類ごとに外れる件数を確かめる）: 端点の対にならない因子 s(2) を一つ残すと s(2) = −1 の配置で外れる（252 件）、端点因子を落とすと cosh の側の値になって外れる（7 件）、
二元集合の和で符号を落とすと外れる（7 件）、右辺を cosh にすると外れる（42 件）、
Step 2（M_col ≥ 3）の可換則を使う 2 行目・8 行目は自由代数では隣の行と一致しない（M_col = 4..8 で 10 件。M_col = 3 では因子の並びが変わらない）。

浮動小数点（球）を使うのは exp の値を含む行だけである（ℝ への脱出）。検算は上の範囲に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | Step 1・Step 2・被加数・主張の鎖の全ての行、主張、否定コントロール | 実行済み | PASS（23118 件、否定コントロール 318 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh open_chain_endpoint_product_sum
```
