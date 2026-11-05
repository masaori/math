# SageMath Check: second_derivative_log_divergence

## 対象

**対象ラベル**: `second_derivative_log_divergence`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_011_theorem_second_derivative_log_divergence`（G(κ) := (1/4π)∫_0^{2π} γ(θ, κ) dθ について、
  0 < |κ| ≤ 1/2 で |G'(κ)| ≤ 1/2 と |G''(κ) − (1/2π) log(1/|κ|)| ≤ 6/5）
- 範囲: Step 0（偶関数性と δ の評価）・数値の評価の段・Step 1〜7 の全ての鎖と、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 0: 0 < δ ≤ sinh(1/4) ≤ 0.2527 | `check_bounds_with_balls.sage`・`check_points_exact.sage` | ボールで。δ > 0 は QQ でも | **PASS** | ボール／厳密 |
| 数値の評価の段（sinh(1/4)・cosh(1/4)・log cosh(1/4)・cosh(1/2)・log 2・log(2π) の上界、3.141592 ≤ π ≤ 3.141593 から π ≤ 3.1416・2π ≥ 6.2831、log 1 = 0 と log(2π) > 0、π^2 ≥ 9.8696、c_0 ≥ 0.5887、B ≤ 0.88） | `check_bounds_with_balls.sage` | RealBallField(256) の確かな大小、導く行は QQ で。対照: 桁を一つ詰めた不等式は成り立たない（4 件） | **PASS** | ボール／厳密 |
| Step 1: (R5) の 2 回の適用 | `check_bounds_with_balls.sage` | 積分で作った G'・G'' と、G・G' の中心差分商（h = κ/100）の差が 10^{-3} 以下（許容誤差の根拠はファイルの注） | **PASS** | 数値（許容誤差あり） |
| Step 1: |G'| の 5 行 | 同上 | ∂γ/∂κ > 0、|G'| ≤ (1/4π)∫|∂γ/∂κ| ≤ (1/4π)∫1 = 1/2 | **PASS** | ボール |
| Step 2: 折り返しの 4 行 | `check_points_exact.sage`・`check_bounds_with_balls.sage` | sin^2((2π−θ)/2) = sin^2(θ/2) を AA で。∫_π^{2π} = ∫_0^π、区間の分割、G'' = (1/2π)∫_0^π をボールで | **PASS** | 厳密／ボール |
| Step 3: r・t の準備（r > 0、t ≥ 1、sinh(γ/2) = r・cosh(γ/2) = t と倍角公式で sinh γ = 2rt、cosh γ = 1 + 2S）と 4 行の鎖 | `check_lines_in_ideal.sage`・`check_points_exact.sage`・`check_bounds_with_balls.sage` | exp(γ/2) = r + t からイデアルで、点で AA で。∫_0^π ∂²γ = (cosh κ/2)J − T をボールで。対照: sinh γ = 2r | **PASS** | 厳密／ボール |
| Step 4: 準備（sin²(θ/2) ≤ 1、r² ≤ δ² + 1 = cosh²(κ/2) の 3 行、r ≤ cosh(κ/2)）と各点の等号 7 行・不等号 2 行 | `check_lines_in_ideal.sage`・`check_points_exact.sage` | 等号はイデアルで、全ての行の値と大小は AA の点で。対照: (t−1)(t+1) を t^2+1 に、上界 r/2 を r^2/2 に | **PASS** | 厳密 |
| Step 4: 積分の 4 行、R_0・R の定義と上下界、|R| ≤ max、数値の 3 行 | `check_lines_in_ideal.sage`・`check_bounds_with_balls.sage` | R = R_0 − (∫1/r − J) を多項式の恒等式で、他はボールで。有理数の行は QQ で。対照: R < 0（下界に差の評価が要る） | **PASS** | 厳密／ボール |
| Step 5: 各点の 8 行と T ≥ 0 の 3 行 | `check_lines_in_ideal.sage`・`check_points_exact.sage`・`check_bounds_with_balls.sage` | 等号はイデアルと AA、不等号は AA の点。S^{3/2} = Sr = r^3。T ≥ 0 はボール。対照: 1/(4r^3) を 1/(8r^3) に | **PASS** | 厳密／ボール |
| Step 5: sin(θ/2) ≥ c_0θ/2 と S ≥ w ≥ δ^2、√w ≤ r、w^{3/2} ≤ S^{3/2}、1/S^{3/2} ≤ 1/w^{3/2}、T の 9 行 | `check_bounds_with_balls.sage`・`check_lines_in_ideal.sage` | 7 点の θ でボール。T の鎖の各行の積分を別々に計算して大小、4〜5 行目の等号はイデアルでも。対照: 3.614 | **PASS** | ボール／厳密 |
| Step 6: κ/2 ≤ δ ≤ (κ/2)cosh(κ/2)、2/cosh(κ/2) ≤ κ/δ ≤ 2、ρ の上下界の 4 行、log(π/δ) の 3 行、|ρ| の 3 行、分解の 2 行、cosh κ − 1 の 4 行、log(1/κ) > 0 と cosh κ ≥ 1 | `check_bounds_with_balls.sage`・`check_lines_in_ideal.sage`・`check_points_exact.sage` | ボールで各行。分解の式と cosh κ − 1 = 2δ^2 は多項式の恒等式と QQ でも。対照: 分解の第 1 項の係数 | **PASS** | ボール／厳密 |
| Step 6: F(s) := −s^2 log s の準備と (R4)・(R3) の 6 行 | `check_bounds_with_balls.sage` | κ^2 log(1/κ) = F(κ) = F(1/2) − ∫_κ^{1/2}F'（積分は Arb）、F' > 0（3 点）、∫F' ≥ 0、F(1/2) = (1/4)log 2、−2(−0.6931) − 1 = 0.3862 を QQ で | **PASS** | ボール／厳密 |
| Step 6: 第 1 項・第 2 項・合計の行 | `check_bounds_with_balls.sage` | 値の大小をボールで、有理数の行（0.532·0.1733 ≤ 0.093 など）を QQ で | **PASS** | ボール／厳密 |
| Step 7: 2πG'' の 3 行と三角不等式・数値の 4 行、最後の 5 行 | `check_lines_in_ideal.sage`・`check_bounds_with_balls.sage` | 等号の 3 行をボールと多項式で、有理数の行を QQ で | **PASS** | ボール／厳密 |
| 主張 | `check_bounds_with_balls.sage` | κ ∈ {1/2, 2/5, 1/4, 1/10, 1/50, 1/500} と −κ で |G'| ≤ 1/2、|G'' − (1/2π)log(1/|κ|)| ≤ 6/5（実際の値は 0.1166〜0.1292）。対照: 6/5 を 1/20 にすると破れる | **PASS** | ボール |

真偽の確認: `check_lines_in_ideal.sage` 31 件（うち対照 4 件）、`check_points_exact.sage` 852 件（うち対照 8 件）、`check_bounds_with_balls.sage` 434 件（うち対照 7 件）。

このうち、R := J − 2log(π/δ) と R_0 の定義から R = R_0 − (∫1/r − J) とする行、J = 2log(π/δ) + R の行、Step 7 の 2・3 行目は定義の書き換えで、どの値でも成り立つ（確かめた数には含めているが、検算として意味を持つのは他の行である）。Step 1 で ∫|∂γ/∂κ| を ∫∂γ/∂κ にするのは、∂γ/∂κ = sinh κ/(2rt) が κ > 0 で式の形から正だからで、検算は 3 点の θ で値を見るにとどまる。

## 計算の帰属と範囲

- **厳密（浮動小数点なし）**: 代数の行は QQ 上の多項式環で関係式（ch^2 = 1 + δ^2、r^2 = S、t^2 = 1 + S、逆数の積 = 1）のイデアルの所属を判定する。
  対数の値は独立な不定元として、行が多項式の恒等式であることだけを見る。
  各点の行は κ = 2 log u（u ∈ {5/4, 11/10, 101/100, 1001/1000}）、θ = πp（sin²(θ/2) ∈ {0, 1/4, 1/2, 3/4, 1} となる 9 点の p）の点で AA（実代数的数）で確かめる。有理数の四則・大小比較の行は QQ で。
- **ℝ への脱出（RealBallField(256) と Arb の数値積分）**: 積分・実対数・π・初等関数の値を含む行。cosh・sinh は本文の exp の部分和と尾の評価のボール。
  積分は ComplexBallField(256).integral（S ≥ δ^2 > 0 なので被積分関数は実軸の近くで解析的）。等号はボールの重なり（差の半径 < 2^{-100}）、
  不等号は確かな大小で判定し、許容誤差は置かない。
- **許容誤差を置いた唯一の行**: (R5) を当てた Step 1 は、積分の値と差分商を比べるので 10^{-3} の許容誤差を置いた（差分商の誤差の見積もりは
  `check_bounds_with_balls.sage` の注）。

## 確かめられない行と理由

- (R3)〜(R6) と微分の公式そのもの、「2 回微分可能」「連続」の段は、本文が外部から持ち込む実数解析の事実を当てた結論である。ここでは当てた行の両辺の一致・大小を確かめる。
- Step 0 の G(−κ) = G(κ) と G'・G'' の偶奇は、γ が κ に sinh²(κ/2) を通してしか依らない同じ式から両辺を作ることになり確かめにならないので、検算に含めない（γ(θ, −κ) = γ(θ, κ) そのものは `gamma_kappa_identity` の検算が持つ）。
- 最後の log(1/|κ|) → +∞ の段は極限の主張で、具体の κ の値では確かめられない。
- 数値の評価の段の不等式は、本文では証明せず `remark_real_analysis_escape_chapter_E` が持ち込むもので、ここではボールでの裏付けだけを与える。
- 選んだ以外の点（κ・θ）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh second_derivative_log_divergence
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
