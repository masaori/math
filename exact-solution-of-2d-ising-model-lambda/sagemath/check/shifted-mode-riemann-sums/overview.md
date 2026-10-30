# 半格子ずれたモード和の有限検算

**対象ラベル**: `claim_shifted_mode_riemann_sums`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 四つのずれについて、標本点の小区画内所属と代数的分散因子から角の対数和への有限再添字付け | PASS（2026-10-30） |

`sage sagemath/check/shifted-mode-riemann-sums/check.sage` を実行して通った。指数評価と実対数への脱出を含むため、代数的分散因子は `AA`、角と実対数は 150 bit の `RealField` で検算した。極限と積分の等式は有限検算では証明できず、本文の一様連続性による評価が根拠である。
