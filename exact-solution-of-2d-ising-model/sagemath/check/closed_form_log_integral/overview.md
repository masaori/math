# SageMath Check: closed_form_log_integral

## 対象

**対象ラベル**: `closed_form_log_integral` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_009_claim_closed_form_log_integral`（δ > 0 なら ∫_0^π dθ/√(δ²+θ²/4) = 2 arcsinh(π/(2δ))）
- 範囲: 準備の 0 < δδ = δ² の鎖、準備の δ ≠ 0・0 ≤ δ^{-1}・0 < W(θ)・W(θ) ≠ 0・0 ≤ W(θ)/δ の鎖、準備の 4 ≠ 0・0 ≤ 4^{-1}・0 ≤ θ²/4・δ² ≤ δ²+θ²/4・0 < δ²+θ²/4 の鎖、準備の鎖、√(q²+1) = W/δ、q' = 1/(2δ)、F' の鎖の六行、F(0) の鎖の七行、積分の鎖の五行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 0 < δδ = δ² の鎖（`real_product_of_positives_is_positive`・`square_of_real_number_is_product`） | `check_proof_lines.sage` | 2 行目の等号を QQ[δ] で、1 行目の < と 2 行目の等号を 6 点の QQ で厳密に。対照は δ = 0 で < が成り立たないこと | **PASS** | 成り立つ |
| 準備の δ ≠ 0・0 ≤ δ^{-1}・0 < W(θ)・W(θ) ≠ 0・0 ≤ W(θ)/δ の鎖（`def_real_strict_order`・`real_inverse_of_positive_is_positive`・`sqrt_of_positive_real_is_positive`・順序と乗法の両立・`def_real_quotient`） | `check_proof_lines.sage` | 6 点の δ（QQ）と 4 点の θ（W(θ) は AA）で各行を厳密に。対照は 0 ≤ W を外した負の数との積 | **PASS** | 成り立つ |
| 準備の 4 ≠ 0・0 ≤ 4^{-1}・0 ≤ θ²/4・δ² ≤ δ²+θ²/4・0 < δ²+θ²/4 の鎖（`def_real_strict_order`・`real_inverse_of_positive_is_positive`・`real_square_is_nonnegative`・順序と乗法の両立・`def_real_quotient`・加法の単位元・順序と加法の両立・加法の交換律・順序の推移律・反対称律） | `check_proof_lines.sage` | 等号の行を QQ[δ,θ] で、各行を 6 点の δ と 5 点の θ（QQ）で厳密に。対照は δ = θ = 0 で < が成り立たないこと | **PASS** | 成り立つ |
| 閉形式の鎖の最後の行 2 arcsinh(π/(2δ)) − 0 = 2 arcsinh(π/(2δ))（`real_minus_zero_is_self`） | `check_proof_lines.sage` | QQ[a]（a は 2 arcsinh(π/(2δ)) の不定元）の多項式の等式で厳密に。対照として差の向きを取り違えた 0 − a は a と一致しない | **PASS** | 成り立つ |
| 準備の鎖 (W/δ)² = … = q² + 1 | `check_proof_lines.sage` | QQ(δ,θ)[W]/(W²-δ²-θ²/4) の等号として厳密に | **PASS** | 成り立つ |
| √(q²+1) = W/δ と F(0) の鎖の √1 = 1 の行（`sqrt_of_real_one_is_one`） | `check_proof_lines.sage` | 5 点の (δ, θ) で AA の非負の平方根として厳密に | **PASS** | 成り立つ |
| q' = 1/(2δ) と F' の鎖の六行 | `check_proof_lines.sage` | SR の記号微分を 5 点で QQbar へ送り、2〜6 行目の値と厳密に比べる | **PASS** | 成り立つ |
| F(0) の鎖 | `check_proof_lines.sage` | AA と本文の exp の部分和（exp 0 = 1）で厳密に | **PASS** | 成り立つ |
| 積分の鎖の両端（(R4) の当てはめ）と F(π) | `check_proof_lines.sage` | 6 点の δ で Arb の厳密な数値積分のボールと 2 arcsinh(π/(2δ)) のボール（def_arcsinh の形でも）が一致 | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | 係数 2 を落とすと一致しない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 準備の鎖は `QQ(δ,θ)[W]/(W²-δ²-θ²/4)` で、平方根の行は `AA` で、F' の鎖は `SR` の記号微分を `QQbar` へ送って、F(0) の鎖は `AA` と本文の exp の部分和（`QQ`）で確かめた。等号は θ によらないが、点は [0, π] から取った。
- **`ℝ` への脱出（`RealBallField(512)`・`ComplexBallField(256)`）**: 積分・π・arcsinh の値だけ（Arb の厳密な数値積分と Arb の関数）。値が QQ・AA に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh closed_form_log_integral
```

実行ログは `logs/` に保存する。
