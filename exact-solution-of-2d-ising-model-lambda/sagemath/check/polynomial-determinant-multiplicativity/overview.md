# SageMath Check: 多項式行列式の乗法性

**対象ラベル**: `claim_polynomial_determinant_mul`

本文44等号を一行ずつ検算する。置換は値の列、添字写像は辞書で表し、両者の対応と両逆を各点で確認する。二つの置換の合成は右側から作用させる。検算は有限例であり、一般の有限集合についての証明は本文と Lean 三版が担う。

元の数1・2・3の全写像・全置換を列挙する。行列は各サイズで対角／三角・非有理係数の密行列・符号付き疎行列の三組を取り、円分体 $\mathbb Q(\zeta_8)$ 上の多項式として厳密に計算する。係数と行積は和を取る前にも全ての置換の組で確認する。

| ファイル | 式ペア | 状態 | 結果 |
|---|---|---|---|
| `check_injective_image_card.sage` | $\vert f(\mathcal J)\vert=\vert\mathcal J\vert$ | PASS | 9 等式 |
| `check_nonbijective_inner_zero.sage` | $I(f)=0$ | PASS | 69 等式 |
| `check_nonbijective_weight_substitute.sage` | $P(f)I(f)=P(f)\,0$ | PASS | 69 等式 |
| `check_nonbijective_weight_zero.sage` | $P(f)\,0=0$ | PASS | 69 等式 |
| `check_function_left_composition.sage` | $((\beta\circ\alpha)(\tau))(i)=\beta(\alpha(\tau))(i)$ | PASS | 23 等式 |
| `check_function_left_beta.sage` | $\beta(\alpha(\tau))(i)=\alpha(\tau)(i)$ | PASS | 23 等式 |
| `check_function_left_alpha.sage` | $\alpha(\tau)(i)=\tau(i)$ | PASS | 23 等式 |
| `check_function_right_composition.sage` | $((\alpha\circ\beta)(f))(i)=\alpha(\beta(f))(i)$ | PASS | 23 等式 |
| `check_function_right_alpha.sage` | $\alpha(\beta(f))(i)=\beta(f)(i)$ | PASS | 23 等式 |
| `check_function_right_beta.sage` | $\beta(f)(i)=f(i)$ | PASS | 23 等式 |
| `check_right_comp_left_S.sage` | $S_\tau(T_\tau(\pi))(i)=T_\tau(\pi)(\tau^{-1}(i))$ | PASS | 117 等式 |
| `check_right_comp_left_T.sage` | $T_\tau(\pi)(\tau^{-1}(i))=\pi(\tau(\tau^{-1}(i)))$ | PASS | 117 等式 |
| `check_right_comp_left_inverse.sage` | $\pi(\tau(\tau^{-1}(i)))=\pi(i)$ | PASS | 117 等式 |
| `check_right_comp_right_T.sage` | $T_\tau(S_\tau(\sigma))(i)=S_\tau(\sigma)(\tau(i))$ | PASS | 117 等式 |
| `check_right_comp_right_S.sage` | $S_\tau(\sigma)(\tau(i))=\sigma(\tau^{-1}(\tau(i)))$ | PASS | 117 等式 |
| `check_right_comp_right_inverse.sage` | $\sigma(\tau^{-1}(\tau(i)))=\sigma(i)$ | PASS | 117 等式 |
| `check_coefficient_definition.sage` | $c_{\pi\circ\tau}=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi\circ\tau))}$ | PASS | 41 等式 |
| `check_coefficient_sign_mul.sage` | $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi\circ\tau))}=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi)\operatorname{sgn}(\tau))}$ | PASS | 41 等式 |
| `check_coefficient_integer_map.sage` | $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi)\operatorname{sgn}(\tau))}=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))\,\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}$ | PASS | 41 等式 |
| `check_coefficient_constant_map.sage` | $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))\,\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))}\,\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}$ | PASS | 41 等式 |
| `check_coefficient_product.sage` | $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\pi))}\,\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}=c_\pi c_\tau$ | PASS | 41 等式 |
| `check_row_product_composition.sage` | $\prod_i B_{\tau(i),(\pi\circ\tau)(i)}=\prod_i B_{\tau(i),\pi(\tau(i))}$ | PASS | 123 等式 |
| `check_row_product_reindex.sage` | $\prod_i B_{\tau(i),\pi(\tau(i))}=\prod_j B_{j,\pi(j)}$ | PASS | 123 等式 |
| `check_inner_definition.sage` | $I(\alpha(\tau))=\sum_\sigma c_\sigma\prod_i B_{\alpha(\tau)(i),\sigma(i)}$ | PASS | 27 等式 |
| `check_inner_function_definition.sage` | $\sum_\sigma c_\sigma\prod_i B_{\alpha(\tau)(i),\sigma(i)}=\sum_\sigma c_\sigma\prod_i B_{\tau(i),\sigma(i)}$ | PASS | 27 等式 |
| `check_inner_permutation_reindex.sage` | $\sum_\sigma c_\sigma\prod_i B_{\tau(i),\sigma(i)}=\sum_\pi c_{T_\tau(\pi)}\prod_i B_{\tau(i),T_\tau(\pi)(i)}$ | PASS | 27 等式 |
| `check_inner_T_definition.sage` | $\sum_\pi c_{T_\tau(\pi)}\prod_i B_{\tau(i),T_\tau(\pi)(i)}=\sum_\pi c_{\pi\circ\tau}\prod_i B_{\tau(i),(\pi\circ\tau)(i)}$ | PASS | 27 等式 |
| `check_inner_composition.sage` | $\sum_\pi c_{\pi\circ\tau}\prod_i B_{\tau(i),(\pi\circ\tau)(i)}=\sum_\pi c_{\pi\circ\tau}\prod_i B_{\tau(i),\pi(\tau(i))}$ | PASS | 27 等式 |
| `check_inner_coefficient.sage` | $\sum_\pi c_{\pi\circ\tau}\prod_i B_{\tau(i),\pi(\tau(i))}=\sum_\pi(c_\pi c_\tau)\prod_i B_{\tau(i),\pi(\tau(i))}$ | PASS | 27 等式 |
| `check_inner_row_reindex.sage` | $\sum_\pi(c_\pi c_\tau)\prod_i B_{\tau(i),\pi(\tau(i))}=\sum_\pi(c_\pi c_\tau)\prod_j B_{j,\pi(j)}$ | PASS | 27 等式 |
| `check_inner_commute.sage` | $\sum_\pi(c_\pi c_\tau)\prod_j B_{j,\pi(j)}=\sum_\pi(c_\tau c_\pi)\prod_j B_{j,\pi(j)}$ | PASS | 27 等式 |
| `check_inner_associate.sage` | $\sum_\pi(c_\tau c_\pi)\prod_j B_{j,\pi(j)}=\sum_\pi c_\tau\left(c_\pi\prod_j B_{j,\pi(j)}\right)$ | PASS | 27 等式 |
| `check_inner_factor.sage` | $\sum_\pi c_\tau\left(c_\pi\prod_j B_{j,\pi(j)}\right)=c_\tau\sum_\pi c_\pi\prod_j B_{j,\pi(j)}$ | PASS | 27 等式 |
| `check_inner_determinant.sage` | $c_\tau\sum_\pi c_\pi\prod_j B_{j,\pi(j)}=c_\tau\det_x(B)$ | PASS | 27 等式 |
| `check_determinant_function_expansion.sage` | $\det_x(AB)=\sum_{f\in\mathcal F}P(f)I(f)$ | PASS | 9 等式 |
| `check_determinant_bijective_restriction.sage` | $\sum_{f\in\mathcal F}P(f)I(f)=\sum_{f\in\mathcal U}P(f)I(f)$ | PASS | 9 等式 |
| `check_determinant_permutation_reindex.sage` | $\sum_{f\in\mathcal U}P(f)I(f)=\sum_\tau P(\alpha(\tau))I(\alpha(\tau))$ | PASS | 9 等式 |
| `check_determinant_inner_substitute.sage` | $\sum_\tau P(\alpha(\tau))I(\alpha(\tau))=\sum_\tau P(\alpha(\tau))\bigl(c_\tau\det_x(B)\bigr)$ | PASS | 9 等式 |
| `check_determinant_associate.sage` | $\sum_\tau P(\alpha(\tau))\bigl(c_\tau\det_x(B)\bigr)=\sum_\tau\bigl(P(\alpha(\tau))c_\tau\bigr)\det_x(B)$ | PASS | 9 等式 |
| `check_determinant_commute.sage` | $\sum_\tau\bigl(P(\alpha(\tau))c_\tau\bigr)\det_x(B)=\sum_\tau\bigl(c_\tau P(\alpha(\tau))\bigr)\det_x(B)$ | PASS | 9 等式 |
| `check_determinant_factor.sage` | $\sum_\tau\bigl(c_\tau P(\alpha(\tau))\bigr)\det_x(B)=\left(\sum_\tau c_\tau P(\alpha(\tau))\right)\det_x(B)$ | PASS | 9 等式 |
| `check_determinant_outer_product.sage` | $\left(\sum_\tau c_\tau P(\alpha(\tau))\right)\det_x(B)=\left(\sum_\tau c_\tau\prod_i A_{i,\alpha(\tau)(i)}\right)\det_x(B)$ | PASS | 9 等式 |
| `check_determinant_function_definition.sage` | $\left(\sum_\tau c_\tau\prod_i A_{i,\alpha(\tau)(i)}\right)\det_x(B)=\left(\sum_\tau c_\tau\prod_i A_{i,\tau(i)}\right)\det_x(B)$ | PASS | 9 等式 |
| `check_determinant_result.sage` | $\left(\sum_\tau c_\tau\prod_i A_{i,\tau(i)}\right)\det_x(B)=\det_x(A)\det_x(B)$ | PASS | 9 等式 |

2026-10-10 実行: 全44本、計1,894等式（有限集合・整数849、多項式1,045）が通過した。実数体・複素数体への脱出と丸め誤差はない。

実行方法（プロジェクト直下）:

```sh
sage -c 'from pathlib import Path
for path in sorted(Path("sagemath/check/polynomial-determinant-multiplicativity").glob("check_*.sage")):
    __file__ = str(path.resolve())
    load(__file__)'
```
