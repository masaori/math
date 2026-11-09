# SageMath Check: sine_integral_two_sided

## 対象

**対象ラベル**: `sine_integral_two_sided` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_010_claim_sine_integral_two_sided`（δ > 0 なら 2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2 log(π/δ) + 2δ²/π² + B）
- 範囲: 準備、各点の大小、下からの評価、差の各点評価の準備と鎖（p = 0 の場合を含む）、F' = θ、積分の鎖、上からの評価、主張

記号: p := θ/2、s := sin p、D1 := √(δ²+p²)、D2 := √(δ²+s²)、c0 = 1 - π²/24、B = π²/(12c0(1+c0))。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: 0 ≤ c0p ≤ s ≤ p、δ² ≤ D1², D2²、0 < δ ≤ D1, D2 | `check_proof_lines.sage` | 48 点の (δ, θ) で s を AA で厳密に、p・π・c0 をボールで | **PASS** | 成り立つ |
| 各点の大小: s² の鎖、D2² の鎖、D2 ≤ D1、1/D1 の鎖 | `check_proof_lines.sage` | 等号と差 s(p - s)、p(p - s)、(D1 - D2)/(D1D2) を有理関数体で。D2² の鎖の 1・3 行目は D1²・D2² の関係式のイデアルで。大小は 48 点でボール | **PASS** | 成り立つ |
| 下からの評価の 4 行 | `check_proof_lines.sage` | 4 点の δ で ∫1/D2 ≥ ∫1/√(δ²+θ²/4) ≥ 2 log(π/δ) を Arb の数値積分のボールで | **PASS** | 成り立つ |
| p - s の鎖（θ³/48 = p³/6）、0 ≤ p+s ≤ 2p、p ≤ D1、(c0p)² の鎖、c0p ≤ D2 | `check_proof_lines.sage` | 等号と差の因数分解を有理関数体で、大小を 48 点でボール | **PASS** | 成り立つ |
| 準備の p² = θ²/4、p + c0p ≤ D1 + D2、分母の逆数の評価の 3 行 | `check_proof_lines.sage` | 等号と差 (den - c0(1+c0)p³)/(den·c0(1+c0)p³) の式を有理関数体で、大小を 48 点でボール | **PASS** | 成り立つ |
| 分母の鎖の 4 行 | `check_proof_lines.sage` | 差を (D1 - p)D2(D1+D2)、(D2 - c0p)p(D1+D2)、((D1 - p) + (D2 - c0p))p·c0p に因数分解し、最後の等号を有理関数体で。大小を 48 点でボール | **PASS** | 成り立つ |
| 差の各点評価の鎖の 12 行 | `check_proof_lines.sage` | 1〜3・5・6・9・11・12 行目の等号を有理関数体で、4 行目を関係式のイデアルで。7・8・10 行目は差を非負の因子の積に書いて有理関数体で、大小を 48 点でボール | **PASS** | 成り立つ |
| p = 0 の場合 | `check_proof_lines.sage` | 4 点の δ で s = sin 0 = 0、D1 = D2、差 = 0 を AA で | **PASS** | 成り立つ |
| F' = θ、積分の鎖の 5 行 | `check_proof_lines.sage` | (θ²/2)' = ½(1·θ + θ·1) = θ を QQ[θ] で、3〜5 行目の等号を有理関数体で。1・2 行目と (R4) の当てはめを 4 点の δ でボール | **PASS** | 成り立つ |
| 上からの評価の 7 行と主張 | `check_proof_lines.sage` | 2 行目の各点の等号を有理関数体で、3〜6 行目と主張を 4 点の δ でボール | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | B を落とした 2 log(π/δ) + 2δ²/π² は上界にならない（δ = 1/100） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行と、不等号の行の「右辺 - 左辺」の因数分解は、δ, p, s, c0, D1, D2, π, θ を不定元にした有理関数体と、
  D1² = δ²+p²、D2² = δ²+s² の生成するイデアルを法とした `QQ[δ, p, s, D1, D2]` で確かめた。θ = 0 の場合と、格子点の sin の値は AA で確かめた。
- **`ℝ` への脱出（`RealBallField(256/512)`・`ComplexBallField(256)`）**: π・p = qπ・c0 の値と、積分・log の値だけ。値が QQ・AA に入らないためである。
  大小は差のボールの下端の符号で、等号は差のボールが 0 を含み半径が 2^-200 未満であることで判定し、許容誤差は置かない
  （共通の準備 `sagemath/_shared/log_integral_by_balls.sage`・`sagemath/_shared/sine_cosine_by_definition.sage`）。
- 被積分関数の sin は Arb の sin（標準の正弦）を使う。格子点では本文の sin（AA の値）を囲むことを確かめたが、全ての点での一致は
  `remark_real_analysis_facts_R3_R4` が前提にしていることで、この検算の範囲外である。

範囲外のもの:

- 選んだ以外の点（θ は [0, π] を 12 等分した点、δ は 1/100, 1/10, 1, 3）。
- 被積分関数の連続性の段（微分の公式の当てはめ）と、(R3)・(R4)・微分の公式・正弦の導関数そのもの（本文が外部から持ち込む事実）。π > 0 は `pi_is_positive` の検算で確かめている。
- 引いている主張（`sine_half_angle_linear_bounds`・`elementary_sine_bounds`・`log_integral_two_sided_bounds`・`nonnegative_real_order_from_squares` ほか）の中身は、それぞれの検算で確かめている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_integral_two_sided
```

実行ログは `logs/` に保存する。
