# SageMath Check: gamma_2_theta_tilde_nonzero

## 対象

**対象ラベル**: `gamma_2_theta_tilde_nonzero`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `Athetatilde_002_claim_gamma2_nonzero`（全ての μ ∈ {1,…,M_col} と K_1, K_2 > 0 で γ_2(θ~_μ) ≠ 0）
- 範囲: Step 0 の正値性 6 行、Step 1 の成分の鎖 4 行・逆元の鎖 13 行・背理の鎖 3 行・`a w = 0 ⟺ w = 0` の鎖 6 行と 3 行・同値の鎖 6 行、Step 2 の同値の鎖 5 行と奇偶の含意 3 行、
  Step 3 の鎖 3 行、Step 4 の鎖 3 行と矛盾の鎖 3 行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 0: `K_1^*, K_2^* > 0`、`c_1, s_1, c_2, s_2^* > 0` | `check_step0_positivity.sage` | 8 組の結合定数で、`0 < tanh K_i < 1`・`exp(2K_i^*) > 1`・各略記が正であること。`tanh K_2^* = exp(−2K_2)` の照合 | **PASS** | 厳密（QQ） |
| Step 1 準備: w(θ) の成分の鎖 4 行 | `check_step1_generic.sage` (a) | ℂ を実数の対で持ち、三か所の積・二か所の積・和を一行ずつ | **PASS** | 厳密 |
| 逆元の鎖 第 1〜4 行（定義、結合律・可換律、`-i := (-1_C)i`） | `check_step1_generic.sage` (b) | `exp(iθ)`・`exp(−iθ)`・`exp(iθ+(−iθ))` を独立な不定元に置いた QQ(i) 上の多項式として一致 | **PASS** | 厳密 |
| 同 第 5・6 行（`(0,1)(0,1) = (−1,0)`、`(−1,0)(−1,0) = (1,0)`） | 同上 | 実数の対の積で | **PASS** | 厳密 |
| 同 第 7 行（`scalar_exp_product`） | 同上 | 関係 `e f = g` を法として一致し、法なしでは一致しないこと | **PASS** | 厳密 |
| 同 第 8・9 行（`iθ + (−iθ) = 0`、`scalar_exp_zero`） | 同上 | QQ(i)[θ] で和が 0、関係 `g = 1` を法として一致 | **PASS** | 厳密 |
| 同 第 10 行（`real_inclusion_preserves_product`） | 同上 | 実数の対の積で `(s,0)(t,0) = (st,0)` | **PASS** | 厳密 |
| 同 第 11〜13 行（`s_2^*(s_2^*)^{-1} = 1`、`(1)_C = 1_C`、単位元） | 同上 | 関係 `s t = 1` を法として一致。具体値では `a(θ~_μ) b(θ~_μ) = 1` を円分体で | **PASS** | 厳密 |
| 背理の鎖 `1 = a b = 0·b = 0` | 同上 | `0·b = 0` と `1 ≠ 0` | **PASS** | 厳密 |
| `a w = 0 ⇒ w = 0` の鎖 6 行と `w = 0 ⇒ a w = 0` の鎖 3 行 | 同上 | a, b, w を不定元にし、関係 `a b = 1` を法として | **PASS** | 厳密 |
| 同値の鎖 第 1 行 `γ_2 = a w` | `check_step4_and_claim.sage` | `_shared/defs.sage` の `gamma_2`（`def_gamma1_gamma2_of_theta` の式で、`def_A_theta` の (1,2) 成分と文字どおり同じ式。双曲線関数・三角関数の記号式に K_1 = (1/2) log Y などを代入し、exp で書き直して QQbar へ）と、円分体で本文の a(θ)・w(θ) の定義から別々に作った積が一致。3 組の結合定数、M_col = 2..6 の全 μ | **PASS** | 厳密 |
| 同 第 2 行（直前の二つの鎖） | 同上 | 具体値で `γ_2 = 0 ⟺ w = 0` の両辺の真偽が一致 | **PASS** | 厳密 |
| 同 第 3〜6 行（成分、成分ごとの相等、移項、−1 倍） | `check_step1_generic.sage` (a) | 差・積の恒等式と `0_C = (0,0)`。具体値で `w = 0 ⟺ 連立条件` の真偽の一致 | **PASS** | 厳密 |
| Step 2 同値の鎖 5 行 | `check_step2_step3_exhaustive.sage` | M_col = 2..40 の全 μ で、各行の真偽が一致し不一致が 0 件。第 1 行は円分体の sin（組み込みの sin とも照合）、第 2・3 行は定義の代入なので同じ記号式、第 4〜6 行は QQ・ZZ の等式で判定 | **PASS** | 厳密 |
| Step 2 奇偶の含意 3 行 | 同上 | `2μ − 1 = 2(μ − 1) + 1`、`k = 2l` なら `kM = 2(lM)` は偶数（l = −20..20）、sin θ~_μ = 0 の各組で k が奇数 | **PASS** | 厳密 |
| Step 3 の鎖 3 行 | 同上 | `cos θ~_μ = cos(kπ) = (−1)^k = −1`（円分体と QQbar） | **PASS** | 厳密 |
| Step 4 の鎖 3 行と矛盾の鎖 | `check_step4_and_claim.sage` | sin θ~_μ = 0 の組で `c_1 cos θ~_μ = c_1·(−1) = −c_1`、各結合定数で `0 < s_1c_2`・`−c_1 < 0` | **PASS** | 厳密 |
| 主張 | 同上 | M_col = 2..16 の全 μ と 8 組の結合定数（臨界点 (Y,Z) = (2,3), (3,2) を含む）で γ_2(θ~_μ) ≠ 0 | **PASS** | 厳密 |
| 対照 | 同上 | 臨界点 (2,3) で整数の角度 θ = 0 では γ_2(0) = 0、臨界点でない (4,3) では γ_2(0) ≠ 0 | **PASS** | 厳密 |

