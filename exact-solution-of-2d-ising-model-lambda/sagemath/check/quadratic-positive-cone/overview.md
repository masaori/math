# SageMath Check: 二次体の正錐

## 対象

**対象ラベル**: `def_quadratic_positive_cone`

（同じ検証で `def_quadratic_field_set`・`def_quadratic_representation_map`・
`remark_positive_cone_sign_choice` の内容も見る。）

- 実行日: 2026-08-13
- 結果: 通過（三条件と正値性の一致 361 組、根の取り替えの恒等式 722 組、
  表示の一意性の対偶 1200 組を厳密検査した）
- 帰属: `QQ` / `QQbar` / `AA`（実代数的数）の厳密計算。浮動小数点は使わない。
  `AA` の順序比較は根の分離による厳密判定であり、丸めは入らない。

## 何を確かめるか

定義は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と $\xi\in Q_s$、
$(a,b):=\mathrm{rep}_s(\xi)$ について、$\xi$ が正であるとは次の三条件の少なくとも一つ」:

1. $0\le a$ かつ $0\le b$ かつ $(a,b)\ne(0,0)$
2. $0<a$ かつ $b<0$ かつ $2\cdot b\cdot b<a\cdot a$
3. $a<0$ かつ $0<b$ かつ $a\cdot a<2\cdot b\cdot b$

- **cross**: $\mathbb{Q}$ の順序だけで書かれたこの三条件が、「$s$ を正の実代数的数
  $\sqrt2$ として読む埋め込みで $a+b\cdot\sqrt2>0$」と全標本
  （分子 $-4..4$、分母 $1..3$ の有理数の組）で一致する。定義が
  「$s$ を正と宣言する」順序を正しく符号化していることの裏取りである。
- **s-pos**: $\mathrm{rep}_s(s)=(0,1)$ が条件 1 を満たす（$s\in P_s$）。
- **swap**: $a+b\cdot s=a+(-b)\cdot(-s)$ が `QQbar` の厳密等号で成り立つ
  （根の取り替えの remark の台集合一致・表示の対応の裏取り）。
- **rep**: 標本の範囲で表示が一意である（`claim_quadratic_representation_unique`
  の対偶の再確認。本検査の well-defined 性の前提）。

## 実行方法

```sh
sage check.sage
```
