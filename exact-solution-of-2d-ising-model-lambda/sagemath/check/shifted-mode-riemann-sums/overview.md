# 半格子ずれたモード和の有限検算

**対象ラベル**: `claim_shifted_mode_riemann_sums`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 四つのずれについて、標本点の小区画内所属と代数的分散因子から角の対数和への有限再添字付け | PASS（2026-11-16） |
| `check_error_estimate_lines.sage` | 小区画の誤差評価の式鎖の有限の等式（端点 $0=0\cdot h_L$・$2\pi=Lh_L$、$(k+1)h_L-kh_L=h_L$、定数の累次区間積分が $h_Lh_L$ 倍、$L^2$ 個の同じ項の和、$(\varepsilon/(8\pi^2))(2\pi)^2=\varepsilon/2$）と、小区画の端点と標本点の座標の差が $h_L$ 以下であること | PASS（2026-11-16） |
| `check_limit_rewrite_lines.sage` | 結論の式鎖の二行目 $1/(2L^2)=(1/(8\pi^2))h_L^2$（$h_L^2=4\pi^2/L^2$ の代入）と三行目の値 $(1/(8\pi^2))I=I/(8\pi^2)$ | PASS（2026-11-16） |

`sage sagemath/check/shifted-mode-riemann-sums/check.sage` を実行して通った。指数評価と実対数への脱出を含むため、代数的分散因子は `AA`、角と実対数は 150 bit の `RealField` で検算した。極限と積分の等式は有限検算では証明できず、本文の一様連続性による評価が根拠である。

`check_error_estimate_lines.sage` は SageMath の記号計算（`SR`）で厳密に検算した。浮動小数点は使っていない。一様連続性・区間積分の加法性と評価は実数体の解析の定理であり、有限検算では証明できない（Lean 具体版 `shiftedAngleRiemannSum_error_le`・`shiftedAngleRiemannSum_tendsto` が根拠）。

`check_limit_rewrite_lines.sage` も `SR` で厳密に検算した。極限の定数倍は有限検算では証明できない（Lean 具体版 `halfInvSq_sampleSum_tendsto` が根拠）。再添字付けの段の Lean 具体版は `modeSum_realizedDispersionLog_eq_sampleSum` で、`check.sage` の有限再添字付けと対応する。
