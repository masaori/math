# SageMath Check: 017_claim_T_V_hatZ_hatY

## 対象

**対象ラベル**: `T_V_hatZ_hatY` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`（ブロック `TV1_hatZ_hatY_018_claim_T_V_action`）
- 範囲: proof の Step 1〜6、すなわち行列積 `B_1(theta) B_2 B_1(theta) = A(theta)` の 4 成分
- 併せて検証: `duality_c2_star_eq_s2_star_c2`（(1,2)/(2,1) 成分の一致に必要な双対関係 `c_2^* = s_2^* c_2`）

原文（`_old/typst/parts/008_.../017_claim_T_VのhatZ_hatYへの作用.typ`）はこの行列積を
「mathematica に計算させたらステートメントは正しいことはわかったので、一旦具体の計算は飛ばす (0426)」
として未計算のまま残していた。人手証明を書き下したうえで、その結果をここで数値的に再確認する。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_B1B2B1_component_00.sage | (1,1) 成分: `(B_1 B_2 B_1)_{11} = gamma_1(theta)` | PASS | OK (tol=1e-5) |
| 02 | check_02_B1B2B1_component_11.sage | (2,2) 成分: `(B_1 B_2 B_1)_{22} = gamma_1(theta)` | PASS | OK (tol=1e-5) |
| 03 | check_03_B1B2B1_component_01.sage | (1,2) 成分: `(B_1 B_2 B_1)_{12} = gamma_2(theta)` | PASS | OK (tol=1e-5) |
| 04 | check_04_B1B2B1_component_10.sage | (2,1) 成分: `(B_1 B_2 B_1)_{21} = -gamma_2(-theta)` | PASS | OK (tol=1e-5) |
| 05 | check_05_duality_c2star_eq_s2star_c2.sage | `s_2^* = 1/s_2`, `c_2^* = c_2/s_2`, `c_2^* = s_2^* c_2` | PASS | OK (tol=既定 1e-10) |

`_prelude.sage` は `B_1(theta)`, `B_2`, `B_1 B_2 B_1` を定義する共通ファイルで、check 本体から `load()` する。

## 備考

- check_01〜04 の tol を 1e-5 にした理由: テストパラメータのうち `K1=10.4` では
  `c_1 = cosh(2 K_1) ~ 5e8` となり行列成分の絶対値が ~1e9 に達するため、倍精度演算の
  絶対誤差が ~1e-6 になる。全パラメータ・全 mu にわたる**相対**誤差の最大値は 2e-12
  （機械精度）であることを別途確認済み。既存の `028_claim_a_theta_mu` の check_02/03/07 と同じ事情。
- (1,2)/(2,1) 成分は、素の行列積では `c_2^*` が現れるのに対し `A(theta)` の `gamma_2` には
  `c_2`（星なし）が現れる。両者が一致するのは双対関係 `c_2^* = s_2^* c_2` によるもので、
  これを check_05 で独立に確認している。

## 実行方法

各ファイルを個別に実行:
```bash
sage sagemath/check/017_claim_T_V_hatZ_hatY/check_01_B1B2B1_component_00.sage
```

全ファイルを一括実行:
```bash
for f in sagemath/check/017_claim_T_V_hatZ_hatY/check_*.sage; do sage "$f"; done
```
