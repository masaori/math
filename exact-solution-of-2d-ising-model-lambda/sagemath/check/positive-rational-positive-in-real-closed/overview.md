# SageMath Check: 正の有理数は実閉部分体で正である

**対象ラベル**: `claim_positive_rational_positive_in_real_closed`

$R$ のモデルを `AA`（実代数的数体）に取り、次を厳密に検査する。

- 帰納法の各段 $n=c\cdot c$（$c\ne0$）$\Rightarrow$ $n+1=c\cdot c+1\cdot1=e\cdot e$（$e\ne0$）を
  $n=1$ から $32$ まで。
- 正の有理数の標本 $q\in\{1,\ 1/2,\ 2/3,\ 5,\ 7/4,\ 100/7\}$ について、
  $q=a/b$、$a=c\cdot c$、$b=d\cdot d$、$w=c\cdot d^{-1}$ の証人構成と
  $q-0=w\cdot w$、$w\ne0$。
- 反例側: 非正の有理数 $\{-1,\ -3/2,\ -9\}$ は $-q$ 側が平方（三分法の排他側）。

浮動小数点は使わない。

```sh
sage sagemath/check/positive-rational-positive-in-real-closed/check.sage
```

**2026-08-18 実行: すべて通過。**
