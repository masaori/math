# SageMath Check: 二次体の表示の一意性

## 対象

**対象ラベル**: `claim_quadratic_representation_unique`

- 実行日: 2026-08-13
- 結果: 通過（$s\cdot s=2$ を満たす `QQbar` の 2 根 × 有理数の標本で、
  $(a,b)\ne(a',b')$ の 4704 組すべてで $a+b\cdot s\ne a'+b'\cdot s$、
  十四段の鎖の恒等変形 4802 組、同一表示の場合 98 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の
$a,b,a',b'\in\mathbb{Q}$ について、$a+b\cdot s=a'+b'\cdot s$ ならば
$(a,b)=(a',b')$」。証明の組み立てを一行ずつ突き合わせる。

- 準備: $\alpha:=a+(-a')\in\mathbb{Q}$、$\beta:=b+(-b')\in\mathbb{Q}$
- 十四段の鎖: $\alpha+\beta\cdot s$ から $(a+b\cdot s)+((-b')\cdot s+(-a'))$ までの
  仮定に依存しない各段と、仮定の代入のあと $0$ まで落ちる各段を検査する
  （仮定の代入段は仮定が成り立つ標本、すなわち同一表示の場合でだけ検査する）
- 適用の段: $(\alpha,\beta)\ne(0,0)$ なら `claim_one_s_linearly_independent` の対偶で
  $\alpha+\beta\cdot s\ne0$、ゆえに $a+b\cdot s\ne a'+b'\cdot s$
- 六段の鎖二本: $a=a+0=\dots=\alpha+a'$ と $b=b+0=\dots=\beta+b'$ の恒等変形を
  全標本で、$\alpha=0$／$\beta=0$ の終段はその場合でだけ検査する

背理法ではないが、主張の仮定 $a+b\cdot s=a'+b'\cdot s$ は表示が同じ場合にしか
実現しない（それが主張の中身である）ので、表示が異なる標本では対偶で見た。
`QQ`・`QQbar` の等号判定は厳密である。

## 実行方法

```sh
sage check.sage
```
