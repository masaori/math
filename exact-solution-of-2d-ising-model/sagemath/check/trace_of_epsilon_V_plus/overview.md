# SageMath Check: trace_of_epsilon_V_plus

## 対象

**対象ラベル**: `trace_of_epsilon_V_plus`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_006_theorem_trace_of_epsilon_V_plus`（tr(εV^{(+)}) = (2exp(−K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}。等号は左辺 ∈ ℂ が右辺 ∈ ℝ の像 (·)_ℂ に等しいこと）
- 範囲: 証明の準備 (P1)〜(P5)、Step 1〜6 の全ての鎖の行と、行の根拠に引いた主張の個々の場合と、主張。

## 組み方

- σ_m^z・σ_m^x・ε・Y_m・Z_m・H_1^{(+)} は `_shared/pauli_sites_exact.sage`（def_kronecker (2) の成分の式と mat_mult の成分の式）で QQ(i) に組む。D_0・G は def_D0_open_chain_operator・def_G_boundary_operator の式、V_2 は def_transfer_matrix の成分（行・列を ord で指す）、f_I は def_end_iso の e_{i_1}⊠⋯⊠e_{i_M} を def_kronecker (1) の数ベクトルの成分の式で組む。積・スカラー倍・和は本文の定め方の成分の式（`_shared` の `body_*`）。
- **厳密計算の選び方**: 結合定数を K_1 := 2 log p、K_2 := log q（p, q は 1 より大きい有理数、3 組）と置くと、exp(K_1n/2) = p^n、exp(K_2n) = q^n、cosh K_1・sinh K_1 が QQ に入る。行列の exp は、整数の固有値を持ち対角化できる行列 S（iH_1^{(+)}、D_0 + εG、D_0、εG、G）について、スペクトル射影 P_λ による Σ_λ exp(cλ)P_λ として QQ(i) で厳密に組む（Σ P_λ = I と SP_λ = λP_λ を確かめてから使う）。B・V_1^{(+)}・exp(κD_0)・exp(κ(εG))・exp(κD_0 + κ(εG)) はそれぞれ別の行列のスペクトル射影から組むので、theorem_exp_product の行は二つの独立な経路の一致を見ている。ℝ への脱出は「K の選び方」の一点だけで、等号の判定は全て QQ(i) で行う。
- 準備の (P1)〜(P4) と級数の偶奇の分け方は、κ := (K_1)_ℂ を不定元にした QQ(i)[κ] で厳密に（K_1 の値によらない）。
- 主張は、K_1 = 1/3, 1, 7/4、K_2 = 2/5, 1/2, 3/10 で、ComplexBallField の行列の exp で組んだ V_1^{(+)}・(V_1^{(+)})^{1/2}（中身の H_1^{(+)} は本文の式の `H1_plus`）、exp の実数のボールで組んだ V_2（行・列は ord）、Sage の tensor_product と `*` で組んだ ε から V^{(+)} を作って、スペクトル射影を通らずに確かめる（ボール）。
- スペクトル射影で組んだ V_1^{(+)}・B・exp(κD_0)・exp(κ(εG)) が def_exp の級数の値と一致することは、M_col = 2, 3 で ComplexBallField の行列の exp のボールと重なることで直接確かめる。

## 証明の行との対応

表の「◯行目」は、その鎖の◯番目の等号を指す。M_col = 2..5、(p, q) = (2, 3/2), (3/2, 5/4), (5/3, 2) の 12 組を「厳密」と書く。

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備の記号・𝔐 の上の和（ord による） | `check_chain.sage` の `sum_over_configs` | 和を本文の定め方どおり k = 1..2^M の順に組み、tr(X) = Σ_s X_{ord(s),ord(s)} を確かめる（厳密） |
| (P1) の 4 行 | `check_symbolic_and_balls.sage` | QQ(i)[κ]、M_col = 2, 3, 4。根拠の H1_plus_in_sigma_z_form は `check_chain.sage` でも厳密に |
| (P2) の鎖 5 行と、κ を掛けた可換性 3 つ | `check_symbolic_and_balls.sage` | QQ(i)[κ]。根拠の epsilon_D0_G_pairwise_commute は `check_chain.sage` で |
| (P3) 奇数の冪の 3 行・偶数の冪の 4 行 | `check_symbolic_and_balls.sage` | j = 0..4 で厳密 |
| (P4) の 6 行 | `check_symbolic_and_balls.sage` | n = 0..9 で厳密（κ は不定元） |
| (P5) の 3 行と場合分け、列の読み取りの 4 行 | `check_chain.sage` | 全ての s, s' と D_0・G・ε の列で厳密。列の読み取りの 2 行目は finite_sum_with_single_nonzero_term の仮定（ord(s) 以外の項が 0）も確かめる。(P5) の 2 行目は f_I の定義を読む行で、両辺を同じ成分の式から作るので一致を見るだけである |
| Step 1 の 6 行と、巡回性の当て方の 2 つ | `check_chain.sage` | 厳密。根拠 εB = Bε、BB = V_1^{(+)}、εV_1^{(+)} = V_1^{(+)}ε も |
| Step 2 の V_1^{(+)} の 2 行 | `check_chain.sage` | 厳密（三つの別々のスペクトル射影の exp の一致） |
| Step 2 の T_n の仮定 | `check_symbolic_and_balls.sage` | n = 0..10 で T_n = κ^nI（偶数）、(1_ℂκ^n)(εG)（奇数）を厳密に |
| Step 2 の exp(κ(εG)) の 3 行 | `check_chain.sage`、`check_symbolic_and_balls.sage` | 1 行目（def_exp の級数）は部分和 N = 10 の偶奇の分け方を QQ(i)[κ] で厳密に。2・3 行目は値を厳密に（スペクトル射影の exp と cosh I + sinh εG の一致）。級数の極限の扱いそのものは exponential_series_of_even_odd_power_terms の検算が受け持つ |
| Step 2 の εV_1^{(+)} の 11 行 | `check_chain.sage` | 厳密。根拠 εexp(κD_0) = exp(κD_0)ε も |
| Step 3 (a) の D_0・G の 4 行、exp(κD_0) の対角成分の 2 行と対角性 | `check_chain.sage` | 全ての s, s' で厳密 |
| Step 3 (a) の κD_0 の対角性と対角成分の 2 行 | `check_symbolic_and_balls.sage` | κ を不定元にして厳密。2 行目の real_inclusion_preserves_product は K_1 = 7/4 で厳密 |
| Step 3 (b) εf_{ι(s)} = f_{ι(−s)} と ε の成分の 3 行 | `check_chain.sage` | 全ての s, s' で厳密 |
| Step 3 (c) V_2 の成分と二つの特別な場合 | `check_chain.sage` | 厳密 |
| Step 4 の第 1 項の 7 行・第 2 項の 7 行 | `check_chain.sage` | 全ての s で厳密。第 1 項の 2 行目の根拠（ε の第 ord(s) 行が ord(−s) 以外 0）と第 2 項の 2 行目の根拠（G の第 ord(s) 行が対角以外 0）も |
| Step 5 の二つのトレースの鎖（4 行ずつ） | `check_chain.sage` | 厳密 |
| Step 5 の tr(εV^{(+)}) の 11 行 | `check_chain.sage` | 厳密 |
| Step 5 の実数の鎖の 8 行 | `check_chain.sage` | 厳密（QQ）。x^n は Π の左からの積で、exp(Σ(∓K_2)) は指数を和として組む（この行は exp(∓K_2M_col) = q^{∓M} と同じ値を作る定義の行で、一致を見るだけである）。根拠の open_chain_partition_sum・open_chain_endpoint_product_sum（K = K_1）も |
| Step 6 | `check_chain.sage` | S_cosh, S_sinh > 0、cosh K_1 > sinh K_1 > 0、exp(∓K_2M_col) > 0、二項と和が正を厳密に |
| 主張 | `check_chain.sage`、`check_symbolic_and_balls.sage` | 厳密（12 組）と、Sage の経路だけのボール（M_col = 2..5、3 組。虚部が 0 を含み実部が右辺と重なること、右辺の下端 > 0） |

否定コントロールのうち、誤りを見つける力があるのは、ε を除いた tr(V^{(+)}) が値と違うこと、exp(κ(εG)) で cosh と sinh を入れ替えると違うこと、Step 4 で (V_2)_{−s,s} を (V_2)_{s,s} に替えると違うこと、exp(κ(εG)) を exp(κG) に替えると違うこと、K_2 の符号を入れ替えた式・因子 2 を落とした式と違うこと、S_cosh が 2(2sinh K_1)^{M−1} と違うことである。記号計算の側の κ(εG) ≠ κG、D_0ε ≠ ε(εG)、ボールの側の exp(κD_0) と exp(κ(εG)) が離れることは、比べ方が等号を見分けていることを確かめるだけである。

浮動小数点の値を使うのは `check_symbolic_and_balls.sage` の (2)・(3) だけで、全てボール（256 ビットの区間演算）であり、丸めの誤差も半径に入る。等しいはずのものは重なること、等しくないはずのものは離れることを見る。半径が右辺の 10^{-30} 倍未満であることも確かめる。証明は M_col ∈ ℤ_{≥2}、K_1, K_2 ∈ ℝ_{>0} の全てについてのものだが、検算は上に書いた M_col と結合定数に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | (P5)、Step 1〜6 の全ての鎖、根拠の個々の場合、主張、否定コントロール | 実行済み | PASS（等号・主張 3732 件、否定コントロール 84 件） |
| `check_symbolic_and_balls.sage` | (P1)〜(P4)・κD_0 の対角成分と級数の偶奇の分け方（QQ(i)[κ]）、主張のボールによる独立の確かめ、スペクトル射影の exp と行列の exp のボールの比較 | 実行済み | PASS（等号・主張 408 件、否定コントロール 36 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh trace_of_epsilon_V_plus
```

（`trace_of_epsilon_V_plus_via_check_eigenvalues` も名前に一致するので一緒に走る。）
