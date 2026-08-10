# SageMath Check: シフト行列の特性多項式の値を 0 にする代数的数は 1 の $L$ 乗根である

## 対象

**対象ラベル**: `claim_shift_char_root_of_unity`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_algebraic_numbers`（代数的数の全体 $\overline{\mathbb{Q}}$）、
  `def_root_of_unity_set`（1 の冪根の全体 $\mu_n$）、
  `def_second_evaluation`（$\mathbb{Z}[x][t]$ の元の代数的数における値 $\mathrm{ev}_{\xi,z}$）

### 何を確定させるための検証か

これまでに置いた 5 つの主張（特性多項式が軌道ごとの因子の積であること・値を取る写像が
有限積を有限積へ写すこと・代数的数の有限積が 0 なら 0 である因子があること・
その因子の根が 1 の $\lvert O\rvert$ 乗根であること・軌道の元の個数が $L$ を割り切ること）を
合わせて、**シフト行列の固有値として現れうる代数的数が 1 の $L$ 乗根に限られること**を出す段である。
次の段（転送行列をシフト行列の固有空間へ分ける）が引く形そのものである。

確かめるのは次の 7 で、人手証明の段に 1 対 1 で対応する。

1. 鎖の第 2 段。$\chi_U=\prod_{O\in\mathcal{O}_L}(t^{\lvert O\rvert}+u)$
   （`claim_shift_char_orbit_factorization`）。$\chi_U$ は特性行列の行列式として直に計算して
   突き合わせる。
2. 鎖の第 3 段。$\mathrm{ev}_{\xi,z}(\prod_O f_O)=\prod_O\mathrm{ev}_{\xi,z}(f_O)$
   （`claim_second_evaluation_prod`）。
3. 0 である因子が取れること（`claim_qbar_prod_eq_zero`）。値が 0 になる $(\xi,z)$ について、
   $\mathrm{ev}_{\xi,z}(t^{\lvert O_0\rvert}+u)=0$ を満たす軌道 $O_0$ が実際に取れること。
4. その因子から $z^{\lvert O_0\rvert}=1$ が出ること（`claim_orbit_factor_root`）。
5. $\lvert O_0\rvert$ が $L$ を割り切ること（`claim_row_config_orbit_card` と
   `claim_row_config_minimal_period_divides_L`。ここでは全軌道について確かめる）。
6. 主張そのもの。$\mathrm{ev}_{\xi,z}(\chi_U)=0$ ならば $z^{L}=1$、すなわち $z\in\mu_L$。
7. 主張が空虚でないこと。値が 0 になる $z$ と、ならない $z$ の両方が実際にあること。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

代数的数の全体は SageMath の `QQbar`（厳密な代数的数の体）で表し、多項式の側は
`ZZ[x][t]` の中で計算した。**浮動小数点は使っていない**。
実数体にも複素数体にも入っていない。

## 走らせた範囲

$L=1,\dots,6$。$z$ は 1 の $L$ 乗根の全体（`QQbar` の中で $w^{L}-1$ の根として取る。$L$ 個）と、
$L=1,\dots,6$ では $\mu_L$ に属さない代数的数 4 個（$2$・$-3/4$・$\sqrt2$・1 の 7 乗根の 1 つ）。
$\xi$ は 3 個（$0$・$1$・$\sqrt2$）を走らせた（$\chi_U$ の係数は $x$ を含まないので値は $\xi$ に
よらないが、$\mathrm{ev}_{\xi,z}$ の定義どおり $\xi$ を動かして確かめている）。

1（$\chi_U$ を特性行列の行列式として直に計算して積と突き合わせる段）だけは $L=1,\dots,4$ に
絞った。行列の大きさが $2^{L}$ なので $L\ge5$ では $\mathbb{Z}[x][t]$ 上の 32 行 32 列以上の
行列式になり、この検証の実行時間に収まらないためである（同じ段は
`sagemath/check/shift-char-orbit-factorization` が $L=1,\dots,5$ で確かめている）。
$L\ge5$ では 1 を仮定して 2 以降を確かめた。

本文の主張は任意の $L$ と任意の $(\xi,z)$ についてのものなので、有限個で確かめたことは証明ではない。

## 実行

```sh
sage sagemath/check/shift-char-root-of-unity/check.sage
```

## 結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | 通過。1〜7 のすべてが成り立った。値が 0 になる $(\xi,z)$ は $L=1$ で 3 組から $L=6$ で 18 組、ならない組は各 $L$ で 12 組であり、主張は空虚でない |
