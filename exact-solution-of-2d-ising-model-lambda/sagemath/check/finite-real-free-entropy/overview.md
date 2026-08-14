# SageMath Check: 実対数と有限系の実自由エントロピー

## 対象

**対象ラベル**: `remark_real_logarithm`, `claim_real_log_one`, `def_finite_real_free_entropy`

- 実行日: 2026-08-14
- 結果: 有限標本検査がすべて通過（合計 98 件）
- 帰属: 可算側（$Z_L(t)$ の値・正値性）は `QQ`・`ZZ['x']` の厳密計算。
  実対数に触れる検査だけ `RealBallField(256)`（ball 算術）を使う（下記の理由）。

## 何を確かめるか

- `remark_real_logarithm`（乗法を加法へ移す性質）:
  $\log_{\mathbb{R}}(u\cdot v)-(\log_{\mathbb{R}}(u)+\log_{\mathbb{R}}(v))$ の ball が
  $0$ を含み半径が $2^{-200}$ 未満であること（$7\times7=49$ 件）。
  **ball 算術では等式は証明できないので、これは整合の確認である（証明ではない）。**
- `remark_real_logarithm`（狭義単調性）: $u<v$ のすべての標本対（21 件）で
  $\log_{\mathbb{R}}(u)<\log_{\mathbb{R}}(v)$。2 つの ball の分離による比較なので、
  **この不等式の成立は標本対について厳密**である。
- `claim_real_log_one`: $\log(1)=0$（Sage の記号計算で厳密）と、証明の鎖 6 行の
  各行の左辺・右辺の一致（記号計算で厳密。7 件）。
- `def_finite_real_free_entropy`: $L\in\{1,2,3\}$ × 正の有理点 $t$ 7 点の 21 件で、
  $Z_L(t)\in\mathbb{Q}$ かつ $Z_L(t)>0$（厳密比較。$\log_{\mathbb{R}}$ の定義域に入ること）、
  および $\varphi_L(t)=\log_{\mathbb{R}}(Z_L(t))$ の ball が有限に確定すること。

## 浮動小数点（ball 算術）を使う理由（記録）

実対数の値は一般に超越的で、厳密な閉形式の比較ができない。本文もこの章で
$\mathbb{R}$ への脱出を宣言している（`remark_real_field_escape`・`remark_real_logarithm`）。
そこで実対数に触れる検査だけ `RealBallField`（丸め誤差を厳密に包含する区間算術）を使い、
不等式は ball の分離で厳密に、等式は「差の ball が $0$ を含む」整合検査として行う。
どちらであるかは各検査の出力に明記した。可算側で済む検査（$Z_L(t)$ の値と正値性、
$\log(1)=0$ の記号計算）には浮動小数点を使っていない。

## 範囲の注記（黙って狭めない）

- $t$・$u$・$v$ の標本は正の**有理数**である（$\iota_{\mathbb{Q}\to\mathbb{R}}$ を通した
  $\mathbb{R}$ の元のモデル）。普遍量化された主張そのものの証明は本文の人手証明が担う。
- $L\in\{1,2,3\}$ に限る（`partition-value-positive-at-positive-real` の検査と同じ範囲）。
- Lean は未着手（次 tick で具体版・必要十分版・導出を書く）。

## 実行方法

```sh
sage check.sage
```
