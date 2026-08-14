# SageMath Check: 自由エネルギー密度と極限の言明の定式化

## 対象

**対象ラベル**: `def_free_energy_density`, `def_free_energy_density_limit_statement`

- 実行日: 2026-08-14
- 結果: 有限標本検査がすべて通過（合計 50 件）
- 帰属: 可算側（$1/L^2\in\mathbb{Q}$ の確定・正値性、$t=1$ での記号計算）は厳密。
  実対数に触れる検査だけ `RealBallField(256)`（ball 算術）を使う（下記の理由）。

## 何を確かめるか

- `def_free_energy_density`（可算側）: $L\in\{1,2,3\}$ で $L^2\ne0$、$1/L^2\in\mathbb{Q}$、
  $0<1/L^2$（厳密。3 件）。
- `def_free_energy_density`（well-formed 性）: $L\in\{1,2,3\}$ × 正の有理点 $t$ 7 点の
  21 件で、$Z_L(t)\in\mathbb{Q}$ かつ $Z_L(t)>0$（厳密比較）、および
  $\psi_L(t)=\iota(1/L^2)\cdot\log_{\mathbb{R}}(Z_L(t))$ の ball が有限に確定すること。
- `def_free_energy_density`（整合）: $L^2\cdot\psi_L(t)-\varphi_L(t)$ の ball が $0$ を含み
  半径が $2^{-200}$ 未満であること（21 件）。
  **ball 算術では等式は証明できないので、これは整合の確認である（証明ではない）。**
- $t=1$ の標本（記号計算で厳密）: $Z_L(1)=2^{L^2}$ と
  $\psi_L(1)=\log(2^{L^2})/L^2=\log 2$（$L$ に依らない値。3 件）。
- `def_free_energy_density_limit_statement`（言明の形の具体例。記号計算で厳密）:
  $t=1$、$f=\log 2$ とすると $\psi_L(1)-f=0$ であり、$\varepsilon\in\{1/10,1/100\}$ の標本で
  言明の内側の 2 不等式 $-\varepsilon<0$ かつ $0<\varepsilon$ が $N=1$ で成り立つ（2 件）。

## 浮動小数点（ball 算術）を使う理由（記録）

実対数の値は一般に超越的で、厳密な閉形式の比較ができない。本文もこの章で
$\mathbb{R}$ への脱出を宣言している（`remark_real_field_escape`・`remark_real_logarithm`）。
そこで実対数に触れる検査だけ `RealBallField`（丸め誤差を厳密に包含する区間算術）を使い、
不等式は ball の分離で厳密に、等式は「差の ball が $0$ を含む」整合検査として行う。
どちらであるかは各検査の出力に明記した。可算側で済む検査（$1/L^2$ の確定・正値性、
$t=1$ での記号計算）には浮動小数点を使っていない。

## 範囲の注記（黙って狭めない）

- $t$ の標本は正の**有理数**である（$\iota_{\mathbb{Q}\to\mathbb{R}}$ を通した
  $\mathbb{R}$ の元のモデル）。普遍量化された主張そのものの証明は本文の人手証明が担う。
- $L\in\{1,2,3\}$ に限る（`finite-real-free-entropy` の検査と同じ範囲）。
- 極限の言明の検査は**定式化の形の確認**であり、極限の存在は本文もまだ主張していない
  （存在の証明は完備性への脱出を宣言済みの後続セクションで行う）。
- `remark_real_completeness_escape` は宣言のみのブロックで、計算を伴わないため
  検査の対象ラベルに含めない。
- Lean は未着手（次 tick でこの三ブロックの具体版・必要十分版・導出を進める）。

## 実行方法

```sh
sage check.sage
```
