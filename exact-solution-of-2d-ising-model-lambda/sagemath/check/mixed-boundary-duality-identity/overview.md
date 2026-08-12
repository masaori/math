# SageMath Check: 四境界条件の混合の双対恒等式

## 対象

**対象ラベル**: `claim_mixed_boundary_duality_identity`

- 実行日: 2026-08-13
- 結果: `L=1,2,3` ですべて通過
- 帰属: 有限集合、`ZZ['x']` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張 $H^{0,0}_L+H^{0,1}_L+H^{1,0}_L+H^{1,1}_L=2^{L^2+1}G^{0,0}_L$ を、
本文の証明と独立に、全辺部分集合の数え上げで確かめる。

- 左辺: 全辺部分集合から偶部分グラフを選び、二つの巻き付き偶奇でセクターへ振り分け、
  高温展開の重み $(1+x)^{2L^2-|A|}(1-x)^{|A|}$ を足す（`def_high_temperature_sector_polynomial` と独立に一致）。
- 右辺: 自明セクター $(0,0)$ の各偶部分グラフに $x^{|A|}$ を足して $G^{0,0}_L$ を作り、
  $2^{L^2+1}$ 倍と比較する。
- 鎖の中間段の整合: 全配位から `partition_polynomial(L)` で $Z_L$ を独立に計算し、
  $H_L=2^{L^2}Z_L$（`claim_high_temperature_polynomial_identity`）と
  $Z_L=2G^{0,0}_L$（`claim_low_temperature_trivial_sector_expression`）の両段も突き合わせる。

## 実行方法

```sh
sage check.sage
```
