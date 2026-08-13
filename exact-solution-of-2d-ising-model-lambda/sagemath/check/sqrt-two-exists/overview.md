# SageMath Check: 二の平方根の存在

## 対象

**対象ラベル**: `claim_sqrt_two_exists`

- 実行日: 2026-08-13
- 結果: 通過（$t^2-2$ の 2 根の両方で証明の鎖の全段を厳密検査した）
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「ある $s\in\overline{\mathbb{Q}}$ が存在して $s\cdot s=2$」。証明の組み立てを一行ずつ突き合わせる。

- 準備: $g:=t^2+\widehat{-2}\in\overline{\mathbb{Q}}[t]$ の係数 $\mathrm{ac}_2(g)=1+0=1\ne0$（次数 1 以上であること）
- 根の存在: $\mathrm{aev}_s(g)=0$ を満たす $s$ が存在する（`QQbar` では根を厳密に列挙できる。根はちょうど 2 個）
- 鎖: $s\cdot s=\mathrm{aev}_s(t)\cdot\mathrm{aev}_s(t)=\mathrm{aev}_s(t\cdot t)=\mathrm{aev}_s(t^2)
  =\mathrm{aev}_s(t^2)+((-2)+2)=(\mathrm{aev}_s(t^2)+\mathrm{aev}_s(\widehat{-2}))+2
  =\mathrm{aev}_s(g)+2=0+2=2$ の各段を、2 根それぞれで検査する

おまけとして、2 根が互いに加法の逆元であり相異なることも観察する（後続セクション「自己双対方程式の因数分解と根の全体」の準備。主張そのものは存在だけを述べる）。

`QQbar` の等号判定は厳密（根分離）であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
