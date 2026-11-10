# SageMath Check: relation_of_gamma_2_theta_tilde

## 対象

**対象ラベル**: `relation_of_gamma_2_theta_tilde`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `Athetatilde_003_claim_relation_of_gamma2`（(1) γ_2(−θ~_μ) = −conj(γ_2(θ~_μ))、(2) γ_2(θ~_μ)γ_2(−θ~_μ) = (−|γ_2(θ~_μ)|^2)_ℂ と −|γ_2(θ~_μ)|^2 < 0、
  (3) その偏角は π、(4) √(−γ_2γ_2') = |γ_2| > 0、(5) √(γ_2γ_2') = i|γ_2|、γ_2(−θ~_μ) ≠ 0）
- 範囲: 準備の五つの段（exp(iθ) の鎖、ī と conj(exp(iθ)) の鎖、γ_2(−θ) の表示の鎖、conj(γ_2(θ)) の 18 行の鎖、
  sin(π/2)・cos(π/2) の鎖と、主張 pi_is_positive を引く 0 < π）と、(1)〜(5) の鎖と γ_2(−θ) ≠ 0 の背理の鎖のすべての行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の第一: cos θ + i sin θ の鎖 17 行（i(−θ)・−i(−θ)・cos(−θ)・sin(−θ) の鎖は主張 `i_times_negated_real_is_negation_of_i_times`・`negation_of_i_times_negated_real_is_i_times`・`cos_of_negated_real`・`sin_of_negated_real` へ移り、検算はそれぞれのラベルのディレクトリにある） | `check_generic_chains.sage` | exp(±iθ) を不定元にした QQ(i) 上の有理関数体で一行ずつ（否定の対照: 分母の i だけを落とすと崩れる） | **PASS** | 厳密 |
| 同（具体値） | `check_values_and_claims.sage` | 円分体で cos(−θ) = cos θ・sin(−θ) = −sin θ・exp(i(−θ)) = exp(−iθ)・cos θ + i sin θ = exp(iθ)、Euler の式の cos・sin が Sage 組み込みの cos・sin（QQbar）と一致 | **PASS** | 厳密 |
| 準備の第二: ī = −i の鎖 6 行（i := (0,1) は `def_imaginary_unit`） | `check_generic_chains.sage` | ℂ を QQ の対で持ち、共役・積・包含・−1 倍を定義どおりに | **PASS** | 厳密 |
| 準備の第二: conj(exp(iθ)) = exp(−iθ) の鎖 8 行 | `check_generic_chains.sage`、`check_values_and_claims.sage` | cos θ・sin θ を QQ[c, s] の不定元にした対で 7 行（(−i) sin θ = −(i sin θ) と差の定義を 1 行ずつ）、最終行は exp_of_negative_i_real_as_cos_minus_i_sin の右辺 (c, −s)。具体値で円分体の共役と def_complex_conjugate の対の共役の両方 | **PASS** | 厳密 |
| 準備の第三: γ_2(−θ) の表示の鎖 6 行（第 2〜4 行は主張 `i_times_negated_real_is_negation_of_i_times`・`cos_of_negated_real`・`sin_of_negated_real` を引く） | 両方 | 一般の点では cos(−θ)・sin(−θ) を別の不定元にし、第 3・4 行がそれぞれ関係 cos(−θ) = cos θ・sin(−θ) = −sin θ を法としてだけ一致すること（法なしでは一致しない対照つき）。具体値では第 1 行が γ_2 の定義を −θ で評価したものに一致 | **PASS** | 厳密 |
| 準備の第四: conj(γ_2(θ)) の鎖 18 行 | 両方 | 一般の点では exp(±iθ) を不透明な対 (p,q)・(u,v) にし、第 6 行だけが関係 u = p, v = −q（conj(exp(iθ)) = exp(−iθ)）を法として一致すること（対照つき）。具体値では各行を円分体の共役で作る | **PASS** | 厳密 |
| 準備の第五: sin(π/2) = 1 の鎖 2 行・cos(π/2) = 0 の鎖 5 行、0 < π（pi_is_positive の参照）、角度 0・π の整数が 0 | `check_values_and_claims.sage` | sin(π/2)・cos(π/2) は 1 の 4 乗根の実部・虚部。cos(π/2) の鎖は一行ずつ 1^2 = 1、1 − 1 = 0、√0 = 0（否定の対照 1 件）。0 < π は引く主張の値を記号計算と RealBallField(256) で確かめるだけ（鎖の検算は `sagemath/check/pi_is_positive/`）。`n_of_section` の総当たり | **PASS** | 厳密 |
| (1) の鎖 2 行 | 両方 | ℂ で −(−z) = z（右辺から左辺へ）、具体値で γ_2(−θ) = −conj(γ_2(θ))。対照: γ_2(−θ) ≠ +conj(γ_2(θ)) | **PASS** | 厳密 |
| (2) の鎖 9 行 | 両方 | 一般の点 z = (x,y) で 8 段（−1 倍の定義、結合律・可換律を一つずつ、complex_conjugate_times_self、包含と積、ℝ で (−1)a = −a）。具体値で γ_2γ_2' = (−(x^2+y^2), 0)、最後の行の (−1)|γ|^2 = −|γ|^2（否定の対照つき）（|γ|^2 は abs_basic_properties (2) の x^2+y^2） | **PASS** | 厳密 |
| (2) の |γ| > 0 の段落と、0 < |γ|^2 の鎖 3 行・−|γ|^2 < 0 の鎖 2 行 | `check_values_and_claims.sage` | γ ≠ 0、|γ| ≠ 0、|γ| > 0（AA）。冪 |γ|^2（AA の `**2`）が x^2+y^2 に等しいこと。鎖は一行ずつ: 0 = 0·|γ|（ℝ で 0·x = 0。否定の対照つき）、0·|γ| < |γ||γ|、|γ||γ| = |γ|^2、−|γ|^2 < −0、−0 = 0（ℝ で −0 = 0） | **PASS** | 厳密 |
| γ_2(−θ) ≠ 0 の背理の鎖 10 行 | 両方 | (x,y) = (x,−(−y)) = conj((x,−y)) = conj(conj(x,y))、−0_C = (−1_C)0_C = 0_C、conj(0_C) = 0_C（一般の点）。具体値で γ_2(−θ) ≠ 0 | **PASS** | 厳密 |
| (3) φ_polar((−r)_C) の鎖 12 行と主張の鎖 8 行 | `check_values_and_claims.sage` | r = |γ|^2 ∈ AA で、根号の中身と arctan の引数の対を第 2〜9 行で一行ずつ（(−r)^2 = (−r)(−r) = rr = r^2、0^2 = 0·0 = 0、r^2 + 0 = r^2、0/(−r) = 0。否定の対照: (−r)(−r) ≠ −(rr)）、√(r^2) = r、`phi_polar_equals` で φ_polar((−r,0)) = [(r,π)]（arctan の値を作らず sin で判定）、第 12 行の 0 + π = π を角度 a + bπ の和で（否定の対照: 1 + π ≠ π）、s_{[0,2π)}([π]) = π と主張の鎖の π − 2·0·π = π − 0·π = π − 0 = π（否定の対照: π − 2·1·π ≠ π） | **PASS** | 厳密 |
| (4) −γγ' = r_C の鎖 5 行、φ_polar(r_C) の鎖 8 行、主張の鎖 12 行 | 両方 | 各行の対を AA で作って隣どうし一致（−γγ' の鎖の (−1)(−r) = 1·r = r、φ_polar(r_C) の鎖の根号の中身と arctan の引数を第 2〜6 行で一行ずつ、主張の鎖の角度 0/2 − 0·π = 0 − 0·π = 0 − 0 = 0 と (|γ|·1, |γ|·0) = (|γ|, |γ|·0) = (|γ|, 0)）。否定の対照: (−1)(−r) ≠ −r、0/r ≠ 1/r、0 − 1·π ≠ 0。第 2 行の値が def_sqrt_cc を定義どおりに計算した値（`sqrt_cc_by_definition`）と一致。対照: Sage の QQbar の平方根 | **PASS** | 厳密 |
| (5) 主張の鎖 16 行 | 両方 | 同上（角度 π/2 − 0·π = π/2 − 0 = π/2 を一行ずつ。否定の対照: π/2 − 1·π ≠ π/2）。(|γ|·0, |γ|·1) から (0,1)(|γ|,0) までの 6 行は成分の ℝ の等式 1 つずつ（積の可換律を 2 成分へ、a − 0 = a、x·0 = 0、0 + a = a、0·x = 0、definition_of_cc の積。否定の対照: (1,0)(|γ|,0) は (0,|γ|) にならない）。末尾 2 行は i(|γ|,0) = i|γ|_C。対照: Sage の QQbar の平方根（主値）が i|γ| | **PASS** | 厳密 |

