# SageMath Check: 自己双対条件は二次方程式と同値

## 対象

**対象ラベル**: `claim_kw_self_dual_quadratic_equivalence`

- 実行日: 2026-08-13
- 結果: 検査点 17 点すべて通過（同値の成立側 2 点、不成立側 15 点）
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

双対変換 $\mathrm{KW}(\xi):=(1-\xi)\cdot(1+\xi)^{-1}$（`def_kw_dual_transform`）について、
$1+\xi\ne0$ を満たす代数的数の検査点で

- 主張の同値: $\mathrm{KW}(\xi)=\xi$ と $\xi^2+2\xi-1=0$ の真偽が一致すること
  （`claim_kw_self_dual_quadratic_equivalence`）
- 証明の鎖の中間段
  - 準備の等式 $\mathrm{KW}(\xi)\cdot(1+\xi)=1-\xi$（仮定によらない）
  - 第二の方向の恒等式 $(1+\xi)\cdot(\mathrm{KW}(\xi)-\xi)=-(\xi^2+2\xi-1)$（仮定によらない）
  - 第一の方向の中間段 $\xi\cdot(1+\xi)=1-\xi$ と鎖の終端
    $((1-\xi)-\xi)+2\xi-1=0$（$\mathrm{KW}(\xi)=\xi$ が成り立つ点でのみ）

を突き合わせる。検査点は `kw-dual-transform-domain` と同じ 16 点
（有理数・無理な実代数的数（$\sqrt2$、$\sqrt2-1$ を含む）・虚の代数的数）に、
自己双対方程式のもう一方の根 $-1-\sqrt2$ を加えた 17 点である
（$1+(-1-\sqrt2)=-\sqrt2\ne0$ なので前提を満たす）。
成立側は二次方程式の 2 根 $\sqrt2-1$ と $-1-\sqrt2$ のちょうど 2 点であることも検査する。
`QQbar` の等号・非零判定は厳密（根分離）であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
