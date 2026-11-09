# SageMath Check: log_integral_two_sided_bounds

## 対象

**対象ラベル**: `log_integral_two_sided_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_log_integral_two_sided_bounds`（δ > 0 なら 2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+θ²/4) ≤ 2 log(π/δ) + 2δ²/π²）
- 範囲: 準備と、下からの評価の三行・上からの評価の四行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 2y = π/δ・1/(4y²) = δ²/π² と分配則の行 | `check_proof_lines.sage` | π を不定元 p に置いた QQ(p, δ) の等号として厳密に | **PASS** | 成り立つ |
| π > 0（`pi_is_positive`） | `check_proof_lines.sage` | Arb の π のボールの下端 ≥ 3.141592（> 0） | **PASS** | 成り立つ |
| 両方の評価の各行と主張 | `check_proof_lines.sage` | 7 点の δ で積分（Arb の厳密な数値積分）・log・arcsinh をボールで | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | δ = 1/10 で余り 2δ²/π² を落とすと上界にならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 準備と分配則の行は、π を不定元 p に置いた `QQ(p, δ)` で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`・`ComplexBallField(256)`）**: 積分・π・log・arcsinh の値だけ。値が QQ・AA に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む事実）。π > 0 の証明は `pi_is_positive` の検算が扱う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh log_integral_two_sided_bounds
```

実行ログは `logs/` に保存する。
