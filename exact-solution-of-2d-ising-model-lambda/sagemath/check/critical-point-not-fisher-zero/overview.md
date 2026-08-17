# SageMath Check: 臨界点は Fisher 零点でない

**対象ラベル**: `claim_critical_point_not_fisher_zero`

$L\in\{1,2,3\}$ の全配位から多重度を数え、$s^2=2$ の二つの根について
$x_c=-1+s$ での評価 $\mathrm{Ev}^F_{x_c}(Z_L)=\sum_m\Omega_L(m)x_c^m$ が
零でないこと、$x_c$ が $Z_L$ の $\overline{\mathbb Q}$ における根の一覧に
現れないこと、値の表示 $\mathrm{rep}_s(\xi)$ が $(0,0)$ でなく正錐の条件を
満たすこと、および $(0,0)$ が正錐の三条件をすべて破ることを厳密計算で
確認する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-not-fisher-zero/check.sage
```

**2026-08-18 実行: すべて通過。**