## 計算の帰属と範囲

- 結合定数は `Y = exp(2K_1)`・`Z = exp(2K_2)` を QQ_{>1} の有理数に取る。`def_cosh_sinh` と `def_second_dual_coupling_constant` から
  `c_1, s_1, c_2, s_2^*` はすべて QQ の元になる。ℝ への脱出は `K_i = (1/2) log Y` などの選び方だけで、検算は実対数を計算しない。
- 角度 θ~_μ = π(2μ − 1)/M_col は円分体 Q(ζ_{4M}) の中で `exp(iθ~_μ) = ζ_{4M}^{2(2μ−1)}` として持ち、cos・sin は
  `euler_formula_cos_sin` の式で作る。Sage 組み込みの sin・cos（QQbar）とも照合した。浮動小数点は使っていない。
  `γ_2 = a w` の照合だけは `_shared/defs.sage` の記号式を Maxima の `exponentialize` と `simplify_full` で代数的数へ移す（記号式の簡約に頼る行）。
- 範囲: 結合定数 (Y, Z) ∈ {(2,3), (3,2), (4,3), (3/2,5), (9,9/8), (5/4,5/4), (101/100,7), (50,21/20)}。Step 2・Step 3 は M_col = 2..40、主張は M_col = 2..16。

## 確かめられない行と理由

- Step 2 の第 1 行の `sin t = 0 ⟺ ∃k ∈ ℤ: t = kπ` と Step 3 の `cos(kπ) = (−1)^k` は、全実数上の cos・sin が本文に未整備なので
  ラベルを引けない（状態台帳の「検算で見つかった本文の誤り」の `half_integer_phase_antiperiodicity` の項）。検算は具体の角度での当てはめを確かめるにとどまる。
- Step 1 の逆元の鎖は `exp(iθ)` の値を使わず、`scalar_exp_product`・`scalar_exp_zero` が与える関係だけを法として確かめる。exp そのもの（部分和の極限）は扱わない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh gamma_2_theta_tilde_nonzero
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
