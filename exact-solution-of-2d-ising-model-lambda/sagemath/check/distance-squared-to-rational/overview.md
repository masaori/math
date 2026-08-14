# SageMath Check: 零点と有理点の距離の二乗

## 対象

**対象ラベル**: `def_distance_squared_to_rational`, `claim_distance_squared_zero_iff_equal`

- 実行日: 2026-08-14
- 結果: 有限標本検査がすべて通過
- 帰属: `QQ`・`AA`・`QQbar` の厳密計算。浮動小数点を使わない。

## 何を確かめるか

モデル $R=\texttt{AA}$（Sage の実代数的数体）、$\omega=\texttt{QQbar(I)}$ で、
本文の 2 ブロックに対応する計算を有限標本で確かめる。普遍量化された主張そのものの
証明は本文の人手証明と Lean が担い、この検査だけからは導かない。
Lean は具体版・必要十分版・導出が完了し、`lake build` と sorry 非依存検査を通過した。

- 一意表示（`def_real_closed_subfield` の第 4 条件のモデル）: $\xi$ サンプル 11 点
  （実の元と虚部を持つ元の両方）について、`real()`/`imag()` が返す組
  $(a,b)\in\texttt{AA}\times\texttt{AA}$ が $\xi=a+b\cdot\omega$ を満たすこと、
  および全対 121 組で $a_1+b_1\omega=a_2+b_2\omega$ ならば成分が一致すること
- 所属（`def_distance_squared_to_rational`）: $\xi$ 11 点 × $q$ 6 点の 66 組で
  $\mathrm{dsq}(\xi,q)=(a-q)\cdot(a-q)+b\cdot b$ が `AA` の元であること
- 零性と一致の同値（`claim_distance_squared_zero_iff_equal`）: 同じ 66 組で
  $\mathrm{dsq}(\xi,q)=0$ と $\xi=q$ の真偽が一致すること。あわせて第 1 の向きの段
  （$\xi=q$ なら $a=q$ かつ $b=0$）と、第 2 の向きの中の移項の等式
  （$b\ne0$ のとき $w:=(a-q)\cdot b^{-1}$ について
  $w\cdot w=((a-q)\cdot(a-q))\cdot(b\cdot b)^{-1}$）を検査する

## 範囲の注記（黙って狭めない）

サンプルは成分が次数 2 以下の実代数的数に収まるものに限る（`AA`・`QQbar` の
厳密比較は次数が高いと exactify の資源上限に当たるため。`real-closed-subfield`・
`real-algebraic-order` の検査と同じ理由）。検査の内容自体は緩めていない。
`AA`・`QQbar` の等号比較は厳密であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
