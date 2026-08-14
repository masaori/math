# SageMath Check: 自由エネルギー密度の下からの評価

## 対象

**対象ラベル**: `def_constant_plus_configuration`, `claim_constant_plus_breaks_no_bond`,
`claim_free_energy_density_nonnegative`

- 実行日: 2026-08-14
- 結果: 有限標本検査がすべて通過（合計 165 件）
- 帰属: 可算側（$\sigma_+$ の配位性、$b(\sigma_+)=0$、1 項分離、$1\le Z_L(t)$ の有理数比較、
  $0<1/L^2$）は厳密。実対数に触れる検査だけ `RealBallField(256)`（ball 算術）を使う（下記の理由）。

## 何を確かめるか

- `def_constant_plus_configuration`: $L\in\{1,2,3\}$ で、すべての頂点に $+1$ を割り当てる
  定数写像が配位の全列挙に含まれること（厳密。3 件）。
- `claim_constant_plus_breaks_no_bond` の式変形の各行: 破れている辺の集合が空集合であること、
  $|\varnothing|=0$、$b(\sigma_+)=0$（厳密。9 件）。
- `claim_free_energy_density_nonnegative` の準備の第二の式変形の各行:
  $L\in\{1,2,3\}$ × 正の有理点 $t$ 7 点で、$t^0=1$、$t^{b(\sigma_+)}=1$、残りの和の非負性、
  1 項分離の等式 $t^{b(\sigma_+)}+\sum_{\sigma\ne\sigma_+}t^{b(\sigma)}=Z_L(t)$、
  $1\le Z_L(t)$（すべて厳密比較。105 件）。
- `claim_free_energy_density_nonnegative` の準備の第三: $1\le L^2$ と $0<1/L^2$
  （可算側 $\mathbb{Q}$ で厳密。6 件）。
- `claim_free_energy_density_nonnegative` の本体: $0\le\varphi_L(t)$ と $0\le\psi_L(t)$
  （ball 算術。標本はすべて $Z_L(t)>1$ なので ball の分離による厳密な不等式で確定。42 件）。

## 浮動小数点（ball 算術）を使う理由（記録）

実対数の値は一般に超越的で、厳密な閉形式の比較ができない。本文もこの章で
$\mathbb{R}$ への脱出を宣言している（`remark_real_field_escape`・`remark_real_logarithm`）。
そこで実対数に触れる検査だけ `RealBallField`（丸め誤差を厳密に包含する区間算術）を使い、
不等式は ball の分離で厳密に確定させる。可算側で済む検査には浮動小数点を使っていない。

## 範囲の注記（黙って狭めない）

- $t$ の標本は正の**有理数**である（$\iota_{\mathbb{Q}\to\mathbb{R}}$ を通した
  $\mathbb{R}$ の元のモデル）。普遍量化された主張そのものの証明は本文の人手証明が担う。
- $L\in\{1,2,3\}$ に限る（`free-energy-density` の検査と同じ範囲）。
- Lean は未着手（次 tick で具体版・必要十分版・導出を進める）。

## 実行方法

```sh
sage check.sage
```
