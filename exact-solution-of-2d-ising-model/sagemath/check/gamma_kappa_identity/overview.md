# SageMath Check: gamma_kappa_identity

## 対象

**対象ラベル**: `gamma_kappa_identity`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_003_claim_gamma_kappa_identity`（γ_1(θ) = cosh γ(θ) = cosh κ + 2A sin²(θ/2)、sinh²(γ(θ)/2) = sinh²(κ/2) + A sin²(θ/2)、
  γ(θ) = 2 arcsinh(√(sinh²(κ/2) + A sin²(θ/2)))、κ についての偶関数性。θ ∈ ℝ）
- 範囲: Step 1 の 7 行の鎖と γ_1 = cosh γ の 2 行の鎖、Step 2 の 5 行の鎖、Step 3 の S ≥ 0 の鎖・sinh(γ/2) ≥ 0・4 行の鎖、
  偶関数性の 5 行の鎖、主張そのもの

旧い検算 `055_claim_critical_point/check_01_gamma_kappa_identity.sage` は主張の三つの式を浮動小数点で確かめるだけで、行との対応を持たない。この検算はそれと独立に作った。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 1 の 1→2 行目（分配則） | `check_lines_generic.sage`・`check_lines_with_balls.sage` | 値を `QQ` 上の独立な不定元に置いて多項式の等号。具体値のボールでも重なる | **PASS** | 厳密 |
| Step 1 の 2→3 行目（略記 c_1 = cosh 2K_1 ほかの展開）・4→5 行目（κ の定義の展開） | 同上・`check_series_identities.sage` | 定義の展開なので両辺は同じ式になる。検算は書き写しの形の一致だけで、内容は確かめていない | **PASS** | 形の一致のみ |
| Step 1 の 3→4 行目（`cosh_addition_formula` の複号 −） | 同上・`check_series_identities.sage` | 加法定理の関係式 1 本を法として成り立ち、抜くと成り立たない。加法定理そのものは本文の exp の部分和から作った cosh・sinh の形式冪級数（全次数 16 以下）で成り立ち、複号を + に誤ると成り立たない | **PASS** | 厳密 |
| Step 1 の 5→6 行目（A の定義） | 同上 | A = s_1s_2^* の 1 本を法として成り立ち、抜くと成り立たない | **PASS** | 厳密 |
| Step 1 の 6→7 行目（倍角公式 cos θ = 1 − 2 sin²(θ/2)） | 同上 | 倍角公式の 1 本を法として成り立ち、抜くと・係数を 1 に誤ると成り立たない。倍角公式そのものは cos・sin の冪級数（次数 30 以下）と θ = πr（12 点、負と \|θ\| > 2π を含む）の `QQbar` の値で成り立つ | **PASS** | 厳密（倍角公式の本文との結び付きは下記） |
| γ_1 = cosh(arccosh γ_1) = cosh γ（γ_1 ≥ 1 は `gamma1_lower_bound_all_theta`） | `check_lines_with_balls.sage` | 本文の定義 log(y + √(y²−1)) で γ を作り、γ_1 ≥ 1、γ ≥ 0 と cosh γ が γ_1 と重なること。Arb の arccosh とも重なる | **PASS** | ボール |
| Step 2 の 5 行（四則・半角公式 x = γ・Step 1・半角公式 x = κ・四則） | `check_lines_generic.sage`・`check_series_identities.sage`・`check_lines_with_balls.sage` | 各行が引いた関係式 1 本だけを法として成り立ち、関係式のある行は抜くと成り立たない。半角公式そのものは本文の exp の級数（次数 16 以下）で成り立ち、係数を誤ると成り立たない。具体値でも全行が重なる | **PASS** | 厳密・ボール |
| Step 3: S = sinh²(γ/2) = (sinh(γ/2))² ≥ 0 | 同上 | S − t² が Step 2 の関係式で消える。具体値で S ≥ 0 | **PASS** | 厳密・ボール |
| Step 3: γ ≥ 0 から sinh(γ/2) ≥ 0 | `check_lines_with_balls.sage` | 具体値で γ ≥ 0、sinh(γ/2) ≥ 0 | **PASS** | ボール |
| Step 3 の 4 行の鎖（γ = 2·(γ/2) = 2 arcsinh(sinh(γ/2)) = 2 arcsinh(√S) = 主張の右辺） | 同上 | 具体値で全行が重なる。sinh(γ/2) と √S が重なる（平方根の一意性の行）。arcsinh は本文の定義 log(y + √(y²+1)) で作り、Arb の arcsinh とも重なる。対照: 2 を落とした arcsinh(√S) は γ > 0 の点で γ と重ならない | **PASS** | ボール |
| 偶関数性の 5 行（記法、(−κ)/2 = −(κ/2)、`sinh_is_odd`、(−a)² = a²、記法） | `check_lines_generic.sage`・`check_series_identities.sage`・`check_lines_with_balls.sage` | (−u)² = u² の多項式の等号、sinh(−x) = −sinh x の級数の等号、具体値で κ → −κ の右辺が γ と重なる | **PASS** | 厳密・ボール |
| 主張 | `check_lines_with_balls.sage` | 6 組の (K_1, K_2^*) ∈ QQ_{>0}²（κ = 0 の 2 組を含む）× θ = πr の 10 点で三つの式と偶関数性。対照: 2 番目の式の A を 2A に誤ると sin(θ/2) ≠ 0 の点で重ならない | **PASS** | 真偽の確認 1822 件（うち対照 112 件、等号・不等号 1638 件）がすべて成立 |

## 計算の帰属と範囲

- **厳密**: 行の等号の一般の検算は `QQ` 上の 12 変数の多項式環で、イデアルの所属をグレブナー基底で判定する。
  加法定理・半角公式・sinh の奇性は、本文の実数の exp（1 行 1 列の行列の exp の成分）の部分和を本文の定め方で作り（共通の準備
  `sagemath/_shared/one_by_one_matrix.sage`）、形式冪級数として全次数 16 以下で比べる。倍角公式の厳密値は `QQbar`。
- **ℝ への脱出（`RealBallField(256)`）**: cosh・sinh・cos・sin・arccosh・arcsinh の値が実数（極限・平方根・実対数）なので、具体値の確認だけに使う。
  2K_1・2K_2^*・κ（いずれも `QQ`）の cosh・sinh は本文の exp を囲むボール（`body_real_exp_ball`。部分和に尾の評価を半径として足す）から作る。
  γ(θ) は実数なので cosh γ・sinh(γ/2) と θ = πr の cos・sin だけは Arb の関数を使う。
  許容誤差は置かず、等号はボールの重なりと差の半径が 2^{-100} 未満であること、不等号は符号の確定で判定する。
  κ = 0 かつ θ = 0 では γ_1 = 1 で √(y² − 1) のボールが定まらないので、γ = arccosh(1) = log 1 = 0 と √S = 0 を直接置いた。
- 主張は K_1 と K_2^* だけで決まるので (K_1, K_2^*) を選び、K_2 := artanh(exp(−2K_2^*)) > 0 について
  K_2^* = −(1/2) log tanh K_2（`def_second_dual_coupling_constant`）と sinh 2K_2 sinh 2K_2^* = 1 が重なることを確かめた。

## 確かめられない行と理由

- Step 1 の 7 行目の倍角公式 cos θ = 1 − 2 sin²(θ/2) と、θ ∈ ℝ での cos θ・sin(θ/2) は、本文が全実数上の cos・sin を定めていない
  （`def_sin`・`def_cos` は [−π/2, π/2] だけ。`euler_formula_cos_sin` の前置きが「未整備」と書く）まま引かれている（状態台帳の「検算で見つかった本文の誤り」）。
  検算は冪級数と Sage の cos・sin の値で確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh gamma_kappa_identity
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