## 計算の帰属と範囲

- 結合定数は `Y = exp(2K_1)`・`Z = exp(2K_2)` を QQ_{>1} の有理数に取る。`c_1, s_1, c_2, s_2^*` はすべて QQ の元になる。
  ℝ への脱出は `K_i = (1/2) log Y` などの選び方だけで、検算は実対数を計算しない。
- 角度 θ~_μ = π(2μ − 1)/M_col は円分体 Q(ζ_{4M}) の中で `exp(iθ~_μ) = ζ_{4M}^{2(2μ−1)}` として持ち、cos・sin は
  `euler_formula_cos_sin` の式で作る。|γ_2|・偏角・平方根は AA の対と角度 a + bπ（a, b ∈ QQ）で計算する。浮動小数点は使っていない。
- 範囲: 結合定数 (Y, Z) ∈ {(2,3), (3,2), (4,3), (101/100,7)}（(2,3)・(3,2) は臨界点）、M_col = 2..8 の全 μ（140 組）。
  AA の平方根と比較が重いので、この範囲に絞った。一般の点の鎖は `check_generic_chains.sage` が範囲によらず確かめる。

## 確かめられない行と理由

- 準備の第一の鎖が引く `euler_formula_cos_sin` と、`exp_of_negative_i_real_as_cos_minus_i_sin` は、全実数上の cos・sin（未整備）を前提にしている。
  検算は exp(±iθ) を不定元にした代数的な行と、具体の角度での値を確かめるにとどまる。
- 準備の第五の `arcsin(1) = π/2` は `arcsin_of_one_is_half_pi`（`arcsin_is_bijection` と同じ齋藤微積分 命題 2.1.5 から示す）に依る。
  検算は Sage の記号計算（`arcsin(1) == pi/2`）での一致を見るだけである。
- exp そのもの（部分和の極限）は扱わない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh relation_of_gamma_2_theta_tilde
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
