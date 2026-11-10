# SageMath Check: factorization_of_A_theta_general

## 対象

**対象ラベル**: `factorization_of_A_theta_general`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_009_claim_factorization_A_theta`（A(θ) = B_1(θ) B_2 B_1(θ)、θ ∈ ℝ 一般）
- 範囲: 証明の準備の十本の鎖（七本の等式、補助的な等式二本、C = S(c_2)_C）、Step 1〜5 の全ての行（Step 2・3 の末尾の実数の像へ移す 3 行を含む）、Step 6 の括弧の付け替え、主張そのもの

## 証明の行との対応

記号は証明のとおり `a = (cosh K_1)_C`、`b = (sinh K_1)_C`、`C = (c_2^*)_C`、`S = (s_2^*)_C`、`e_+ = exp(i(θ)_C)`、`e_- = exp((-i)(θ)_C)`。
`euler_formula_cos_sin` は `-iθ` を `-(iθ)` と読むので、`exp(-(i(θ)_C))` を別の不定元 `emn` に置き、`e_-` との一致は `negative_i_times_complex_is_negation_of_i_times` の当てはめ（関係式 `em=emn`）として扱う。
具体値の検算の `exp((-i)(θ)_C) = exp(-(i(θ)_C))` の比較は、Sage の記号式が両者を同じ形に正規化するので同じ値になることの確認にとどまり、独立な経路ではない。
証明の各行は `_prelude.sage` の `CHAINS` に、行の表記どおりの多項式として写してある（鎖の名前は証明の量の名前）。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 1〜3 本目（`a^2+b^2 = (c_1)_C`、`2ab = (s_1)_C`、`a^2-b^2 = 1_C`）の全行 | `check_chains_exact_values.sage` | 実数の値を `exp(K_1) = y` から `def_cosh_sinh` の式で作り、各行の値が等しい。`cosh_addition_formula`・`sinh_double_angle_formula` の当てはめの行は、`cosh(K_1+K_1)`・`sinh 2K_1` を `exp(2K_1) = y^2` から独立に作って比べる | **PASS** | 3 組の `(y, x)` で `QQ` の厳密等号 |
| 準備の 4 本目 `e_+e_- = 1_C` の全行 | `check_chains_exact_values.sage` | `exp(i(θ)_C)`・`exp(-i(θ)_C)`・`exp(i(θ)_C + (-i)(θ)_C)`・`exp(0)` を Sage の記号式から `QQbar` へ変換して等しい | **PASS** | 9 個の角度で厳密 |
| 準備の 5〜7 本目（`e_+ + e_- = 2(cos θ)_C`、`e_± = (cos θ)_C ± i(sin θ)_C`） | `check_chains_generic.sage`・`check_chains_exact_values.sage` | 一般の不定元で、1 行目→2 行目と `e_±` の定義を展開する 2 行目→3 行目が環の演算だけで（`e_±` は不定元なので展開の行は同じ多項式）、3 行目→4 行目が関係式 `em=emn` だけで、4 行目→5 行目が `euler_formula_cos_sin` の二式だけが生成するイデアルで等しい。`e_+` の鎖の 3 行目→4 行目は書き換えた `e_-` の項が正規形で打ち消し合うので、書き換える二つの分数のそれぞれが `em=emn` を使って書き換わることを見る。具体値では e_± と cos θ・sin θ を独立に作り、`euler_formula_cos_sin` の当てはめと全行の一致を見る | **PASS** | 多項式として厳密。具体値は 27 通りで厳密 |
| 補助的な等式の 2 本と `C = S(c_2)_C` の全行 | 同上 | 各行の等号が、その行の (∵) が引く関係式だけのイデアルで成り立ち、関係式を引く行では多項式としては異なる（その関係式を実際に使う）。鎖の終点が Step で引く関係式そのものである | **PASS** | 同上 |
| Step 1 の `N_11`〜`N_22` の全行 | 同上 | 始点を Sage の行列積 `B_2 B_1` の成分とし、各行が環の演算だけで等しい。具体値でも Sage の `QQbar` 行列の積と一致 | **PASS** | 同上 |
| Step 2〜5 の `P_11`・`P_22`・`P_12`・`P_21` の全行 | 同上 | 始点を Sage の行列積 `B_1(B_2B_1)` の成分とし、各行の等号を (∵) が引く関係式（`e_+e_- = 1_C`、`a^2+b^2 = (c_1)_C`、`e_+ + e_- = 2(cos θ)_C`、`2ab = (s_1)_C`、補助的な等式、`C = S(c_2)_C`、C・S の定義、Step 5 の最後の 2 行は `e_-` の定義を開く行と `negative_i_times_complex_is_negation_of_i_times` の `exp((-i)(θ)_C) = exp(-(i(θ)_C))`）だけで確かめる。鎖の終点が `def_A_theta` の対応する成分（(2,1) 成分の指数を `-(i(θ)_C)` と読んだもの）そのもの。実数の像を不定元に置くので、Step 2・3 の末尾の 3 行（積の像と差の像）は同じ多項式になり、この検算では見分けない | **PASS** | 同上 |
| Step 2・3 の末尾の 3 行（`real_inclusion_preserves_product` を 2 箇所へ、同じく 1 箇所へ、`real_inclusion_preserves_difference`）と、終点が `def_A_theta` の (1,1)・(2,2) 成分（実数の式の像）であること | `check_diagonal_entries_as_real_image.sage` | ℂ を `definition_of_cc` どおり実数の対で持ち、`c_1, c_2^*, s_1, s_2^*, cos θ` を `QQ` の不定元にして、各行を対の積・差・包含 r ↦ (r, 0) で行の表記どおりに作る。終点の虚部が 0 で実部が実数の式であること。対照: 虚部が 0 でない数を混ぜると実数の像にならない | **PASS** | 厳密等号 |
| Step 6（`mat_mult_associative`）と主張 | 同上 | `(B_1B_2)B_1 = B_1(B_2B_1)` を多項式行列で。主張は、基本の関係式 10 本（準備の 1〜4 本目、`(-i)z = -(iz)` の当てはめ、Euler の二式、C・S の定義、双対関係）で `B_1B_2B_1 - A(θ)` の全成分が消え、どの 1 本を抜いても消えない。具体値では両方の括弧の付け方で `A(θ)` に等しい。対照: 非対角成分の `c_2` を `c_2^*` に替えた行列、`B_1(-θ)` とは一致しない | **PASS** | 多項式として厳密。具体値は 27 通りで厳密（θ = 0 では e_+ = e_- なので `B_1(-θ)` の対照は SKIP） |

## 計算の帰属と範囲

- 一般の検算は `QQ(i)` 上の 14 変数の多項式環で行い、関係式のイデアルの所属はグレブナー基底で判定する（浮動小数点なし）。
- 具体値は `QQbar`（代数的数）で厳密に判定する。ℝ への脱出は結合定数の選び方 `K_1 = log y`・`K_2^* = (1/2) log x`（`x, y ∈ QQ_{>1}`）と、
  θ = 2πk/n の三角関数・指数関数の値を Sage の記号式から代数的数へ変換することだけである。
  `K_2` は `K_2^* = -(1/2) log(tanh K_2)` を解いて `exp(2K_2) = (x+1)/(x-1)` とし、`c_2` を `c_2^*` と独立に作る。
- 範囲: `(y, x) ∈ {(2, 3), (3, 7/3), (5/2, 2)}`、θ ∈ {0, 2π/3, π/2, 2π/5, 4π/5, π/3, 6π/7, 5π/4, 7π/6}。

## 確かめられない行と理由

- 準備の 1〜3 本目のうち包含の像を動かす行（`real_inclusion_preserves_product`・`real_inclusion_preserves_finite_sum` の当てはめ）は、
  検算では `QQ ⊂ QQbar` の同じ値になるので、一致は作り方から通る。値として独立に確かめているのは
  `cosh_addition_formula`・`sinh_double_angle_formula`・`cosh_sinh_basic_properties` (2) の当てはめの行である。
- 準備の 4 本目の 2 行目（`scalar_exp_product` の当てはめ）は、Sage の記号式が `I*θ + (-I)*θ` をその場で 0 にするので、
  `exp(i(θ)_C + (-i)(θ)_C)` の値は作り方から `exp(0)` になる。端点どうしの `e_+e_- = 1` は e_± を独立に作って確かめている。
- `euler_formula_cos_sin` は全実数上の cos・sin と Euler の公式が本文で未整備のまま引かれている（状態台帳の `half_integer_phase_antiperiodicity` の項）。
  検算はその主張の当てはめを Sage の cos・sin・exp で確かめるにとどまる。
- 主張の全ての K_1・K_2・θ への一般化は、一般の不定元の検算（関係式からの導出）で代える。具体値の範囲は上のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh factorization_of_A_theta_general
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
