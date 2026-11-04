# SageMath Check: V_plus_is_invertible

## 対象

**対象ラベル**: `V_plus_is_invertible`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_claim_V_plus_is_invertible`（R^{(+)} := ((2s_2)^{-M_col/2})_ℂ exp(−(1/2)S_1^{(+)}) exp(−S_2) exp(−(1/2)S_1^{(+)}) について V^{(+)}R^{(+)} = R^{(+)}V^{(+)} = I）
- 範囲: 主張の置き方（(2s_2)^{-M_col/2} は (2s_2)^{M_col/2} の ℝ の逆数、−(1/2)S_1^{(+)} は符号反転）、証明の Step 1（四つの左右逆の鎖）、Step 2（a の置き方と 18 行の鎖）、Step 3（18 行の鎖）、最後の二行の全てと、主張そのもの。
- 記号: X_1 := (1/2)S_1^{(+)}、E_+ := exp(X_1)、E_- := exp(−X_1)、A_+ := exp(S_2)、A_- := exp(−S_2)（−X_1・−S_2 は def_matrix_negation の符号反転）、a := (2s_2)^{M_col/2}、X := (E_+A_+)E_+、Y := (E_-A_-)E_-。
  H_1^{(+)}・H_2・Z_m・Y_m・V_2 の成分は共有の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage` から読み込む。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の E_+E_-・A_+A_- の鎖の 2 行目（`matrix_double_negation`、A → X_1・S_2） | `check_exact_factors.sage` (a)(b)、`check_balls_by_partial_sums.sage` | 中身は (a) の −(−X_1) = X_1・−(−S_2) = S_2（`KG[K_1, K_2^*]` で厳密）。(b) とボール版の exp(X_1)exp(−X_1) と exp(−(−X_1))exp(−X_1) の比較は、二重の符号反転が元と成分まで同じ行列になるので構成上一致する（下の「構成上かならず一致する比較」） |
| Step 1 の四つの鎖の最後の行（`exp_of_negative_is_left_inverse`、A → −X_1・X_1・−S_2・S_2） | 両方 | exp(−(−X_1))exp(−X_1)・exp(−X_1)exp(X_1) などが I（厳密とボール。ボール版は exp_of_negative_is_left_inverse の中身を def_exp の級数で確かめることになる） |
| 主張の (2s_2)^{-M_col/2} の置き方と Step 2 の a ∈ ℝ_{>0}（`def_second_transfer_matrix_prefactor`）、a^{-1} = (2s_2)^{-M_col/2}、包含 a_ℂ・(a^{-1})_ℂ | `check_exact_factors.sage` (b)、`check_real_coefficient_lines.sage`、`check_balls_by_partial_sums.sage` | a を (√(2s_2))^M として AA で作り a > 0。a^{-1} は a の ℝ の逆数とし、別の経路 √((2s_2)^{-M})（ボール版は実数冪）と一致することを見る。包含は QQbar の (r, 0) を実部・虚部で |
| Step 2 の 18 行の鎖（表示、スカラー倍の外出し 2 行、`scalar_multiple_is_associative`、`real_inclusion_preserves_product`、ℝ の aa^{-1} = 1、1_ℂ の略記、`scalar_multiple_by_one`、`mat_mult_associative` 3 行、Step 1 の第一、左単位元、結合律、Step 1 の第三、右単位元、Step 1 の第一） | `check_exact_factors.sage` (b)、`check_balls_by_partial_sums.sage`、`check_chains_with_generic_invertible_factors.sage`、`check_real_coefficient_lines.sage` | 実際の E_±・A_± で本文の括弧どおりに隣り合う行を比べる（厳密とボール）。係数の 2〜8 行目は虚部を持つ一般の行列でも、行列の段は一般の可逆行列でも |
| Step 3 の 18 行の鎖（Step 2 で a と a^{-1}、E_+ と E_-、A_+ と A_- を入れ替えたもの。Step 1 の第二・第四を使う） | 同上 | 同上 |
| 最後の二行（Step 2・Step 3 の二つの積と `def_invertible_elements_of_R` の可逆の定義から V^{(+)} ∈ R^×、逆元の一意性と記号 g^{-1} から (V^{(+)})^{-1} = R^{(+)}） | `check_exact_factors.sage` (b)、`check_balls_by_partial_sums.sage` | def_V_plus の (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}（V_2 は成分の定義）から作った V^{(+)} が a_ℂX に等しいことと、主張の R^{(+)} との積が左右とも I になること、Sage の `inverse` が R^{(+)} に一致すること（厳密版。積は Sage の `*` で、本文の成分の式とは独立な経路） |

