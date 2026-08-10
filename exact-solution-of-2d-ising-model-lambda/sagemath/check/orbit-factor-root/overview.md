# SageMath Check: 軌道ごとの因子の値を 0 にする代数的数は 1 の冪根である

## 対象

**対象ラベル**: `claim_orbit_factor_root`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて確かめる定義: `def_second_evaluation`
  （$\mathbb{Z}[x][t]$ の元の代数的数における値 $\mathrm{ev}_{\xi,z}$）

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの因子の積であり
（`claim_shift_char_orbit_factorization`）、各因子は $t^{\lvert O\rvert}+\iota(-\kappa(1))$ である。
この因子の値を 0 にする代数的数が 1 の $\lvert O\rvert$ 乗根であることが、
「特性多項式の根が 1 の $L$ 乗根である」への一歩である（残りは
$\lvert O\rvert\mid L$ と `claim_root_of_unity_divisor` が担う）。

確かめるのは次の 8 で、人手証明の段に 1 対 1 で対応する。

1. 定義どおりに係数の有限和として組んだ $\mathrm{ev}_{\xi,z}$ が、SageMath の代入と一致すること。
2. 鎖の第 1 段。$\mathrm{ev}$ が和を保つこと。
3. 鎖の第 2 段。$\mathrm{ev}_{\xi,z}(t^{m})=z^{m}$。
4. 鎖の第 3〜5 段。$\mathrm{ev}_{\xi,z}(\iota(-\kappa(1)))=(-\kappa(1))(\xi)=-(\kappa(1))(\xi)=-1$
   を 1 段ずつ別々の等式として。
5. 鎖の全体。$\mathrm{ev}_{\xi,z}(t^{m}+\iota(-\kappa(1)))=z^{m}-1$。
6. 主張そのもの。値が 0 であることと $z^{m}=1$ であることが一致すること（逆向きも確かめている）。
7. 主張が空虚でないこと。値が 0 にならない $z$ が実際にあること。
8. $m=0$ の場合。因子は $\mathbb{Z}[x][t]$ の零元であり値は常に 0、$\mu_0=\overline{\mathbb{Q}}$ なので
   結論も自動的に成り立つこと（仮定に $m\ge1$ を置いていないことの裏取り）。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

代数的数の全体は SageMath の `QQbar`（厳密な代数的数の体）で表した。
1 の $m$ 乗根の全体 $\mu_m$ は円分体 $\mathbb{Q}(\zeta_m)$ の中で全列挙してから `QQbar` へ移した。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。
実数体にも複素数体にも入っていない。

## 走らせた範囲

$m=0,\dots,8$。$\xi$ は 4 個（$0$・$1$・$-3/2$・$\sqrt2$）、$z$ は $\mu_m$ の全元と、
1 の冪根でない 3 個（$2$・$1/3$・$\sqrt2$）。
本文の主張は任意の $m,\xi,z$ についてのものなので、有限個で確かめたことは証明ではない。

## 実行

```sh
sage sagemath/check/orbit-factor-root/check.sage
```

## 結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | 通過。$m=0,\dots,8$ のすべてで 1〜8 が成り立った。とくに値が 0 であることと $z^{m}=1$ であることが一致し、1 の冪根でない $z$ では値が 0 にならない |
