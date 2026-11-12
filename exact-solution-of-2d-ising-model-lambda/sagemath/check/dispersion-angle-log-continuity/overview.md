# 角の対数関数の正の下界

**対象ラベル**: `claim_dispersion_angle_log_continuous`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 本文の証明の各行: $p\ne0$ の矛盾の式鎖、$B_q-(r^2+2r-1)^2$ の五行の多項式恒等式、$1-r^2=(1-r)(1+r)$、$B_q=(B_q-\text{下界})+\text{下界}$、有理点五つと 1 の冪根の角（辺長一〜五）での $0<r<1$・$r^2+2r-1\ne0$・$2r(1-r^2)>0$・差の非負性・$B_q\ge(r^2+2r-1)^2>0$。否定の対照（係数をずらした行、$r=1$、自己双対点 $\sqrt2-1$）を含む。計 4,548 件 | PASS（2026-11-12） |

`sage sagemath/check/dispersion-angle-log-continuity/check.sage` で実行した。恒等式と有限例は連続性の証明ではない。本文の連続性は実余弦、実数の四則、正の実数上の実対数の連続性から従う（Lean 具体版 `dispersion_angle_log_continuous`）。有限例では角の余弦を `AA` で厳密に扱い、浮動小数点を使わない。