否定コントロール:
- (a): −X_1 ≠ X_1、−S_2 ≠ S_2（符号反転を一回だけ施すと元に戻らない）。M_col = 2..5。
- (b) とボール版: E_+E_+・A_+A_+ は I でない。R^{(+)} の係数を a にしたもの、A_- を A_+ にしたものは逆行列にならない。
  厳密版では因子の順を E_-E_-A_- にしたものも逆行列にならない。
- `check_real_coefficient_lines.sage`: 係数を a, a で回すと ℝ の cd = 1 を引く段だけが外れる。
- `check_chains_with_generic_invertible_factors.sage`: 左右逆の組を取り違えると単位行列にならない。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- 厳密版の Step 2・Step 3 の 1 行目→2 行目（V^{(+)} と R^{(+)} の表示）は、両辺を同じ式 a_ℂX・(a^{-1})_ℂY から作る（ボール版の鎖はこの行を持たない）。
  V^{(+)} の側は、def_V_plus（V_2 は成分の定義）から作った V^{(+)} が a_ℂX に等しいことを別に確かめている。
  R^{(+)} の側は主張の置き方そのもので、係数 (a^{-1})_ℂ は a の ℝ の逆数として作る（√((2s_2)^{-M}) との一致は別に見る）。
- 厳密版の 5 行目→6 行目（real_inclusion_preserves_product）は、QQbar の積で必ず成り立つ（包含の性質そのものは (r, 0) の確認と `check_real_coefficient_lines.sage` が受け持つ）。
- 厳密版の 6 行目→7 行目（ℝ の aa^{-1} = 1）は、a^{-1} を AA の逆元として作るので必ず成り立つ（ボール版も 1/a で作るので必ず重なる）。
- 厳密版の 7 行目→8 行目（ι(1) = 1_ℂ）は QQbar で必ず成り立つ。
- 厳密版・ボール版の Step 1 の E_+E_-・A_+A_- の 1 行目→2 行目（exp(X_1) → exp(−(−X_1))）は、−(−X_1) が X_1 と成分まで同じ行列なので、exp を作る関数に同じ入力を渡すことになり必ず一致する。
  この行の中身は (a) の −(−A) = A が受け持つ。なお (b) は exp の肩を (log y)·(−(−iH_1^{(+)})) の形で作っており、本文の −(−((1/2)S_1^{(+)})) とはスカラー倍と符号反転の順が違う。
- 厳密版の Step 2・Step 3 のスカラー倍・結合律の段は、QQbar の成分の計算規則だけで必ず成り立つ。
  中身として効くのは、a > 0（a ≠ 0）、a^{-1} と別の経路 √((2s_2)^{-M})（ボール版は実数冪）との一致、Step 1 の左右逆を使う段、最後の I である。

## 計算の帰属と範囲

- `check_exact_factors.sage`: (a) は `KG = QQ(i)` 上の実の不定元 K_1・K_2^* の多項式環で、任意の実数の結合定数で成り立つ形（M_col = 2..5）。
  (b) は K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}、M_col = 2..4）と選ぶ。X_1 = (log y)·iH_1^{(+)} なので、exp(X_1)・exp(−X_1)・exp(−(−X_1)) を
  肩の行列 iH_1^{(+)}・その符号反転・二重の符号反転（成分の定義で組む）の固有値 λ の射影に y^λ を掛けて QQ に作る（符号反転した行列の射影を実際に計算する）。
  A_± と exp(−(−S_2)) も iH_2 から同じく (√t)^{−λ}（t = tanh K_2 = (x^2−1)/(x^2+1)）を掛けて AA に、a・a^{-1} を AA に、V_2 を成分 x^n で QQ に作り、鎖は QQbar で持つ。
  作った E_±・A_± は共有の準備の exp_V1_half_exact・exp_iK2star_H2_exact とも一致することを確かめる。
  **ℝ への脱出は K_1・K_2 の選び方の一点だけ**で、以後の等号は全て厳密計算である。exp の値は def_exp の級数ではなく固有値の射影から作る（独立な経路）。
