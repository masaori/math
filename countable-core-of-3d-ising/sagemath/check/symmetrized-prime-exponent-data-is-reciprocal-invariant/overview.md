# SageMath Check: 回文性で対称化した素指数データは逆数で不変である

**対象ラベル**: `claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`

$\sigma_L(q):=2\lambda(Z_L(q))-\#E_L\lambda(q)\in\Lambda$ について、箱の辺 $L=1,2$ と有理点 6 点で
$\mathbb Q$ と素指数ベクトルの厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $q^{\#E_L}Z_L(1/q)=Z_L(q)$（相反多項式の代入） | 全配位の和を `ZZ[X]` で計算し `QQ` で比較 | PASS |
| $\sigma_L(1/q)=\sigma_L(q)$ | `QQ(...).factor()` の素指数ベクトルを整数係数で結合して比較 | PASS |
| $L\ge2$、$q\neq1$ で $Z_L(q)\neq Z_L(1/q)$；$L=1$ では $\#E_1=0$、$Z_1=2$ で一致 | `QQ` の等式 | PASS（**この検査で $L=1$ の例外が見つかり、主張に $L\ge2$ の条件を加えた**） |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/symmetrized-prime-exponent-data-is-reciprocal-invariant/check.sage
```

**2026-08-17 実行: すべて通過。**
