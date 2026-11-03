# SageMath Check: lambda_eq_exp_gamma_theta_tilde

## 対象

**対象ラベル**: `lambda_eq_exp_gamma_theta_tilde`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `Athetatilde_009_claim_lambda_eq_exp_gamma`（λ_{±,μ} = exp(±γ(θ̃_μ)) と λ_{+,μ} > 1 > λ_{-,μ} > 0）
- 範囲: 証明の準備 (a)〜(e) と r > 0 の鎖、Step 1（平方の鎖・正であること・平方の一致からの一致）、Step 2（λ_+・λ_- の鎖）、Step 3（−t < 0 と三つの不等式の鎖）、主張

記号は証明のとおり g = γ_1(θ̃_μ)、r = |γ_2(θ̃_μ)|、t = γ(θ̃_μ) = arccosh(g)。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 (a) g > 1、cosh t = g（`gamma1_gt_1_theta_tilde`・`arccosh_properties` (2)） | `check_values_and_claims.sage` | 具体値で g > 1（AA）、`def_arccosh` の w = g + √(g^2 − 1) について (w + 1/w)/2 = g（L） | **PASS** | 厳密（AA・L） |
| 準備 (b) t > 0（`gamma_theta_tilde_mu_positive`） | 同上 | t = log w と、g だけから作る arccosh(g) を囲むボールの下端 > 0 | **PASS** | ボール（ℝ への脱出） |
| 準備 (c) の鎖 γ_2 ≠ 0 ⇒ r ≠ 0 ⇒ r > 0 | 同上 | 各段 | **PASS** | 厳密（円分体・AA） |
| 準備 (d) g^2 = 1 + r^2（`det_A_theta_tilde`） | 同上 | 具体値で一致（F の中の g^2 − 1 = γ_2 conj(γ_2) と L） | **PASS** | 厳密（F・L） |
| 準備 (e) λ_± = g ± r（`eigenvector_of_A_theta_tilde`） | 同上 | 定義式 γ_1 ± √(−γ_2(θ̃)γ_2(−θ̃)) を γ_2(−θ̃) の定義式から作り、根号の中 = r^2、λ_± = g ± r | **PASS** | 厳密（円分体） |
| Step 1 の平方の鎖 4 本の等号（`cosh_sinh_basic_properties` (2)・準備 (a)・準備 (d)・ℝ の四則） | `check_generic_chains.sage` | 各行を不定元の多項式として別々に写し、隣り合う行の差がその行の根拠の関係のイデアルに入ること（関係なしでは異なる対照つき） | **PASS** | 厳密（QQ 上の多項式環） |
| 同上 | `check_values_and_claims.sage` | 具体値で全行が一致（w = g + r と置いたことから従う。行ごとの裏付けは上の一般の点の検算） | **PASS** | 厳密（L） |
| Step 1 sinh t > 0（`cosh_sinh_basic_properties` (3)）と sinh t = r（同 (4)） | 同上 | cosh t > sinh t > 0、sinh t = r。w を通らない照合: g だけから作る arccosh(g) のボールで sinh が +r と重なり −r と重ならない。対照: a = −r は a^2 = r^2 だが負で r と異なる（正の条件が要る） | **PASS** | 厳密（L・AA）＋ボール |
| Step 2 λ_+ の鎖 5 本・λ_- の鎖 4 本（準備 (e)・(a)・Step 1・`cosh_sinh_basic_properties` (1)・+t = t） | `check_generic_chains.sage` | 一般の点のイデアルの判定（対照つき） | **PASS** | 厳密 |
| 同上 | `check_values_and_claims.sage` | 具体値で全行一致（exp(t) = w、exp(−t) = 1/w。w = g + r と置いたことから従う）。w を通らない照合: exp(±arccosh g) のボールが g ± r と重なる | **PASS** | 厳密（L）＋ボール |
| 根拠の当てはめの形 | `check_generic_chains.sage` | `cosh_sinh_basic_properties` (1)(2) が `def_cosh_sinh` の式と exp(t)exp(−t) = 1 から従うこと（後者なしでは (2) が従わない対照）。準備から λ_+λ_- = 1、λ_+ + λ_- = 2g | **PASS** | 厳密 |
| Step 3 −t < 0 | `check_values_and_claims.sage` | −t のボールの上端 < 0 | **PASS** | ボール |
| Step 3 exp(t) > exp(0) = 1 > exp(−t) > 0（`real_exp_strictly_increasing`・`scalar_exp_zero`・`real_exp_positive`） | 同上 | w > 1 > 1/w > 0 | **PASS** | 厳密（AA） |
| 主張 | 同上 | λ_+ > 1 > λ_- > 0、λ_+ > λ_-。対照: θ = 0（半整数運動量ではない）の臨界点では g = 1、r = 0、λ_+ = λ_- = 1 で分離しない | **PASS** | 140 組 |

## 計算の帰属と範囲

- 一般の点は `QQ` 上の多項式環（浮動小数点なし）。
- 具体値は `gamma1_gt_1_theta_tilde` の検算の準備（`../gamma1_gt_1_theta_tilde/_prelude.sage`）と同じ 4 組の結合定数（臨界点 2 組を含む）× M_col = 2..8 の全 μ（140 組）。
  角度は円分体 F = Q(ζ_{4M}) の中で持ち、g と N = γ_2 conj(γ_2) は F の元である。r = |γ_2| = √N は F に x^2 = N で添えた体 L
  （N が F で平方なら L = F）の元として持ち、**等号はすべて L の中で判定する**。順序（>）だけは、L の元 a + b·r（a, b は F の実の元）を
  `AA`（実代数的数）の a + b·√N へ移して判定する（AA で入れ子の平方根の等号を判定すると 1 組に数秒以上かかるため、等号を L へ移した）。
- t = arccosh(g) は `def_arccosh` より log w、w = g + √(g^2 − 1)。g^2 − 1 = N を F の中で確かめたうえで √(g^2 − 1) = √N = r と置くので
  w = g + r ∈ L であり、exp(t) = w・exp(−t) = 1/w（exp ∘ log = id の当てはめ）。cosh t・sinh t は `def_cosh_sinh` の式 (w ± 1/w)/2 で作る。
- L の中の Step 1・Step 2 の鎖の各行は、w = g + r と置いたことと準備 (d) から代数的に従う。行ごとに根拠の関係で成り立つことの裏付けは
  `check_generic_chains.sage` のイデアルの判定が持ち、sinh t を +r の側に選ぶこと（符号）は下の w を通らないボールの照合が持つ。
- **浮動小数点を使う箇所**: t = log w と、w を通らずに g だけから作る t = arccosh(g)（どちらも実対数。ℝ への脱出）を `RealBallField(200)` のボールで囲む。
  ボールは丸めの誤差を半径に含むので、下端が正なら t > 0、上端が負なら −t < 0、ボールが −r と重ならなければ sinh t ≠ −r は確定する。

## 確かめられない行と理由

- 実数の exp・log そのもの（部分和の極限）は扱わない。exp の狭義単調増加性・正値性・exp(0) = 1 は、
  exp(t) = w の値の大小（AA で厳密）として当てはめの結果を確かめるにとどまる。
- `cosh_sinh_basic_properties` (4) そのもの（正の数の平方の一致から数の一致）は、具体値で sinh t = r が成り立つことと、正の条件を外した対照で確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh lambda_eq_exp_gamma_theta_tilde
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
