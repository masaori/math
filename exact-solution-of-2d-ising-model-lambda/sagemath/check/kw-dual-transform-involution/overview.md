# SageMath Check: 双対変換の対合性

## 対象

**対象ラベル**: `claim_kw_dual_transform_involution`

- 実行日: 2026-08-13
- 結果: 検査点 16 点すべて通過
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

双対変換 $\mathrm{KW}(\xi):=(1-\xi)\cdot(1+\xi)^{-1}$（`def_kw_dual_transform`）について、
$1+\xi\ne0$ を満たす代数的数の検査点で

- 主張 $\mathrm{KW}(\mathrm{KW}(\xi))=\xi$（`claim_kw_dual_transform_involution`）
- 証明の鎖の中間段
  - $1+\mathrm{KW}(\xi)=2\cdot(1+\xi)^{-1}$
  - $1-\mathrm{KW}(\xi)=2\xi\cdot(1+\xi)^{-1}$
  - $\mathrm{KW}(\mathrm{KW}(\xi))\cdot(1+\mathrm{KW}(\xi))=1-\mathrm{KW}(\xi)$
  - $\xi\cdot(1+\mathrm{KW}(\xi))=1-\mathrm{KW}(\xi)$
  - $(1+\mathrm{KW}(\xi))\cdot(\mathrm{KW}(\mathrm{KW}(\xi))-\xi)=0$

を突き合わせる。検査点は `kw-dual-transform-domain` と同じ 16 点
（有理数・無理な実代数的数（$\sqrt2$、$\sqrt2-1$ を含む）・虚の代数的数
（虚数単位、1 の 3 乗根・8 乗根））である。
`QQbar` の等号・非零判定は厳密（根分離）であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
