# SageMath Check: 約数を指数として 1 になる代数的数は、その倍数を指数としても 1 になる

## 対象

**対象ラベル**: `claim_root_of_unity_divisor`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて確かめる定義: `def_algebraic_numbers`（代数的数の全体 $\overline{\mathbb{Q}}$）/
  `def_root_of_unity_set`（1 の冪根の全体 $\mu_n$）

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの因子の積として書けており
（`claim_shift_char_orbit_factorization`）、各因子は $t^{\lvert O\rvert}+\iota(-\kappa(1))$、
すなわちその根は 1 の $\lvert O\rvert$ 乗根である。軌道の元の個数は $L$ を割り切るので
（`claim_row_config_orbit_card` と `claim_row_config_minimal_period_divides_L`）、
その根は 1 の $L$ 乗根でもある——この最後の一歩を支えるのが本主張である。

$$
d\mid n\ \Longrightarrow\ \mu_{d}\subset\mu_{n}
$$

確かめるのは次の 6 で、人手証明の段に 1 対 1 で対応する。

1. $\mu_d$ の作り方が定義どおりであること（$d$ 個の相異なる元があり、どれも $d$ 乗して 1）。
2. 鎖の第 1 段。$n=dk$ と取れること。
3. 鎖の第 2〜4 段。$z^{n}=z^{dk}=(z^{d})^{k}=1^{k}=1$ を 1 段ずつ別々の等式として。
4. 主張そのもの。$\mu_d\subset\mu_n$。
5. 主張が空虚でないこと。$\mu_d$ が 2 元以上ある組が実際にあること。
6. 仮定 $d\mid n$ が外せないこと。$d$ が $n$ を割らないときは $\mu_d$ の中に
   $z^{n}\ne1$ となる元が実際にあること。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

$\overline{\mathbb{Q}}$ そのものを機械の上に置くことはできないので、円分体
$\mathbb{Q}(\zeta_m)$ の中で計算した。$x^{m}-1$ の根はすべて $\zeta_m$ の冪なので、
$\mu_m$ はこの体に収まる。すなわち $\mu_m$ の全列挙が有限個の厳密な元の列挙になる。
**浮動小数点は使っていない**（$\mathbb{Q}$ と $\mathbb{Q}(\zeta_m)$ の厳密計算だけ）。
実数体にも複素数体にも入っていない。

## 走らせた範囲

$d=1,\dots,8$ と $n=1,\dots,24$ のすべての組（192 組）。
うち $d\mid n$ の 64 組で 1〜4 を、$d$ が $n$ を割らない 128 組で 6 を確かめた。
本文の主張は任意の $d,n$ についてのものなので、有限個で確かめたことは証明ではない。

## 実行

```sh
sage sagemath/check/root-of-unity-divisor/check.sage
```

## 結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | 通過。$d\mid n$ の 64 組すべてで $\mu_d\subset\mu_n$。$d\nmid n$ の 128 組すべてで反例が存在（仮定は外せない）。$\mu_d$ の元の個数は $d$ に一致（$d=1,\dots,8$） |
