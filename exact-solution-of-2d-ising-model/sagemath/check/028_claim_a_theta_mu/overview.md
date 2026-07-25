# SageMath Check: 028_claim_a_theta_mu

## 対象

**対象ラベル**: `equation_of_a_theta_mu` （structured-latex 側の安定識別子。Typst 廃止後はこれで対応付ける）

- ファイル: `parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ`
- 範囲: 全体 (Part A Step 1-8, Part B Step 9-18, Claim本体)

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_step9_11_gamma2_ratio_simplified.sage | Step 9-11: gamma_2比の簡約 (i*s_2*の約分) | PASS | OK |
| 02 | check_02_step12a_euler_cos_minus_isin.sage | Step 12a: c_1*cos-i*sin のEuler表示 | PASS | OK (tol=1e-6) |
| 03 | check_03_step12b_euler_cos_plus_isin.sage | Step 12b: c_1*cos+i*sin のEuler表示 | PASS | OK (tol=1e-6) |
| 04 | check_04_step13_gamma2_ratio_expanded.sage | Step 13: gamma_2比の展開形 | PASS | OK |
| 05 | check_05_step15_c1_ratio_eq_alpha_ratio.sage | Step 15: (c_1-1)/(c_1+1) = alpha_1/alpha_2 | PASS | OK |
| 06 | check_06_step16_s1c2_ratio_eq_alpha_sum.sage | Step 16: (2s_1c_2)/(c_1+1) = alpha_1+1/alpha_2 | PASS | OK |
| 07 | check_07_step17_factorization.sage | Step 17: 因数分解の検証 | PASS | OK (tol=1e-3, 値~1e10) |
| 08 | check_08_step18_gamma2_ratio_eq_alpha_product.sage | Step 18: gamma_2比 = alpha積の比 | PASS | OK |
| 09 | check_09_claim_a_eq_sqrt_gamma2_ratio.sage | Claim: a(theta_mu) = sqrt(gamma_2/gamma_2(-)) | PASS | OK |
| 10 | check_10_claim_cases_a_eq_sqrt_product_over_gamma2.sage | Claim cases: a = +/- sqrt(g2*g2-)/g2- | PASS | OK |
| 11 | check_11_step2_arg_gamma2_product_eq_pi.sage | Step 2: arg(gamma_2*gamma_2(-)) = pi | PASS | OK |
| 12 | check_12_step8_sqrt_product_div_gamma2.sage | Step 8: sqrt(g2*g2-)/g2- = cases(+/- sqrt(g2/g2-)) | PASS | OK |

## 備考

- check_02, 03: K1=10.4 で c_1≈5e8 となり絶対誤差が ~1e-7 になるが相対誤差は ~1e-16 (機械精度)。tol=1e-6 で PASS。
- check_07: K1=10.4 で (c_1+1)との積が ~1e10 になり絶対誤差が ~1e-5。相対誤差 ~1e-15。tol=1e-3 で PASS。

## 実行方法

各ファイルを個別に実行:
```bash
sage sagemath/check/028_claim_a_theta_mu/check_01_step9_11_gamma2_ratio_simplified.sage
```

全ファイルを一括実行:
```bash
for f in sagemath/check/028_claim_a_theta_mu/check_*.sage; do echo "=== $f ==="; sage "$f"; done
```
