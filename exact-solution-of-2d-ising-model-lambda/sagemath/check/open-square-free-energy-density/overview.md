# SageMath Check: 開境界正方形の自由エネルギー密度

## 対象

**対象ラベル**: `def_open_square_free_energy_density`

- 実行日: 2026-08-15
- 結果: 有限標本検査がすべて通過（合計 48 件）
- 帰属: 可算側（$1/L^2\in\mathbb{Q}$ の確定・正値性、$Z^{\mathrm{op}}_{L,L}(t)\in\mathbb{Q}_{>0}$、
  $t=1$ での記号計算）は厳密。実対数に触れる検査だけ `RealBallField(256)`（ball 算術）を使う。

## 何を確かめるか

- 可算側（厳密）: $L\in\{1,2,3\}$ で $L^2\ne0$、$1/L^2\in\mathbb{Q}$、$0<1/L^2$（3 件）。
- well-formed 性: $L\in\{1,2,3\}$ × 正の有理点 $t$ 7 点の 21 件で、
  $Z^{\mathrm{op}}_{L,L}(t)\in\mathbb{Q}$ かつ $Z^{\mathrm{op}}_{L,L}(t)>0$（厳密比較。実対数の
  定義域に入る）、および $\psi^{\mathrm{op}}_L(t)=\iota(1/L^2)\cdot\log_{\mathbb{R}}(Z^{\mathrm{op}}_{L,L}(t))$
  の ball が有限に確定すること。
- 整合: $L^2\cdot\psi^{\mathrm{op}}_L(t)-\log_{\mathbb{R}}(Z^{\mathrm{op}}_{L,L}(t))$ の ball が $0$ を
  含み半径が $2^{-200}$ 未満であること（21 件）。**ball 算術では等式は証明できないので、
  これは整合の確認である（証明ではない）。**
- $t=1$ の標本（記号計算で厳密）: $Z^{\mathrm{op}}_{L,L}(1)=2^{L^2}$ と
  $\psi^{\mathrm{op}}_L(1)=\log 2$（$L$ に依らない。3 件）。

## 浮動小数点（ball 算術）を使う理由（記録）

実対数の値は一般に超越的で厳密な閉形式の比較ができない。本文もこの章で $\mathbb{R}$ への
脱出を宣言している。そこで実対数に触れる検査だけ `RealBallField`（丸め誤差を厳密に包含する
区間算術）を使い、等式は「差の ball が $0$ を含む」整合検査として行う。可算側で済む検査には
浮動小数点を使っていない。

## 範囲の注記（黙って狭めない）

- $t$ の標本は正の有理数、$L\in\{1,2,3\}$ に限る。普遍量化された定義の well-formed 性は
  本文の記述が担う。
- Lean は具体版 `openSquareFreeEnergyDensity`（定義。周期境界の `freeEnergyDensity` と同じ形）を
  書き、2026-08-15 に `lake build` を通過した。定義ブロックなので必要十分版・導出版は無い
  （`def_free_energy_density` と同じ扱い）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-free-energy-density/check.sage
```