- `check_balls_by_partial_sums.sage`: K_1 ∈ {1/4, 1/2}、K_2^* ∈ {1/3, 1/2}（有理数）、M_col = 2..4。K_2 := artanh(u)（u := exp(−2K_2^*)）。
  exp は def_exp の部分和（`KG` で厳密）に尾の上界を各成分の半径として足した 256 ビットのボールで、Sage の exp とも重なることを確かめる（ℝ への脱出: exp の極限）。
  許容誤差は置かず、等号はボールの重なりで判定する。ボール版の鎖は、厳密版の表示の行（2 行目）を持たず、6〜9 行目（(aa^{-1})_ℂ → (1)_ℂ → 1_ℂ → 係数なし）をまとめて (aa^{-1})_ℂ(XY) → XY の 1 段で比べる（それらの行は厳密版と `check_real_coefficient_lines.sage` が受け持つ）。
- `check_chains_with_generic_invertible_factors.sage`: E_±・A_± の代わりに QQ の 2・4・8 次の可逆行列とその逆行列を置き、a を QQ の正の元に取る（行列の段が Step 1 の左右逆だけで成り立つことの確認）。
- `check_real_coefficient_lines.sage`: M = 2..5、s_2 ∈ {1/3, 2, 5/7}、X・Y は虚部を持つ QQbar の行列。
- 範囲外: M_col ≥ 6（(a)）、M_col ≥ 5（(b) とボール版）。

## 由来

`check_chains_with_generic_invertible_factors.sage` は旧い `sagemath/check/050_claim_even_sector_eigenvalues/check_10_V_plus_inverse_chains.sage`、
`check_real_coefficient_lines.sage` は旧い `check_27_V_plus_inverse_real_inclusion_chains.sage` を移したもの（中身は参照先の名前の注記と、
前者の係数 a を 1 にならない (trial+2)/5 にしたことだけを変えた。件数は元と同じ）。
浮動小数点で V^{(+)}R^{(+)} = I・R^{(+)}V^{(+)} = I を見る旧い check_07・check_08 は 050 に残してある。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_exact_factors.sage` | (a) Step 1 の二重符号反転の行、(b) Step 1〜3 の行と主張を実際の指数行列で厳密に | **PASS** | 等号 540 個（(a) 12、(b) 528）、否定コントロール 68 件 |
| `check_balls_by_partial_sums.sage` | 同じ行を def_exp の部分和のボールで | **PASS** | 重なりを確かめた行 426 個、否定コントロール 42 件 |
| `check_chains_with_generic_invertible_factors.sage` | Step 2・Step 3 の行列の段を一般の可逆行列で | **PASS** | 252 段 |
| `check_real_coefficient_lines.sage` | Step 2・Step 3 の係数の段 | **PASS** | 168 段、否定コントロール 12 行 |

人手証明の計算の誤りは見つからなかった。レビューの指摘で人手証明の根拠を三か所直した（Step 1 の散文の前提「各指数の行列とその反数は可換」と肩の行 X − X = O を、
`V1_plus_half_invertible` と同じ `matrix_double_negation`・`exp_of_negative_is_left_inverse` を引く鎖に。本文で定義されていなかった (2s_2)^{-M_col/2} を主張の中で
(2s_2)^{M_col/2} の ℝ の逆数と定め、Step 2 の「正の実数の冪の指数法則」をその置き方と `def_second_transfer_matrix_prefactor` に。最後の段落を `def_invertible_elements_of_R` を引く行に）。主張の値は変えていない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V_plus_is_invertible
```

実行ログは `logs/` に保存する。
