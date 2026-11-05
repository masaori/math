# SageMath Check: gamma_derivatives_in_kappa

## 対象

**対象ラベル**: `gamma_derivatives_in_kappa`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_007_claim_gamma_derivatives_in_kappa`（S(θ, κ) := sinh²(κ/2) + sin²(θ/2)、γ(θ, κ) := 2 arcsinh(√S) の
  半角・倍角の値 (1)、κ ≠ 0 での ∂γ/∂κ = sinh κ/sinh γ と ∂²γ/∂κ² (2)、|∂γ/∂κ| ≤ 1 (3)、連続性 (4)）
- 範囲: 主張の S ≥ 0、(1) の四本の鎖、記号の帰属の段の t ≥ 1、(2) の S > 0・sinh γ > 0 の含意の鎖と ∂S/∂κ（10 行）・∂γ/∂κ（12 行）・∂²γ/∂κ²（10 行）の鎖、
  (3) の 8 行の鎖・背理法の 5 行・結びの 4 行、(4) の S ≥ sinh²(κ_1/2) > 0 の 3 行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張の S ≥ 0 | `check_points_exact.sage` | 48 点で S ≥ 0、sin²(θ/2) ∈ [0, 1] | **PASS** | 厳密（AA） |
| (1) sinh(γ/2) の 3 行（γ の定義・四則・`sinh_of_arcsinh`） | `check_points_exact.sage` | γ/2 = arcsinh(r) = log x（x = r + √(r²+1)、`def_arcsinh`）から sinh(γ/2) = (x − 1/x)/2 を作り r と一致 | **PASS** | 厳密（AA） |
| (1) cosh(γ/2) の 5 行（平方根の一意性・`cosh_sinh_basic_properties` (2)・r² = S・t の定義） | `check_lines_in_ideal.sage`・`check_points_exact.sage` | 各行の関係式をイデアルで。点では cosh(γ/2) > 0、√((cosh γ/2)²) = cosh γ/2、定義から作った cosh(γ/2) = t | **PASS** | 厳密 |
| (1) sinh γ の 5 行（倍角・代入・一意性・交換結合・r² = S, t² = 1+S） | 同上 | 2 sinh(γ/2)cosh(γ/2) = 2rt、(rt)² = r²t² = S(1+S) をイデアルで。点で rt ≥ 0、定義から作った sinh γ = 2√(S(1+S))。対照: t を落とした 2r | **PASS** | 厳密 |
| (1) cosh γ の 3 行（半角公式・代入・r² = S） | 同上 | イデアルで。点で定義から作った cosh γ = 1 + 2S | **PASS** | 厳密 |
| (2) S > 0 の含意 4 行と S の 3 行 | `check_points_exact.sage` | κ ≠ 0 の 40 点で sinh(κ/2) ≠ 0、sinh²(κ/2) > 0、S ≥ sinh²(κ/2) > 0。対照: κ = 0、θ = 0 で S = 0 | **PASS** | 厳密（AA） |
| 記号の帰属の段の t ≥ 1（背理法の 3 行）と (2) の r > 0・2rt > 0・sinh γ > 0 の 4 行 | 同上 | 48 点で t ≥ 1、40 点で各不等式 | **PASS** | 厳密（AA） |
| (2) ∂S/∂κ の 10 行（和・定数 0・積・交換・合成・定数倍と恒等関数・`sinh_derivative`・交換・倍角） | `check_lines_in_ideal.sage`・`check_points_exact.sage` | κ についての導分 D（D(u) = u/2、D(q) = 0）で各行の両辺がイデアルを法として一致。点で SR の記号微分の ∂S/∂κ = sinh κ/2。対照: 1/2 を落とす | **PASS** | 厳密 |
| (2) ∂γ/∂κ の 12 行（定数倍・合成 2 回・(√)'・`arcsinh_derivative`・r² = S・加法の交換・t の定義・∂S/∂κ・四則・sinh γ = 2rt） | 同上 | 1〜8 行目（定数倍・合成・(√)'・arcsinh'）は導分 D の作り方（D(r) := D(S)/(2r)）に入っているのでイデアルでは確かめず、点で SR の記号微分（D と独立）と比べた: d/dκ √S = (1/(2r))·∂S/∂κ、d/dκ arcsinh(√S) = (1/t)(1/(2r))∂S/∂κ、SR の arcsinh'(r) = 1/t（1・2 行目の定数倍は SR の中で同じ式の線型性を見るだけで、独立な確認には数えない）。√(r²+1) = t はイデアルで。9〜12 行目（∂S/∂κ の代入・四則・sinh γ = 2rt）はイデアルで。点で ∂γ/∂κ = sinh κ/sinh γ = sinh κ/(2rt)。対照: sinh κ/(2 sinh γ) | **PASS** | 厳密 |
| (2) ∂²γ/∂κ² の 10 行（商・`sinh_derivative`・合成・`sinh_derivative`・代入・分数の差・積・約分・冪の記法） | 同上 | 導分 D とイデアルで各行。D(sinh γ) = cosh γ·∂γ/∂κ。点で SR の 2 階の記号微分が主張の式と 5 行目の式に一致。合成の行と sinh' = cosh の行は値が同じなので、イデアルの検算では同じ式の 2 段として並べた。対照: 第 2 項の符号 | **PASS** | 厳密 |
| (3) sinh²γ − sinh²κ の 8 行（倍角 2 箇所・積の 2 乗・`cosh_sinh_basic_properties` (2)・sinh(γ/2) = r・r² = S・因数分解・S の定義・≥ 0） | `check_lines_in_ideal.sage`・`check_points_exact.sage` | 各行をイデアルで、因数分解を独立な不定元で。点で値と ≥ 0。対照: 因数 (1+S−a) | **PASS** | 厳密 |
| (3) |sinh κ| ≤ sinh γ の背理法の 5 行と結びの 4 行 | `check_points_exact.sage` | 背理法の鎖は不等号の向きの一般の事実で、仮定が偽なので具体の点では確かめられない。40 点で結論の |sinh κ| ≤ sinh γ、|∂γ/∂κ| = |sinh κ|/sinh γ ≤ 1。θ ∈ 2πℤ では等号 1 で達し、それ以外では < 1 | **PASS** | 厳密（AA） |
| (4) S ≥ sinh²(κ/2) ≥ sinh²(κ_1/2) > 0 の 3 行と sinh γ = 2rt ≥ 2r > 0 | `check_points_exact.sage` | κ_1 = 2 log(5/4)、κ_2 = 2 log 3 の格子 5 × 9 点。対照: κ < 0 の点では sinh(κ/2) < 0 | **PASS** | 厳密（AA） |
| 主張 | 上の二つ | ファイル `check_points_exact.sage` 全体で真偽の確認 1433 件（うち対照 82 件）がすべて成立 | **PASS** | 厳密 |

## 計算の帰属と範囲

- **厳密（浮動小数点なし）**: 行の一般の検算は u := exp(κ/2)、q := sin²(θ/2)、r := √S、t := √(1+S) とその逆数を変数に持つ
  `QQ` 上の 7 変数の多項式環で、関係式（u·u⁻¹ = 1、r² = S、t² = 1 + S、r·r⁻¹ = 1、t·t⁻¹ = 1）のイデアルの所属をグレブナー基底で判定する。
  微分は κ についての導分 D（D(u) = u/2、D(q) = 0、D(r) = D(S)/(2r)、D(t) = D(S)/(2t)）で表し、D が関係式のイデアルを保つことを確かめた。
- 具体の点は κ = 2 log u（u ∈ `QQ`_{>0}）、θ = πp（p ∈ `QQ`）に取る。exp(κ/2) = u と exp ∘ log = id（検算の側で使う標準の事実）により、
  sinh・cosh・sin² と γ の半角・倍角の値は `AA`（実代数的数）に入るので、主張と各行の値を厳密に比べた。
- 導関数の値は、Sage の記号微分（SR の `diff`）で γ(θ, κ) = 2 arcsinh(√(sinh²(κ/2) + sin²(θ/2))) を微分し、点を代入して `AA` に直した。
  これは導分 D の作り方（合成の微分を D(r) の定義に入れたこと）と独立な確認である。

## 確かめられない行と理由

- 微分の公式（和・積・商・合成・定数倍・(√)'）そのものと「微分可能」「2 回微分可能」の段は、本文が外部から持ち込む実数解析の事実
  （`remark_real_analysis_facts_R3_R4`）を当てはめた結論で、等号の行ではない。ここでは当てた行の両辺の一致を確かめる。
  ∂S/∂κ の鎖の合成・定数倍・`sinh_derivative` の 3 行は、値が同じ cosh(κ/2)·(1/2) なので、D(sinh(κ/2)) = cosh(κ/2)/2 として一度に確かめた。
- (4) の連続性（2 変数の関数としての連続性）は、分母 sinh γ が正であることを格子点で確かめるにとどまる。
- θ ∈ ℝ での sin(θ/2) は、本文が全実数上の sin を定めていない（`def_sin` は [−π/2, π/2] だけ）まま使われている（状態台帳の「検算で見つかった本文の誤り」の
  `gamma_kappa_identity` の項）。検算は 1 の冪根の実部で作った cos πp から sin²(θ/2) = (1 − cos θ)/2 を作るにとどまる。
- 選んだ以外の点。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh gamma_derivatives_in_kappa
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
