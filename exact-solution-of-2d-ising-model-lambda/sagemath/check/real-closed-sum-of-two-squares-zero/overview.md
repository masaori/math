# SageMath Check: 実閉部分体の二つの平方の和が零なら、両方が零である

**対象ラベル**: `claim_real_closed_sum_of_two_squares_zero`

本文の証明（$(x+y\omega)(x-y\omega)=x\cdot x+y\cdot y$ と、$\overline{\mathbb Q}$ が零因子を持たないこと、
および一意表示の第 4 条件）を厳密計算で確かめる。浮動小数点は使わない。

$R$ のモデルは実代数的数体 `AA`、$\omega$ のモデルは `QQbar(I)`。固定した組の取り方に依存する主張は
本文でも述べていないので、ここでの検証は「モデルの 1 つで各段が成り立つこと」の確認である。

- $\omega\cdot\omega=-1$（第 3 条件）。
- 鎖の各段（差の積の展開・可換則と結合則・$\omega\cdot\omega=-1$ の代入・加法の逆元）。
- $x\cdot x+y\cdot y=0$ を満たすのは $x=y=0$ だけであること、および零でない場合は積が零でないこと。
- 一意表示の使い方（$0=a+b\omega$ を満たす組は $(0,0)$ だけ）と、$-y$ も $R$ の元であること。
- $R$ の外では平方の和が零になりうること（$\omega^2+1^2=0$。仮定 $x,y\in R$ が本質であることの確認）。

```sh
sage sagemath/check/real-closed-sum-of-two-squares-zero/check.sage
```

**2026-08-18 実行: すべて通過。**
