# SageMath Check: 順序付き部分体に虚数単位を足した表示の一意性

## 対象

**対象ラベル**: `claim_imaginary_unit_extension_unique_representation`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 1341）
- 帰属: 式鎖の恒等式は整係数多項式環 `ZZ[a,a1,b,b1,w]` とその分数体、標本は `QQbar` の厳密な元。浮動小数点は使わない。
- 標本: $F=\mathbb{Q}(\sqrt2)$（$\overline{\mathbb{Q}}$ の実の正の元が正錐を与える）、$\omega=i$。$F$ の元六つから係数の対を全て作り、対の組 1296 個を調べる。

## 何を確かめるか

- 式鎖 $(b-b')\omega=b\omega-b'\omega=(a+b\omega)-(a+b'\omega)=(a'+b'\omega)-(a+b'\omega)=a'-a$ の、仮定を使わない三つの等号（多項式の恒等式）と、仮定を使う等号が仮定の両辺の差に一致すること。
- 背理の段 $(b-b')^{-1}((b-b')\omega)=\omega$（分数体での恒等式）と、$b=b'+(b-b')$、$a=(a+b\omega)-b\omega$、$(a'+b'\omega)-b'\omega=a'$ の四則。
- 標本で、$a+b\omega=a'+b'\omega$ が成り立つのは $(a,b)=(a',b')$ のときだけであること、そのとき $(b-b')\omega=a'-a$。
- 仮定 $\omega\notin F$ を外すと結論が成り立たない例（$F=\mathbb{Q}(i)$ では $0+1\cdot i=i+0\cdot i$）。主張を弱めていないことの確認。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
