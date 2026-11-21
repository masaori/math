# 代数的数には四乗が負の単位元になる元がある

**対象ラベル**: `claim_eighth_root_exists`

2026-11-21、SageMath で `check.sage` が PASS（二乗の十三段と四乗の七段を、二の平方根の二根と虚数単位の二根の四つの組それぞれで、負の検査二件）。

`QQbar` の中で、本文の準備（$s\ne0$、$s\cdot s^{-1}=1$、$\zeta:=(1+\omega)\cdot s^{-1}$）と、$\zeta\cdot\zeta=\omega$ の十三行、主張の左辺 $\zeta^4$ からの七行を厳密に検算する。
負の検査として、$s$ の代わりに $s\cdot s=2$ を満たさない $1$ を使うと $\zeta^4=-1$ が成り立たないことを確かめる。浮動小数点と根の大小は使わない。
検算は本文と Lean による証明の代わりではない。

| ファイル | 本文の操作 | 状態 | 対象数 |
|---|---|---|---|
| `check.sage` | 準備、二乗の十三段、四乗の七段、負の検査 | PASS | 4組 |

プロジェクト直下で `sage sagemath/check/eighth-root-exists/check.sage` を実行する。
