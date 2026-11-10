# SageMath Check: recover_Z_Y_from_check_Z_Y

## 対象

**対象ラベル**: `recover_Z_Y_from_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evensector_006_claim_recover_Z_Y`（Ž・Y̌ から Z_j・Y_j を復元する）
- 範囲: 準備 1 の 2 等号の鎖、準備 2 の実数の鎖（4 等号）と複素数の鎖（5 等号）、第 1 式・第 2 式（各 13 等号）、主張の「とくに」（生成）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1（k ≠ j で 0 < \|j−k\| < M、`(Σ_μ exp(i((j−k)_R θ̃_μ)_C))A = 0_C A = O`）、第 1 式・第 2 式の 13 等号（定義、`finite_sum_of_scalar_multiples`、`scalar_multiple_is_associative`、`finite_double_sum_of_matrices_interchange`、`finite_sum_of_scalar_multiples_of_one_matrix`、`scalar_exp_product`、準備 2、`finite_sum_of_matrices_with_single_nonzero_term`、j−j=0、`antiperiodic_exp_sum`、`scalar_multiple_is_associative`、逆元、`scalar_multiple_by_one`） | `check_two_chains.sage` | M = 2..5、全ての j、Z と Y で、Z_j・Y_j をクロネッカー積と積の成分の式で組み、位相を円分体 `QQ(ζ_{4M})` の 1 の冪根に持って、各行の行列を本文の成分の式で組んで隣と厳密に比べる。k ≠ j の項が O であること（単一の非零項の仮定）も確かめる。主張を Sage の行列演算とも比べる。対照: f の符号を反転すると復元できない j がある | **PASS** | 成り立つ |
| 準備 2 の実数の鎖 `j_Rx + (−(k_Rx)) = … = (j_Z−k_Z)_R x` と複素数の鎖 `i(j_Rx)_C + (−i)(k_Rx)_C = … = i((j_Z−k_Z)_R x)_C`（1・2 行目は `negative_i_times_complex_is_negation_of_i_times`・`i_times_negated_real_is_negation_of_i_times` の参照） | `check_exponent_chains.sage` | x・j・k を不定元にした `QQ` 上の有理関数体で実数の行を、ℂ を本文どおり実数の対にして複素数の行を組み、隣と比べる。参照先の 2 つの主張も、この鎖で当てる値で両辺を比べる。対照: −i の符号を落とすと右辺と一致しない | **PASS** | 成り立つ |
| 位相の 1 の冪根による表し方、`scalar_exp_product` の行、準備 2 の行、`antiperiodic_exp_sum` の「とくに」の行、係数の取り出し | `check_exp_balls.sage` | M = 2..8、全ての j, k, μ で、本文の exp の部分和に尾の上界を半径として足したボール（512 bit）が、1 の冪根の値と重なり、積と和の exp が重なり、和が j = k で M、j ≠ k で 0 を含むことを見る。対照: f の符号を反転すると和が Mδ_{jk} にならない組がある | **PASS** | 成り立つ |
| 主張の「とくに」（Ž・Y̌ を含み (ii)〜(iv) を満たす部分集合は全体）と、証明の論法（Z_j・Y_j が Ž・Y̌ から作れる） | `check_generation.sage` | M = 2, 3 で、I・Ž_μ・Y̌_μ から右へ積を繰り返して張る部分空間（(ii)〜(iv) を満たし Ž・Y̌ を含む最小の集合）の次元が 4^M であり、Z_j・Y_j を含むことを円分体の線型代数で厳密に確かめる。対照: Ž だけから張ると全体にならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 準備 1 と二つの主鎖（円分体の行列）、準備 2（有理関数体と実数の対）、生成（円分体の線型代数）。
- **ℝ への脱出**: `check_exp_balls.sage` の本文の exp のボールと π（`RB.pi()`）。重なりは等号の必要条件であって証明ではない。`check_two_chains.sage` の第 6・7・9 行の exp の値は、指数の有理数から 1 の冪根で作り直したもので、1 の冪根の表し方（Euler の公式を前提にする）と `scalar_exp_product`・準備 2・`antiperiodic_exp_sum` の中身はこのボールが担う。
- **作り方で自明な比較**: 定義を当てはめる行（第 1 等号）と、1_C を掛ける最後の行は、両辺を同じ定義の式から作るので比較は値が通ることを見るだけである。準備 2 の実数の鎖は、有理関数体が分配律・−(ab) = (−a)b で並べ替えた式を同じ元にするので中身を持たない（値が通ることを見るだけ）。
- 範囲外: 主鎖で M_col ≥ 6（2^M 次の行列の成分の式の計算量のため）、ボールで M_col ≥ 9、生成で M_col ≥ 4。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh recover_Z_Y_from_check_Z_Y
```

実行ログは `logs/` に保存する。
